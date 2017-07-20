/*
 * AXI XADC DMA driver.
 * Configures XADC in continuous stream and DMA in simple mode.
 * Uses DMA Client API to configure Xilinx DMA engine. 
 * Provide interface to read XADC Samples.
 * Copyright (C) 2012 Xilinx, Inc.
 * Copyright (C) 2012 Robert Armstrong
 *
 * Author: Radhey Shyam Pandey <radheys@xilinx.com>
 * 
 * Based on PL330 DMA Driver.
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
#include <asm/uaccess.h>
#include <linux/amba/xilinx_dma.h>
#include <linux/cdev.h>
#include <linux/dma-mapping.h>
#include <linux/dmaengine.h>
#include <linux/err.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include "axi_xadc_dma.h"

/*ADC channel name */ 
static const char adc_channels[][20] = {
    {"channel0"},
};

struct axi_xadc_dev *axi_xadc_dev;

/* Function Declarations */
static int axi_xadc_dma_init(void);
static int axi_xadc_dma_config(void);
static void axi_xadc_slave_rx_callback(void *completion);

/* filter_fn' routine will be called once for each free
channel which has a capability in 'mask'.It is expected to
return 'true' when the desired DMA channel is found
*/
static bool axi_xadc_filter(struct dma_chan *chan, void *param)
{
    if (*((int *) chan->private) == *(int *) param)
	return true;

    return false;
}
/* Pre DMA initialization . Request handle to Xilinx DMA engine
*/
static int axi_xadc_dma_init()
{
    dma_cap_mask_t mask;
    int status = FAILURE;
    /* slave transfer channels */
    enum dma_data_direction direction;
    u32 match;

    dma_cap_zero(mask);
    dma_cap_set(DMA_SLAVE | DMA_PRIVATE, mask);

    /* direction for data transfer */
    direction = DMA_DEV_TO_MEM;
    match = (direction & 0xFF) | XILINX_DMA_IP_DMA;
    axi_xadc_dev->rx_chan =
	dma_request_channel(mask, axi_xadc_filter, &match);

    if (axi_xadc_dev->rx_chan) {
	dev_info(&axi_xadc_dev->pdev->dev,
		 "Found DMA Channel RX device\n");
    } else {
	dev_err(&axi_xadc_dev->pdev->dev, "Did not find RX device\n");
	return status;

    }
    status = axi_xadc_dma_config();
    if (status) {
	dma_release_channel(axi_xadc_dev->rx_chan);
    }
    return status;
}

/*Configures buffer/flags,timeouts for DMA */
static int axi_xadc_dma_config()
{
    int ret = SUCCESS;
    int buf_size = AXI_XADC_BUFF_SIZE;
    struct dma_device *rx_dev = NULL;

    /* Allocate BD descriptors buffers */
    axi_xadc_dev->dsts = kzalloc(buf_size, GFP_KERNEL);
    if (!axi_xadc_dev->dsts)
	goto err_srcbuf;

    set_user_nice(current, 10);
    axi_xadc_dev->flags =
	DMA_CTRL_ACK | DMA_COMPL_SKIP_DEST_UNMAP | DMA_PREP_INTERRUPT;
    rx_dev = axi_xadc_dev->rx_chan->device;
    /* RX can takes longer */
    axi_xadc_dev->rx_tmo = msecs_to_jiffies(AXI_XADC_CALLBACK_TIMEOUTMSEC);
    return ret;

  err_srcbuf:
    return -ENOMEM;
}

static void axi_xadc_dma_start(void)
{
    /*flush pending transactions to HW */
    dma_async_issue_pending(axi_xadc_dev->rx_chan);
}

static void axi_xadc_read_reg(struct axi_xadc_dev *xadc_dev,
			      unsigned int reg, uint32_t * val)
{
    *val = readl(xadc_dev->xadc_virtaddr + reg);
}

