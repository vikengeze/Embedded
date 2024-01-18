.text
.global main
.extern printf
.extern tcsetattr

str_man:
	stmfd sp!, {r4-r6, ip, lr}
	mov r4, #0
	mov r2, r0
	mov r3, r0

	str_man_loop:
    	ldrb r1, [r3]			//Βαζω τον χαρακτηρα στον r1
    	tst r1, r1				//Αν τελειωσε το string, παω στην str_man_cnt που με επιστρεφει
    	beq str_man_cnt			//Στον r5 εχω το πληθος που εμφανιστηκε ο πιο συχνος χαρακτηρας και στον r4 το ποιος ειναι
    	ldrb r1, [r3], #1
    	bl strcmp				//Χρησιμοποιω την strcmp για να δω ποσες φορες υπαρχει ο συγκεκριμενος χαρακτηρας
	    cmp r0, r4				//Θελω να δω αν ο χαρακτηρας ειναι ο πιο συχνος
	    blt str_man_loop		//Αν δεν ειναι παω στον επομενο
	    beq str_man_equal		//Αν εχω ακριβως ιδιο πληθος εμφανισεων με ενδιαφερουν οι κωδικοι ascii
	    mov r5, r1				//Αν εμφανιζεται περισσοτερες φορες ειναι πλεον ο πιο συχνος
	    mov r4, r0			
	    b str_man_loop
	
	str_man_equal:
	    cmp r1, r5
	    bge str_man_loop
	    mov r5, r1
	    b str_man_loop
	
	str_man_cnt:
	    mov r1, r4				//O r0 εχει το πληθος
	    mov r2, r5				//O r1 εχει τον χαρακτηρα
	    ldmfd sp!, {r4-r6, ip, lr}
	    bx lr
	
strcmp:							//To string ειναι στον r2 και ο χαρακτηρας στον r1
	stmfd sp!, {r1-r3, ip, lr}
	mov r0, #0

	strcmp_loop:
	    ldrb r3, [r2]
	    tst r3, r3				//Ελεγχω με AND αν εχω τελος του string
	    beq strcmp_cnt		
	    ldrb r3, [r2], #1
	    cmp r1, r3
	    bne strcmp_loop
	    add r0, r0, #1	
	    b strcmp_loop

	strcmp_cnt:
	    ldmfd sp!, {r1-r3, ip, lr}
	    bx lr

main:
	stmfd sp!, {r4-r9}
	
	ldr r0, =pathname  			//Ανοιγω το device που χρησιμοποιω
	ldr r2, =flags
	ldr r1, [r2]
	mov r7, #5 					//open syscall
	swi 0
	mov r6, r0					//Βαζω το file descriptor στον r6
	
set_device:
	mov r0, r6
	mov r1, #0
	ldr r2, =term				//Κανω load τη διευθυνση του termios struct
	bl tcsetattr

	mov r8, #0					//Ο r8 ειναι ενας counter για το ποσους χαρακτηρες εχω διαβασει

read:
	mov r0, r6	 				//Διαβαζω τους χαρακτηρες
	ldr r1, =input_char
	mov r2, #1
	mov r7, #3
	swi 0
	cmp r0, #1
	bne read					//Αν δεν εχω διαβασει byte, διαβαζω κ παλι
	
	ldr r0, =input_char 		//φτιαχνω το string
	ldr r1, [r0]
	ldr r2, =string
	str r1, [r2, r8]

	add r8, r8, #1

	ldr r1, =input_char
	ldrb r2, [r1]
	cmp r2, #0
	bne read					//Αν εχω null χαρακτηρα στο read σταματαω να διαβαζω

	ldr r0, =string 			//καλω το string manipulation
	bl str_man

	mov r8, r1					//Επιστρεφω στον r8 που εχει τη συχνοτητα
	mov r9, r2					//Επιστρεφω στον r9 που εχει τον χαρακτηρα

	push {ip, lr} 				//snprintf για το format_2
	ldr r0, =output
	mov r1, #35
	ldr r2, =format_2
	mov r3, r9
	bl snprintf
	pop {ip, lr}

	mov r0, r6					//Γραφω το string απο το buffer μεσω της θυρας
	ldr r1, =output
	mov r2, #34
	mov r7, #4
	swi 0
 
	push {ip, lr}				//snprintf για το format_3
	ldr r0, =output
	mov r1, #28
	ldr r2, =format_3
	mov r3, r8
	bl snprintf
	pop {ip, lr}

	mov r0, r6					//write
	ldr r1, =output
	mov r2, #27
	mov r7, #4
	swi 0

exit:
	mov r0, r6 					//κλεισε το serial port
	mov r7, #6
	swi 0

	ldmfd sp!, {r4-r9}			//exit
	mov r0, #0	
	mov r7, #1	
	swi 0

.data
	pathname: .asciz "/dev/ttyAMA0"
	flags: .word 0x00000902
	string: .space 64
	format_2: .ascii "The most frequent character is '%c'"
	format_3: .ascii " and it appeared %d times.\n"
	input_char: .ascii "a"
	output: .space 35

	term:	.word 0x00000000		/* c_iflag		*/
			.word 0x00000000		/* c_oflag 		*/
			.word 0x000008bd		/* c_cflag 		*/   //Η τιμη προεκυψε απο τα flags που χρησιμοποιησαμε στον κωδικα του host
			.word 0x00000000		/* c_lflag 		*/
			.byte 0x00				/* c_line 		*/
			.word 0x00000000		/* c_cc[0-3] 	*/
			.word 0x00010000		/* c_cc[4-7] 	*/	 //VMIN = 1 -> 6o bit = 01
			.word 0x00000000		/* c_cc[8-11] 	*/
			.word 0x00000000		/* c_cc[12-15] 	*/
			.word 0x00000000		/* c_cc[16-19] 	*/
			.word 0x00000000		/* c_cc[20-23] 	*/
			.word 0x00000000		/* c_cc[24-27] 	*/
			.word 0x00000000		/* c_cc[28-31] 	*/
			.byte 0x00				/* padding 		*/
			.hword 0x0000			/* padding 		*/
			.word 0x0000000			/* c_ispeed 	*/
			.word 0x0000000			/* c_ospeed 	*/

