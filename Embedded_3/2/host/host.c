#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <stdio.h>

#define BAUDRATE B9600
#define _POSIX_SOURCE 1


int main(int argc, char **argv)
{
	ssize_t reader;
	int fd, ret, len;
	char buf[255], cmd[1024];

	if (argc != 2) {   
		fprintf(stderr, "Please insert target file(/dev/pts/x) \n");
		exit(1);
	}

	const char *DEVICE = argv[1];
	
	snprintf(cmd, sizeof(cmd), "sudo chmod 777 %s;", argv[1]);  //Θελω να δωσω full permissions στο device που θα χρησιμοποιησω
	cmd[sizeof(cmd)-1] = '\0';  //οποτε πρεπει να αποθηκευσω την εντολη για να την τρεξω απτην C
	ret = system(cmd);  //τρεχω την chmod 
	if (ret < 0) {
		perror("chmod");
		exit(1);
	}

	fd = open(DEVICE, O_RDWR | O_NOCTTY | O_NDELAY); //Ανοιγω το device μου με file descriptor το fd
	if (fd < 0) {
		perror(DEVICE);
		exit(1);
	}

	struct termios term;  //Φτιαχνω το port 

	term.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;

	term.c_cc[VMIN] = 1;	//Block read μεχρι να φτασει ο 1ος χαρακτηρας
	
	tcsetattr(fd,TCSANOW,&term);

	printf("Host: Please give a string to send to guest: \n");

	reader = read(STDIN_FILENO, buf, 65);  //διαβαζω το string απτην εισοδο
	if (reader == -1) {
		perror("input_read");
		exit(1);
	}
	len = reader;
	if (len >= 65){
		fprintf(stderr, "Input a string smaller than 64 bytes\n");
		exit(1);
	}
	buf[len-1]='\0';
	
	fprintf(stderr, "Host: Writing in port...\n");

	ssize_t writer; //Γραφω το string που διαβασα στο port
	int idx=0;
	do {
		writer = write(fd, buf+idx, 1);
		if (writer == -1) {
			perror("port_write");
			exit(1);
		}
		idx += writer;
	} while (idx < len);
	
	fprintf(stdout, "Host: Writing completed!\n");
	fprintf(stdout, "Host: Receiving from guest...\n");
	fprintf(stdout, "Guest: \n");

	sleep(2);

	reader = read(fd, buf, 255); //Διαβαζω και παλι απτο port
	if (reader == -1) {
		perror("port_read");
		exit(1);
	}
	
	writer = write(STDOUT_FILENO, buf, reader); //Η τελικη print για να εμφανισω το μηνυμα του guest
		if (writer == -1) {
			perror("out_write");
			exit(1);
	}
	fprintf(stdout, "%ld\n", writer);
	fprintf(stdout, "\n");
	close(fd);

	return 0;
}