/* Read interface to Adapter block */
static void axi_xadc_write_reg(struct axi_xadc_dev *xadc_dev,
			       unsigned int reg, uint32_t val)
{
    writel(val, xadc_dev->xadc_virtaddr + reg);
}
/* Write interface to Adapter block */
static void axi_fifo_write_reg(struct axi_xadc_dev *xadc_dev,
			       unsigned int reg, uint32_t val)
{
    writel(val, xadc_dev->axififo_virtaddr + reg);

}
/* Configures Xilinx ADC using AXI interface */
static void axi_xadc_setup(void)
{

    /* Initialize XADC block ,sets sampling frequency,
     * operating modes etc
     */
    int RegValue = 0;
    u8 SequencerMode = XSM_SEQ_MODE_SINGCHAN;
    u32 ChEnableMask = XSM_SEQ_CH_VPVN;
    u8 Divisor = XSM_DEF_DIVISOR;
    /*
     * Set the specified sequencer mode in the Configuration Register 1.
     */
    axi_xadc_read_reg(axi_xadc_dev, XSM_CFR1_OFFSET, &RegValue);
    RegValue &= (~XSM_CFR1_SEQ_VALID_MASK);
    RegValue |= ((SequencerMode << XSM_CFR1_SEQ_SHIFT) &
		 XSM_CFR1_SEQ_VALID_MASK);
    axi_xadc_write_reg(axi_xadc_dev, XSM_CFR1_OFFSET, RegValue);

    /*
     * Enable the specified channels in the ADC Channel Selection Sequencer
     * Registers.
     */
    axi_xadc_write_reg(axi_xadc_dev,
		       XSM_SEQ00_OFFSET,
		       (ChEnableMask & XSM_SEQ00_CH_VALID_MASK));

    axi_xadc_write_reg(axi_xadc_dev,
		       XSM_SEQ01_OFFSET,
		       (ChEnableMask >> XSM_SEQ_CH_AUX_SHIFT) &
		       XSM_SEQ01_CH_VALID_MASK);

    /* Write the divisor value into the Configuration Register #2 */
    axi_xadc_write_reg(axi_xadc_dev, XSM_CFR2_OFFSET,
		       Divisor << XSM_CFR2_CD_SHIFT);
    SequencerMode = XSM_SEQ_MODE_CONTINPASS;
    /* Set the specified sequencer mode in the Configuration Register #1 */
    axi_xadc_read_reg(axi_xadc_dev, XSM_CFR1_OFFSET, &RegValue);
    RegValue &= (~XSM_CFR1_SEQ_VALID_MASK);
    RegValue |= ((SequencerMode << XSM_CFR1_SEQ_SHIFT) &
		 XSM_CFR1_SEQ_VALID_MASK);
    axi_xadc_write_reg(axi_xadc_dev, XSM_CFR1_OFFSET, RegValue);

}
/* Configures Adapter block */
static void axi_fifo_setup(void)
{
    /* Program the no of samples 4K 
     * The FIFO adapter block generates an end of packet based on a coalesce count
     */
    axi_fifo_write_reg(axi_xadc_dev, 0x00, AXI_XADC_NO_OF_SAMPLES);
}

static void axi_xadc_dma_stop(struct dma_chan *chan)
{
    struct dma_device *chan_dev;
    /* Terminate DMA transactions */
    if (chan) {
	chan_dev = axi_xadc_dev->rx_chan->device;
	chan_dev->device_control(axi_xadc_dev->rx_chan, DMA_TERMINATE_ALL,
				 (unsigned long) NULL);
    }
}

static void axi_xadc_slave_rx_callback(void *completion)
{

    /*Unmap a single streaming mode DMA translation. */
    dma_unmap_single(axi_xadc_dev->rx_chan->device->dev,
		     axi_xadc_dev->dma_dsts, AXI_XADC_BUFF_SIZE,
		     DMA_DEV_TO_MEM);
    complete(&axi_xadc_dev->rx_cmp);
}

/* File operations */
int axi_xadc_dma_open(struct inode *inode, struct file *filp)
{

    unsigned int mn;
    mn = iminor(inode);
    /*Assign minor number for later reference */
    filp->private_data = (void *) mn;
    return SUCCESS;
}

int axi_xadc_dma_release(struct inode *inode, struct file *filp)
{
    return SUCCESS;
}

ssize_t axi_xadc_dma_read(struct file * filep, char __user * buf,
			  size_t count, loff_t * f_pos)
{
    int minor = 0, rx_tmo = 0, status = 0;
    /* Validation for read size */
    if (count > AXI_XADC_BUFF_SIZE) {
	dev_err(&axi_xadc_dev->pdev->dev, "improper buffer size \n");
	return EINVAL;
    }

    /* Query minor number.
     * @To be extended for multiple channel support
     */
    minor = (int) filep->private_data;
    rx_tmo = wait_for_completion_timeout(&axi_xadc_dev->rx_cmp,
				    axi_xadc_dev->rx_tmo);
    /* Check the status of DMA channel */
    status =dma_async_is_tx_complete(axi_xadc_dev->rx_chan,
				 axi_xadc_dev->rx_cookie, NULL, NULL);
    if (rx_tmo == 0) {
	dev_err(&axi_xadc_dev->pdev->dev, "RX test timed out\n");
	return -EAGAIN;
    }
    copy_to_user(buf, axi_xadc_dev->dsts, count);
    return count;
}

