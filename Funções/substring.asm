.data 
	string: .asciiz "oi meu nome e joao vitor laimer"
	substring: .asciiz "joao"
	achou: .asciiz "é substring"
	nachou: .asciiz "nao é substring"
.text
	la $a0, string
	la $a1, substring
	lb $t1, ($a1)
RUNSTRING:
	lb $t0, ($a0)
	beq $t0, $t1, preFOUND
	beq $t0, 0, ISNOTSUBSTRING
	addi $a0, $a0, 1 
	j RUNSTRING
preFOUND:
	la $a2, 1($a0)
FOUND:
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	lb $t0, ($a0)
	lb $t1, ($a1)
	beq $t1, 0, ISSUBSTRING
	beq $t0, 0, ISNOTSUBSTRING
	bne $t0, $t1, NOTFOUND
	j FOUND
NOTFOUND:
	la $a0, 0($a2)
	la $a1, substring
	lb $t1, ($a1)
	j RUNSTRING	
	
ISNOTSUBSTRING:
	li $v0, 4
	la $a0, nachou
	syscall
	li $v0, 10
	syscall
ISSUBSTRING:
	li $v0, 4
	la $a0, achou
	syscall
	li $v0, 10
	syscall
	