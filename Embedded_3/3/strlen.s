.text
.align 4
.global strlen
.type strlen, %function


strlen:
	push {ip, lr}
	mov r2, #0         //r2 ειναι ο counter μου(που περιεχει το μηκος)
loop:
	ldrb r3, [r0]      //Προχωραω απλως στον επομενο χαρακτηρα μεχρι να μην υπαρχουν αλλοι
	cmp r3, #0
	beq exit
	add r2,r2,#1       //counter++
	add r0, r0, #1    
	bal loop


	
exit:
	mov r0, r2         //return counter στον r0
	pop {ip, pc}
	
