.text
.align 4
.global strcat
.type strcat, %function


strcat:
	push {ip, lr} 
	
loop_over_dest:          
	ldrb r3, [r0]        //Πρωτα διαβαζω το dest string μεχρι να τελειωσει
	cmp r3, #0			 //Αν βρω 0 τελειωσε
	beq concat	
	add r0, r0, #1
	bal loop_over_dest
	
concat:                  //Αντικαθιστω το /0 που υπηρχε στο dest string με τον πρωτα χαρακτηρα του src
	ldrb r2, [r1]        //Αντιγραφω το υπολοιπο string
	cmp r2, #0
	beq exit
	strb r2, [r0]
	add r0, r0, #1
	add r1, r1, #1
	bal concat

exit:
	mov r4, #0           //Βαζω το 0 στο τελος του string
	strb r4, [r0]      
	pop {ip, pc}
	
