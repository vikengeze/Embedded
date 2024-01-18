.text
.align 4
.global transform
.type transform,%function

.extern printf
.extern scanf
.extern strlen
.extern getchar

transform:
	push {ip, lr}  
transform_loop:  		//Για καθε χαρακτηρα: 
	cmp r3, #47  
	ble done		    //Αν ειναι μικροτερο του '0' -> done
	cmp r3, #57
	ble number   		//Αν ειναι αριθμος -> number
	cmp r3, #64
	ble done    		//Αν ειναι special character -> done
	cmp r3, #90
	ble upper  		    //Αν ειναι κεφαλαιο -> upper
	cmp r3, #96
	ble done  		    //Αν ειναι special character -> done
	cmp r3, #122
	ble lower  		    //Αν ειναι πεζο -> lower   
	bal done     		//Αλλιως(αν ειναι δηλαδη {, |, κ.ο.κ.) -> done

number:
	cmp r3, #52         //Συγκρινω με το 4
	addle r3, r3, #5    //Αν ειναι μικροτερο ή ισο προσθετω 5
	subgt r3, r3, #5    //Αν ειναι μεγαλυτερο αφαιρω 5
	bal done

upper:
	add r3, r3, #32     //Προσθετω 32 για να παω στο πεζο γραμμα
	bal done
	
lower:
	sub r3, #32         //Αφαιρω 32 για να παω στο κεφαλαιο γραμμα
	
done:
	strb r3, [r10]      // αποθηκευω το αποτελεσμα μου και προχωραω στον επομενο χαρακτηρα εως οτου εχω length 0
	ldrb r3, [r10, #1]!
	subs r0, r0, #1
	bne transform_loop
	
	pop {ip, pc} 

