.text
.align 4
.global strcpy
.type strcpy, %function


strcpy:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r1]    //Κανω load τους χαρακτηρες μεχρι να διαβασω 0, δηλαδη να τελειωσει το string
	cmp r2, #0
	beq exit
	strb r2, [r0]    //Κανω store τον χαρακτηρα του source στον προορισμο
	add r0, r0, #1   //counter1++
	add r1, r1, #1   //counter2++
	bal loop    
	
exit:
	mov r4, #0 
	strb r4, [r0]
	pop {ip, pc}
	
