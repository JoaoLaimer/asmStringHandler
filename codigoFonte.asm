.data 
	#Variaveis menu
	menu: 		.asciiz "\n-----MENU-----\n (1) Opção 1;\n (2) Opção 2;\n (3) Sair;\n (4) Opção 4;\n (5) Opção 5;\n"
	opçãoMenu: 	.asciiz "Digite sua uma opção:"
	testeVolta: 	.asciiz "TESTE"
	#Variaveis colocarEmMinusculo e colocarEmMaiusculo
	stringAlterada: .space 100	#Tamanho do espaço de memória para a string
	entradaString: .space 100  
	#Variaveis inverteString 
	stringOpção3: .asciiz "essa string esta invertida" 
	#Variaveis capitalizar string
	stringOpção4: .asciiz "Aoi    Essa string esta errada e um teste" 
.text
	li $s1, 1  			#Opção de saída do menu
	li $s2, 2  			#Opção de saída do menu
	li $s3, 3  			#Opção de saída do menu
	li $s4, 4  			#Opção de saída do menu
	li $s5, 5  			#Opção de saída do menu
	li $s6, 6  			#Opção de saída do menu
	li $s7, 7  			#Opção de saída do menu
LOOPMENU:
	#Print das linhas do MENU
	li $v0, 4
	la $a0, menu
	syscall 		#Print menu
		
	li $v0, 4
	la $a0, opçãoMenu
	syscall			#Print opçãoSair
		
	li $v0, 5
	syscall
		
	#Verificações da opção escolhida
	beq $v0, $s1, OPÇÃO1	#Se $t1 = 1, pula para a opção 1
	beq $v0, $s2, OPÇÃO2	#Se $t1 = 2, pula para a opção 2
	beq $v0, $s3, OPÇÃO3	#Se $t1 = 3, pula para a opção 3
	beq $v0, $s4, OPÇÃO4	#Se $t1 = 4, pula para a opção 4
	#beq $v0, $s5, OPÇÃO5	#Se $t1 = 5, pula para a opção 5
	#beq $v0, $s6, OPÇÃO6	#Se $t1 = 6, pula para a opção 6
	#beq $v0, $s7, OPÇÃO7	#Se $t1 = 7, pula para a opção 7
	beq $v0, $s7, FIM	#Se $t1 = 7, pula para o fim do program
	j LOOPMENU	
		
OPÇÃO1:
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	
	la $t0, stringAlterada 		#Endereço da stringAlterada
	la $t1, entradaString		#Salva nesse endenreço a string digitada pelo usuario
	
	LOOPOPÇÃO1:
		lbu 	$s0, ($t1)			#Le o primeiro caractere da string no registrador $s1
		beq 	$s0, $zero, FIMOPÇÃO1		#Verifica se o caractere não é vazio, se for pula para o final do código, se não
		blt 	$s0, 122, LETRAMINUSCULA	#Se for menor que 97, não é um caracter válido e pula para o proximo caractere

	LETRAMINUSCULA:
		blt 	$s0, 65, ITERAÇÃOOPÇÃO1
		bgt 	$s0, 90, ITERAÇÃOOPÇÃO1
		addi 	$s0, $s0, 32			#Soma 32 para colocar a letra em minusculo
		sb 	$s0, ($t0)
		j ITERAÇÃOOPÇÃO1
	ITERAÇÃOOPÇÃO1:
		sb 	$s0, ($t0)		#Salva o valor de $s0 em $a0
		addi 	$t0, $t0, 1		#Incrementa em 1 o valor na memória para ir para o próximo caracter 
		addi 	$t1, $t1, 1
		j LOOPOPÇÃO1
	
	FIMOPÇÃO1:					#imprime a string alterada
		li 	$v0, 4
		la 	$a0, stringAlterada
		syscall 
		j LOOPMENU
