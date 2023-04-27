.data
	string: .asciiz "        oi      essa      string     esta       errada      e um teste  "

.text
	addi $a1, $a1, 32 # a1 espaco
	la $a0, string # a0 endereco da string
	lb $t8, 0($a0) # t8 primeira letra
LOOP:	
	lb $t8, 0($a0) 
	beq $t8, $zero, FIM
	beq $t8, $a1, ESPACO
	addi $a0 , $a0, 1
	j LOOP
	
ESPACO:
	la $t4, 0($a0) #t4 end do espaco
	la $t3, 1($t4) #t3 dpois do espaco
	
ESPACOLOOP:
	lb $t9, 0($t3) #t9 load letra
	sb $t9, 0($t4) #t9 store letra um endereco atras
	addi $t3, $t3, 1
	addi $t4, $t4, 1
	beq $t9, $zero, LOOP
	j ESPACOLOOP
FIM:
	
	li $v0 , 4
	la $v1 , string
	la, $a0, string
	syscall
	#jr $ra
	
	