/* IOCTL calls provide interface to configure ,start and stop
   DMA engine */
static long axi_xadc_dma_ioctl(struct file *file,
			       unsigned int cmd, unsigned long arg)
{

    struct xilinx_dma_config config;
    struct dma_device *rx_dev = NULL;
    struct dma_async_tx_descriptor *rxd = NULL;

    rx_dev = axi_xadc_dev->rx_chan->device;
    switch (cmd) {
    case AXI_XADC_DMA_CONFIG:
	/*Configures DMA transaction */
	axi_xadc_dev->dma_dsts = dma_map_single(rx_dev->dev,
						axi_xadc_dev->
						dsts,
						AXI_XADC_BUFF_SIZE,
						DMA_DEV_TO_MEM);
	/* Preparing mapped scatter-gather list */
	sg_init_table(&axi_xadc_dev->rx_sg, AXI_XADC_BUF_COUNT);
	sg_dma_address(&axi_xadc_dev->rx_sg) = axi_xadc_dev->dma_dsts;
	/* Configures S2MM data length */
	sg_dma_len(&axi_xadc_dev->rx_sg) = AXI_XADC_BUFF_SIZE;

	/* Only one interrupt */
	config.coalesc = 1;
	config.delay = 0;
	rx_dev->device_control(axi_xadc_dev->rx_chan, DMA_SLAVE_CONFIG,
			       (unsigned long) &config);
	/* Obtaining DMA descriptor */
	rxd = rx_dev->device_prep_slave_sg(axi_xadc_dev->rx_chan,
					   &axi_xadc_dev->rx_sg,
					   AXI_XADC_BUF_COUNT,
					   DMA_DEV_TO_MEM,
					   axi_xadc_dev->flags, NULL);
	if (!rxd) {
	    dma_unmap_single(rx_dev->dev, axi_xadc_dev->dma_dsts,
			     AXI_XADC_BUFF_SIZE, DMA_DEV_TO_MEM);
	    dev_err(&axi_xadc_dev->pdev->dev, "dma_unmap  error \n");
	    return -EIO;
	}
	init_completion(&axi_xadc_dev->rx_cmp);
	/* Added callback information */
	rxd->callback = axi_xadc_slave_rx_callback;
	rxd->callback_param = &axi_xadc_dev->rx_cmp;
	/*Place transaction to DMA engine pending queue */
	axi_xadc_dev->rx_cookie = rxd->tx_submit(rxd);

	/* Check for dma submit errors */
	if (dma_submit_error(axi_xadc_dev->rx_cookie)) {
	    dev_err(&axi_xadc_dev->pdev->dev, "dma_submit error \n");
	    return -EIO;
	}
	break;
    case AXI_XADC_DMA_START:
	/* Start the DMA transaction */
	axi_xadc_dma_start();
	break;
    case AXI_XADC_DMA_STOP:
	/* Stop the DMA transaction */
	axi_xadc_dma_stop(axi_xadc_dev->rx_chan);
	break;
    default:
       return -EOPNOTSUPP;

    }
    return SUCCESS;
}

struct file_operations axi_xadc_fops = {
    .owner = THIS_MODULE,
    .read = axi_xadc_dma_read,
    .open = axi_xadc_dma_open,
    .unlocked_ioctl = axi_xadc_dma_ioctl,
    .release = axi_xadc_dma_release
};

