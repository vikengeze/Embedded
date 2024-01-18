.text
.align 4
.global strcmp
.type strcmp, %function


strcmp:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r0]
	ldrb r3, [r1]

	cmp r2, #0       //Αν εχει τελειωσει το πρωτο string
	beq exit         
	cmp r3, #0	     //Αν εχει τελειωσει το δευτερο string
	beq exit		 
	cmp r2, r3	     //Η αν τα δυο string ειναι ισα
	bne exit		 //Κανω exit για να αποφασισω ποιο ειναι μεγαλυτερο

	add r0, r0, #1   //counter1++
	add r1, r1, #1	 //counter2++
	bal loop         //Παω στους επομενους χαρακτηρες


exit:
	cmp r2, r3	     //Ενας απο τα δυο string(στις 2 πρωτες περιπτωσεις) θα εχει τελειωσει, δηλαδη θα εχει επομενο χαρακτηρα το 0
	movlt r0, #-1    //Αν ο char του πρωτου string ειναι μικροτερος, επιστρεφω -1
	movgt r0, #1     //Αν ο char του πρωτου string ειναι μεγαλυτερο, επιστρεφω 1
	moveq r0, #0	 //Αν οι chars ειναι ισοι, τα 2 strings εχουν ιδιο μηκος και επιστρεφω 0
	pop {ip, pc}
	
	
