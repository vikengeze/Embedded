.text
.global main
.extern printf
.extern scanf
.extern strlen
.extern getchar
.extern transform
.extern strcpy

main:
	push {ip, lr}     
loop:
	ldr r0, =str          //Dest param για την strcpy
	ldr r1, =cleanstr     //Src param για την strcpy
	bl strcpy             //"Μηδενιζω" το str σε cleanstr σε καθε loop

	ldr r0, =print_str    //Format param για την printf
	ldr r1, =string       //Text param για την printf
	bl printf             //Η printf για το "Input a string... " prompt

	ldr r0, =input        //Format param για την scanf
	ldr r1, =str          //Το str ειναι κενο απο παραπανω, οποτε βαζω το αποτελεσμα σε αυτο
	bl scanf              //H scanf διαβαζει ολη τη γραμμη μεχρι το newline 
	bl getchar            //Διαγραφω τα space

	ldr r0, =str          //Εφοσον μας νοιαζουν μονο οι 33 πρωτοι χαρακτηρες
	bl strlen	      	  //Αν εχουμε περισσοτερους(δηλαδη length>33)
	cmp r0, #33			  
	movgt r0, #33         //Οριζουμε και παλι length=33

	ldr r10, =str         
	ldrb r3, [r10]		  
	add r11, r10, r0
	mov r12, #0           //Ο,τι ακολουθει μετα τους 33 πρωτους χαρακτηρες, το πεταμε
	strb r12, [r11]

	cmp r0, #1            //Αν δεν εχω ακριβως εναν χαρακτηρα θελω να κανω το transform
	blne transform        //Branch and link στην transform
	cmp r0, #1            //Αν εχω ακριβως 1 χαρακτηρα πρεπει να δω τι ειναι
	beq check

	bal printer
printer:
	ldr r0, =output_str   //Το format param της printf
	ldr r1, =str          //Το str ειναι το τελικο string που θελουμε να κανουμε print
	bl printf

	bal loop              //Θελω συνεχη λειτουργια οποτε η μονη εξοδος ειναι το beq exit λογω q ή Q
	pop {ip, pc} 
check:				
	cmp r3, #81			  //Πρακτικα η περιπτωση οπου εχουμε ακριβως 1 χαρακτηρα
	beq exit 			  //Πρεπει να τσεκαρουμε πρωτα αν ειναι q ή Q, οποτε και κανουμε exit
	cmp r3, #113
	beq exit
	blne transform		  //Αν περασει και απο τα 2 beq τον κανουμε transform
	bal printer			
exit:
	ldr r0, =exit_str     //printf("Exiting....")
	bl printf
	pop {ip, pc} 

.data
	string: .ascii "Input a string up to 32 chars long: \0"
	str_len = . - string
	input: .ascii "%[^\n]s\0"  //Το regex που θα χρησιμοποιησω για την scanf
	str: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	cleanstr: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0" //αδειο string που κραταω για να "μηδενιζω" σε καθε λουπα το str
	len = . - str
	output_str: .ascii "%s\n\0" //Format param για το τελικο αποτελεσμα που θελω να παει στην επομενη γραμμη
	print_str: .ascii "%s\0"   //Format param για το input prompt που θελω να μεινει στην ιδια γραμμη
	exit_str: .ascii "Exiting....\n\0"
.end
	