static int axi_xadc_remove(struct platform_device *pdev)
{
    cdev_del(&axi_xadc_dev->cdev);
    device_destroy(axi_xadc_dev->axi_xadc_class,
		   MKDEV(MAJOR(axi_xadc_dev->devno),
			 AXI_XADC_MINOR_START));

    class_destroy(axi_xadc_dev->axi_xadc_class);
    unregister_chrdev_region(axi_xadc_dev->devno, AXI_XADC_MINOR_COUNT);

    /* Free up the DMA channel */
    dma_release_channel(axi_xadc_dev->rx_chan);

    /* Unmap the XADC I/O memory */
    if (axi_xadc_dev->xadc_virtaddr)
	iounmap(axi_xadc_dev->xadc_virtaddr);

    /* Unmap the AXI FIFO  memory */
    if (axi_xadc_dev->axififo_virtaddr)
	iounmap(axi_xadc_dev->axififo_virtaddr);

    if (axi_xadc_dev) {
	kfree(axi_xadc_dev);
    }
    dev_info(&pdev->dev, "XADC DMA Unload :: Success \n");
    return SUCCESS;
}

static int axi_xadc_probe(struct platform_device *pdev)
{
    int status = 0, i = 0;
    struct device_node *node=NULL;

    /*Allocate device node */
    node = pdev->dev.of_node;

    /* Allocate a private structure to manage this device */
    axi_xadc_dev = kmalloc(sizeof(struct axi_xadc_dev), GFP_KERNEL);
    if (axi_xadc_dev == NULL) {
	dev_err(&pdev->dev, "unable to allocate device structure\n");
	return -ENOMEM;
    }
    memset(axi_xadc_dev, 0, sizeof(struct axi_xadc_dev));

    /* IOMAP XADC registers */
    axi_xadc_dev->xadc_virtaddr = of_iomap(node, 0);
    if (!axi_xadc_dev->xadc_virtaddr) {
	dev_err(&pdev->dev, "unable to IOMAP xadc registers\n");
	status = -ENOMEM;
	goto fail1;
    }

    /* IOMAP AXI FIFO registers */
    axi_xadc_dev->axififo_virtaddr = of_iomap(node, 1);
    if (!axi_xadc_dev->axififo_virtaddr) {
	dev_err(&pdev->dev, "unable to IOMAP axififo registers\n");
	status = -ENOMEM;
	goto fail2;
    }

    axi_xadc_dev->pdev = pdev;
    status =alloc_chrdev_region(&axi_xadc_dev->devno, 
		0, AXI_XADC_MINOR_COUNT,MODULE_NAME);
    if (status < 0) {
	dev_err(&pdev->dev, "unable to alloc chrdev \n");
	goto fail3;
    }

    /* Register with the kernel as a character device */
    cdev_init(&axi_xadc_dev->cdev, &axi_xadc_fops);
    axi_xadc_dev->cdev.owner = THIS_MODULE;
    axi_xadc_dev->cdev.ops = &axi_xadc_fops;

    /* Initialize our device mutex */
    mutex_init(&axi_xadc_dev->mutex);

    status = cdev_add(&axi_xadc_dev->cdev, axi_xadc_dev->devno,
		 AXI_XADC_MINOR_COUNT);

    axi_xadc_dev->axi_xadc_class = class_create(THIS_MODULE, MODULE_NAME);


    //Creating device node for each ADC channel
    device_create(axi_xadc_dev->axi_xadc_class, NULL,
		  MKDEV(MAJOR(axi_xadc_dev->devno), AXI_XADC_MINOR_START),
		  NULL, adc_channels[i]);


    dev_info(&pdev->dev, "Xilinx PL XADC added successfully\n");

    /* Initializing AXI DMA */
    axi_xadc_dma_init();

    /* Program number of DMA samples to FIFO */
    axi_fifo_setup();

    /* Program XADC in continuous mode */
    axi_xadc_setup();

    dev_info(&pdev->dev, "AXI XADC configured \n");
    return SUCCESS;

    //Clean up
  fail3:
    iounmap(axi_xadc_dev->axififo_virtaddr);
  fail2:
    iounmap(axi_xadc_dev->xadc_virtaddr);
  fail1:
    kfree(axi_xadc_dev);
    return status;
}

static const struct of_device_id axi_xadc_dma_of_ids[] = {
    {.compatible = "xlnx,axi-xadc-dma",},
};

static struct platform_driver axi_xadc_dma_of_driver = {
    .driver = {
	       .name = MODULE_NAME,
	       .owner = THIS_MODULE,
	       .of_match_table = axi_xadc_dma_of_ids,
	       },
    .probe = axi_xadc_probe,
    .remove = axi_xadc_remove,
};

module_platform_driver(axi_xadc_dma_of_driver);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Xilinx AXI XADC DMA driver");
MODULE_AUTHOR("Xilinx, Inc.");
MODULE_VERSION("1.00a");
