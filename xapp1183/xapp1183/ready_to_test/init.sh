#!/bin/sh

echo "Auto-Starting AXI XADC DMA APP  ..."


# Create VDMA device node
if [ ! -f /dev/xvdma ]
then
  mknod /dev/xvdma c 10 224
fi

echo "a) Load AXI XADC DMA driver "
insmod /mnt/axi_xadc_dma.ko

echo "b) Run AXI XADC user app "
/mnt/axi_xadc_app