OPÇÃO2: 
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	
	la $t0, stringAlterada 		#Endereço da stringAlterada
	la $t1, entradaString		#Salva nesse endenreço a string digitada pelo usuario
	
	loop:
		lbu 	$s0, ($t1)			#Le o primeiro caractere da string no registrador $s1
		beq 	$s0, $zero, FIMOPÇÃO2		#Verifica se o caractere não é vazio, se for pula para o final do código, se não
		blt 	$s0, 97, LETRAMAIUSCULA		#Se for menor que 97, não é um caracter válido e pula para o proximo caractere
		bgt 	$s0, 122, ITERAÇÃOOPÇÃO2		#Se for maior que 122, não é um caracter válido e pula para o proximo caractere
		addi 	$s0, $s0, -32			#Substrai -32 para colocar a letra em maiusculo
		sb 	$s0, ($t0)			#Salva o valor de $s0 em $a0
		j ITERAÇÃOOPÇÃO2				#Pula para a interação
	
	LETRAMAIUSCULA:
		blt 	$s0, 65, ITERAÇÃOOPÇÃO2		#Se for uma letra entre 65 e 90 na tabela ASCII
		bgt 	$s0, 90, ITERAÇÃOOPÇÃO2		#quer dizer que a letra já é maiuscula, então eu pulo ela indo direto para iteração
		sb 	$s0, ($t0)			#Salva o valor de $s0 em $t0
		j ITERAÇÃOOPÇÃO2
	
	ITERAÇÃOOPÇÃO2:
		addi 	$t0, $t0, 1		#Incrementa em 1 o valor na memória para ir para o próximo caracter 
		addi 	$t1, $t1, 1
		j loop
	
	FIMOPÇÃO2:					#imprime a string alterada
		li 	$v0, 4
		la 	$a0, stringAlterada
		syscall
		j LOOPMENU
OPÇÃO3:
	#A FAZER, A PESSOA ENTRA COM UMA STRING QUALQUER
	la $a0 , stringOpção3 # string ad
	lb $t1, 0($a0) # t1 string letter
	ADDINSTACK:
		beq $t1, 0, DESTACK # if letter = null
		sb $t1, ($sp) # store letter in stack
		addiu $sp, $sp, -4 # increase stack
		addi $a0, $a0, 1 # increase string ad
		lb $t1, 0 ($a0) # load string letter
		j ADDINSTACK # main loop
	
	DESTACK:
		la $a0, stringOpção3
		addiu $sp, $sp, 4
	DESTACKLOOP: 
		lb $t1, 0($sp)
		beq $t1, 0, FIMOPÇÃO3
		sb $t1, ($a0)
		addiu $sp, $sp, 4
		addi $a0, $a0, 1
		j DESTACKLOOP
	FIMOPÇÃO3:
		li $v0, 4
		la $a0, stringOpção3
		syscall
		j LOOPMENU
OPÇÃO4:
	addi $a1, $a1, 32 # a1 espaco
	la $a0, stringOpção4 # a0 endereco da string
	lb $t8, 0($a0) # t8 primeira letra
	sle $t7, $t8, 90  # ja é MAIUSCULO
	beq $t7, 1, LOOPOPÇÃO4
	addi $t8, $t8, -32 # transforma a primeira letra em maiusculo
	sb $t8, 0($a0) # salva a letra na string
	LOOPOPÇÃO4:	
		addi $a0 , $a0, 1
		lb $t8, 0($a0) 
		beq $t8, $zero, FIMOPÇÃO4
		beq $t8, $a1, ESPACO
		j LOOPOPÇÃO4
	ESPACO:
		addi $a0 , $a0, 1 #dpois do espaco 
	MAIUSCULO:
		lb $t3, 0($a0) #t3 load letra
		sle $t7, $t3, 90  # ja é MAIUSCULO
		beq $t7, 1, LOOPOPÇÃO4  # se for maiusculo volta pro loop
		beq $t3, 32, LOOPOPÇÃO4 # se proximo e espaco verifica de novo
		add $t3, $t3, -32 # transforma
		sb $t3, 0($a0) #t9 store letra um endereco atras
	j LOOPOPÇÃO4
	FIMOPÇÃO4:
		li $v0 , 4
		la $v1 , stringOpção4
		la, $a0, stringOpção4
		syscall
		j LOOPMENU
FIM: