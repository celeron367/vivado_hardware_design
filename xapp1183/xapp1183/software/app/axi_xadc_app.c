#include <termios.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include<string.h>
#include <unistd.h>
#include <pthread.h>
#include "defines.h"
#include "cbuf.h"


/* Set up circular buffer */
CircularBuffer cb;
volatile int capture_flag = 1;

u8 AsciiToHex(u8 InAscii)
{
    u8 HexVal;
    if (((InAscii >= 0x41) & (InAscii <= 0x46)) | ((InAscii >=
						    0x61) & (InAscii <=
							     0x66))) {
	HexVal = (InAscii & 0x0F) + 0x9;
    } else if ((InAscii >= 0x30) | (InAscii <= 0x39)) {
	HexVal = InAscii - 0x30;
    } else {
	return XST_FAILURE;
    }
    return HexVal;
}

/* Thread capture ADC samples and put it to Circular buffer */
void *captureADCSamples(void *ptr)
{
    int fd = -1, i = 0;
    unsigned char buffer[FIFO_SIZE];
    
    //Open XADC dev node	
    fd = open("/dev/channel0", O_RDONLY);
    if(fd < 0){
    printf("captureThread :: dev open error \n");
    exit(XST_FAILURE);	
    }

    while (capture_flag) {

	if (ioctl(fd, AXI_XADC_DMA_CONFIG) == XST_SUCCESS) {

	    if (ioctl(fd, AXI_XADC_DMA_START) == XST_SUCCESS) {

		read(fd, buffer, FIFO_SIZE);
		//Do endian change
		unsigned char *ptr = buffer;
		for (i = 0; i < FIFO_SIZE; i += 2) {
		    unsigned char temp = ptr[i];
		    ptr[i] = ptr[i + 1];
		    ptr[i + 1] = temp;
		}
		//Write to buffer
		cbWrite(&cb, (ElemType *) buffer);

		if (ioctl(fd, AXI_XADC_DMA_STOP) != XST_SUCCESS) {
		    printf("XADC DMA STOP failed: %s\n", strerror(errno));
		}
	    } else {

		printf("XADC DMA START  failed: %s\n", strerror(errno));
	    }
	} else {

	    printf("XADC DMA CONFIG failed: %s\n", strerror(errno));

	}
    }

    printf("axi_xadc_app :: Data Capture Thread Terminated \n");
    close(fd);
    return NULL;
}

int main()
{


    int command = 0;
    int serial_fd = -1;
    struct termios oldtio, newtio;
    unsigned char uartbuffer[UART_BUF_SIZE];
    unsigned char newLineFeed[] = { 0xA };
    /* Open dev node for reading and writing and not as controlling tty
       because we don't want to get killed if linenoise sends CTRL-C.
     */
    serial_fd = open(DEV_NODE, O_RDWR | O_NOCTTY);
    if (serial_fd < 0) {
	perror(DEV_NODE);
	exit(XST_FAILURE);
    }

    tcgetattr(serial_fd, &oldtio);	/* save current serial port settings */
    bzero(&newtio, sizeof(newtio));	/* clear struct for new port settings */

    newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;
    newtio.c_iflag = IGNPAR;
    newtio.c_oflag = 0;

    /* set input mode (non-canonical, no echo,...) */
    newtio.c_lflag = 0;
    newtio.c_cc[VTIME] = 0;	/* inter-character timer unused */
    newtio.c_cc[VMIN] = 1;	/* blocking read until single charreceived */

    tcflush(serial_fd, TCIFLUSH);
    tcsetattr(serial_fd, TCSANOW, &newtio);
    //Initialize CB
    int testBufferSize = 20;	/* arbitrary size */
    cbInit(&cb, testBufferSize);
    ElemType elem;
    pthread_t t_datacapture;
    int rc = pthread_create(&t_datacapture, NULL, captureADCSamples, NULL);
    if (rc != EXIT_SUCCESS) {
	perror("pthread_create :: error \n");
	exit(XST_FAILURE);
    }
    while (1) {

	memset(uartbuffer, 0, UART_BUF_SIZE);
	int r = read(serial_fd, uartbuffer, UART_BUF_SIZE);

	if ((uartbuffer[0] == 'R') || (uartbuffer[0] == 'r')) {
	    command = (AsciiToHex(uartbuffer[4]) << 4) +
				AsciiToHex(uartbuffer[5]);
	    switch (command) {

	    case RAW_DATA_REG:
		//Read raw samples
		cbRead(&cb, &elem);
		write(serial_fd, elem.buf, FIFO_SIZE);
		tcdrain(serial_fd);
		write(serial_fd, &newLineFeed, 1);
		break;

	    case CONNECTION_EST_REG:
		//Dummy data for design version register
		write(serial_fd, uartbuffer, r);
		break;
	    }

	} else if ((uartbuffer[0] == 'E') || (uartbuffer[0] == 'e')) {
	    capture_flag = 0;
	    pthread_join(t_datacapture, NULL);
	    printf("Exiting application :v1 \n");
	    break;
	} else if ((uartbuffer[0] == 'W') || (uartbuffer[0] == 'w')) {
	    uartbuffer[0] = 'O';
	    uartbuffer[1] = 'K';
	    uartbuffer[2] = 0xa;
	    r = 3;
	    write(serial_fd, uartbuffer, r);
	}
    }
    //restore old terminal settings
    //Free the buffer
    cbFree(&cb);
    tcsetattr(serial_fd, TCSANOW, &oldtio);
    close(serial_fd);
    return EXIT_SUCCESS;

}
