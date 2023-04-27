.data 
	string: .asciiz "a"
.text
	la $t0, string			#Salva a string em $t0
	li $t1, 3 			#chave de deslocamento
loop:
	lbu 	$s0, ($t0)		#Da um load da string em $s0
	beq 	$s0, $zero, fim		#Verifica se o caractere não é vazio, se for pula para o final do código, se não
	add 	$s0, $s0, $t1		#Soma o valor do caractere com o valor da chave de deslocamento
	sb 	$s0, ($t0)		#Salva o caractere modificado em $t0
	addi 	$t0, $t0, 1		#Incrementa para o proximo caractere
	j loop
	
#FALTA FAZER AS VERIFICAÇÕES DA STRING( VER SE É LETRA, NUMERO, CARACTERE ESPECIAL, ETC..)
fim:
	li 	$v0, 4			#Print da palavra criptografada
	la 	$a0, string
	syscall