.PHONY: clean
CC=arm-xilinx-linux-gnueabi-gcc
CFLAGS=-Wall

all: axi_xadc_app
axi_xadc_app: axi_xadc_app.o cbuf.o
	$(CC)  -lpthread -o axi_xadc_app axi_xadc_app.o cbuf.o


clean:
	rm -rf app *.o axi_xadc_app 
