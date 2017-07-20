#Makefile for AXI XADC DMA Driver
#(ZYNQ_AXI_XADC_HOME) points to XAPP1183 package
TARGET  = axi_xadc_dma
#Set KDIR to kernel repository path
KDIR     = $(ZYNQ_AXI_XADC_HOME)/linux-xlnx
obj-m   := $(TARGET).o 

all:
	$(MAKE) ARCH=arm $(CFLAGS) -C $(KDIR) M=$(PWD) modules

$(TARGET).o:$(OBJS)
	$(LD) $(LD_FLAGS) -r -o $@ $(OBJS)

clean:
	rm -rf .tmp_versions *.a *.o *.ko *.bak .*.d .*.cmd *.mod.c Module.* modules.order

