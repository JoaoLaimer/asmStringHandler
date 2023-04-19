.data
	string: .asciiz "Aoi    Essa string esta errada e um teste"

.text
	addi $a1, $a1, 32 # a1 espaco
	la $a0, string # a0 endereco da string
	lb $t8, 0($a0) # t8 primeira letra
	sle $t7, $t8, 90  # ja é MAIUSCULO
	beq $t7, 1, LOOP
	addi $t8, $t8, -32 # transforma a primeira letra em maiusculo
	sb $t8, 0($a0) # salva a letra na string
LOOP:	
	addi $a0 , $a0, 1
	lb $t8, 0($a0) 
	beq $t8, $zero, FIM
	beq $t8, $a1, ESPACO
	j LOOP
	
ESPACO:
	addi $a0 , $a0, 1 #dpois do espaco 
		
MAIUSCULO:
	lb $t3, 0($a0) #t3 load letra
	sle $t7, $t3, 90  # ja é MAIUSCULO
	beq $t7, 1, LOOP  # se for maiusculo volta pro loop
	beq $t3, 32, LOOP # se proximo e espaco verifica de novo
	add $t3, $t3, -32 # transforma
	sb $t3, 0($a0) #t9 store letra um endereco atras
	j LOOP
FIM:
	
	li $v0 , 4
	la $v1 , string
	la, $a0, string
	syscall
	#jr $ra