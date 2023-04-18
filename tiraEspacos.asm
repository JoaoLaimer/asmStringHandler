.data
	string: .asciiz "Gosto muito do meu professor de AOC-I."

.text
	addi $t1, $t1, 32
	la $a0, string
	lb $t2, 0($a0)
LOOP:	

	and $t9, $t9 , $zero
	lb $t2, 0($a0) 
	beq $t2, $zero, FIM
	beq $t2, $t1, ESPACO
	addi $a0 , $a0, 1
	j LOOP
ESPACO:
	add $t9, $zero, $a0
	la $t4, 0($t9)
	la $t3, 1($t9)
ESPACOLOOP:
	lb $t5, 0($t3)
	sb $t5, 0($t4)
	addi $t3, $t3, 1
	addi $t4, $t4, 1
	beq $t5, $zero, LOOP
	j ESPACOLOOP
FIM:
	li $v0 , 4
	la, $a0, string
	syscall
	
	