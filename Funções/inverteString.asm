.data
	string: .asciiz "essa string esta invertida" 
	
.text
	la $a0 , string # string ad
	lb $t1, 0($a0) # t1 string letter
ADDINSTACK:
	beq $t1, 0, DESTACK # if letter = null
	sb $t1, ($sp) # store letter in stack
	addiu $sp, $sp, -4 # increase stack
	addi $a0, $a0, 1 # increase string ad
	lb $t1, 0 ($a0) # load string letter
	j ADDINSTACK # main loop
	
DESTACK:
	la $a0, string
	addiu $sp, $sp, 4
DESTACKLOOP: 
	lb $t1, 0($sp)
	beq $t1, 0, FIM
	sb $t1, ($a0)
	addiu $sp, $sp, 4
	addi $a0, $a0, 1
	j DESTACKLOOP
FIM:
	li $v0, 4
	la $a0, string
	syscall