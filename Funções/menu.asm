.data 
	menu: 		.asciiz "\n-----MENU-----\n (1) Opção 1;\n (2) Opção 2;\n (3) Sair;\n"
	opçãoMenu: 	.asciiz "Digite sua uma opção:"
	testeVolta: 	.asciiz "TESTE"
.text
	li $s1, 1  			#Opção de saída do menu
	li $s2, 2  			#Opção de saída do menu
	li $s3, 3  			#Opção de saída do menu
	loopMenu:
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
		beq $v0, $s3, fim 	#Se $t1 = 3, pula para o fim do program
		beq $v0, $s1, opção1	#Se $t1 = 1, puala para a opção 1
		beq $v0, $s2, opção2	#Se $t1 = 2, puala para a opção 2
		j loopMenu
		
	opção1:
		li $v0, 4
		la $a0, testeVolta
		syscall 
		j loopMenu
	opção2: 
		li $v0, 4
		la $a0, testeVolta
		syscall 
		j loopMenu
	fim: