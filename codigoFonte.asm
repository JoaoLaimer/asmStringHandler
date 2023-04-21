.data 
	#Variaveis menu
	menu: 		.asciiz "\n-----------ASM.STRING.HANDLER-----------\n (1) Colocar todas letras em minuscula;\n (2) Colocar todas letras em maiuscula;\n (3) Inverter string\n (4) Capitalizar string;\n (5) Remover espaço(s) de uma string;\n (6) Verificar se é substring;\n (7) Sair;\n Digite sua uma opção:"
	#Variaveis para uso da string
	stringAlterada: .space 100	#Tamanho do espaço de memória para a string
	entradaString: .space 50
	substring: .space 50
	#Variaveis de mensagens
	digitarString: .asciiz "Digite uma string: "
	retornoString: .asciiz "String alterada: "
	éSubstringMensagem: .asciiz "é substring"
	ñSubstringMensagem: .asciiz "nao é substring"

.text
	li $s1, 1  			#Opção de saída do menu
	li $s2, 2  			#Opção de saída do menu
	li $s3, 3  			#Opção de saída do menu
	li $s4, 4  			#Opção de saída do menu
	li $s5, 5  			#Opção de saída do menu
	li $s6, 6  			#Opção de saída do menu
	li $s7, 7  			#Opção de saída do menu
LOOP_MENU:
	#Print das linhas do MENU
	li $v0, 4
	la $a0, menu
	syscall 		#Print menu
	
	li $v0, 5
	syscall
	
	#Verificações da opção escolhida
	beq $v0, $s1, OPÇÃO1	#Se $v0 = 1, pula para a opção 1
	beq $v0, $s2, OPÇÃO2	#Se $v0 = 2, pula para a opção 2
	beq $v0, $s3, OPÇÃO3	#Se $v0 = 3, pula para a opção 3
	beq $v0, $s4, OPÇÃO4	#Se $v0 = 4, pula para a opção 4
	beq $v0, $s5, OPÇÃO5	#Se $v0 = 5, pula para a opção 5
	beq $v0, $s6, OPÇÃO6	#Se $v0 = 6, pula para a opção 6
	beq $v0, $s7, FIM	#Se $v0 = 7, pula para o fim do program
	j LOOP_MENU	
OPÇÃO1:
	jal COLOCAR_EM_MINUSCULO
    	j LOOP_MENU
OPÇÃO2:
	jal COLOCAR_EM_MAIUSCULO
    	j LOOP_MENU
OPÇÃO3:
	jal INVERTER_STRING
    	j LOOP_MENU
OPÇÃO4:
	jal CAPITALIZAR_STRING
    	j LOOP_MENU
OPÇÃO5:
	jal REMOVER_ESPAÇOS_STRING
    	j LOOP_MENU
OPÇÃO6:
	jal VERIFICAR_SUBSTRING
    	j LOOP_MENU

COLOCAR_EM_MINUSCULO:
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 		
	
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	
	la $t0, stringAlterada 		#Endereço da stringAlterada
	la $t1, entradaString		#Salva nesse endenreço a string digitada pelo usuario
	
	LOOP_COLOCAR_EM_MINUSCULO:
		lbu 	$s0, ($t1)				#Le o primeiro caractere da string no registrador $s1
		beq 	$s0, $zero, FIM_COLOCAR_EM_MINUSCULO	#Verifica se o caractere não é vazio, se for pula para o final do código, se não
		blt 	$s0, 122, LETRA_MINUSCULA		#Se for menor que 97, não é um caracter válido e pula para o proximo caractere

	LETRA_MINUSCULA:
		blt 	$s0, 65, ITERAÇÃO_COLOCAR_EM_MINUSCULO
		bgt 	$s0, 90, ITERAÇÃO_COLOCAR_EM_MINUSCULO
		addi 	$s0, $s0, 32			#Soma 32 para colocar a letra em minusculo
		sb 	$s0, ($t0)
		j ITERAÇÃO_COLOCAR_EM_MINUSCULO
		
	ITERAÇÃO_COLOCAR_EM_MINUSCULO:
		sb 	$s0, ($t0)		#Salva o valor de $s0 em $a0
		addi 	$t0, $t0, 1		#Incrementa em 1 o valor na memória para ir para o próximo caracter 
		addi 	$t1, $t1, 1
		j LOOP_COLOCAR_EM_MINUSCULO
	
	FIM_COLOCAR_EM_MINUSCULO:
		#Print mensagem
		li $v0, 4
		la $a0, retornoString
		syscall 		
		#imprime a string alterada
		li 	$v0, 4
		la 	$a0, stringAlterada
		syscall 
		sb $zero, ($a0)
		jr $ra
		
COLOCAR_EM_MAIUSCULO: 
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 		
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	
	la $t0, stringAlterada 		#Endereço da stringAlterada
	la $t1, entradaString		#Salva nesse endenreço a string digitada pelo usuario
	
	LOOP_COLOCAR_EM_MAIUSCULO:
		lbu 	$s0, ($t1)			#Le o primeiro caractere da string no registrador $s1
		beq 	$s0, $zero, FIM_COLOCAR_EM_MAIUSCULO		#Verifica se o caractere não é vazio, se for pula para o final do código, se não
		blt 	$s0, 97, LETRA_MAIUSCULA		#Se for menor que 97, não é um caracter válido e pula para o proximo caractere
		bgt 	$s0, 122, ITERAÇÃO_COLOCAR_EM_MAIUSCULO		#Se for maior que 122, não é um caracter válido e pula para o proximo caractere
		addi 	$s0, $s0, -32			#Substrai -32 para colocar a letra em maiusculo
		sb 	$s0, ($t0)			#Salva o valor de $s0 em $a0
		j ITERAÇÃO_COLOCAR_EM_MAIUSCULO				#Pula para a interação
	
	LETRA_MAIUSCULA:
		blt 	$s0, 65, ITERAÇÃO_COLOCAR_EM_MAIUSCULO		#Se for uma letra entre 65 e 90 na tabela ASCII
		bgt 	$s0, 90, ITERAÇÃO_COLOCAR_EM_MAIUSCULO		#quer dizer que a letra já é maiuscula, então eu pulo ela indo direto para iteração
		sb 	$s0, ($t0)			#Salva o valor de $s0 em $t0
		j ITERAÇÃO_COLOCAR_EM_MAIUSCULO
	
	ITERAÇÃO_COLOCAR_EM_MAIUSCULO:
		addi 	$t0, $t0, 1		#Incrementa em 1 o valor na memória para ir para o próximo caracter 
		addi 	$t1, $t1, 1
		j LOOP_COLOCAR_EM_MAIUSCULO
	
	FIM_COLOCAR_EM_MAIUSCULO:
		#Print mensagem
		li $v0, 4
		la $a0, retornoString
		syscall 
		#imprime a string alterada
		li 	$v0, 4
		la 	$a0, stringAlterada
		syscall
		sb $zero, ($a0)
		jr $ra
		
INVERTER_STRING:
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	lb $t1, 0($a0) 			#Salva em $t1 o primeiro caractere de $a0
	ADD_IN_STACK:
		beq $t1, 0, DESTACK 	#Se a letra for nula, fula para o DESTACK
		sb $t1, ($sp) 		#Coloca a letra na pilha
		addiu $sp, $sp, -4 	#Vai para a próxima posição da pilha
		addi $a0, $a0, 1 	#Incrementa em 1 o valor de endereço da string (vai para o próximo caractere)
		lb $t1, 0 ($a0) 	#Da um load do caractere em $t1
		j ADD_IN_STACK 		#volta para o loop
	
	DESTACK:
		la $a0, stringAlterada	#Da um load da string
		addiu $sp, $sp, 4	#Avança para o valor anterior da pilha
		
	DESTACK_LOOP: 
		lb $t1, 0($sp)				#Pega o caractere do topo da pilha
		beq $t1, 0, FIM_INVERTER_STRING		#Se o caractere do topo for nulo, pula para o FIMOPÇÃO3
		sb $t1, ($a0)				#Salva o caractere em $t1
		addiu $sp, $sp, 4			#Vai para o valor anterior do topo da pilha
		addi $a0, $a0, 1			#Incrementa em 1 o endereço da string para ir para o próximo caractere
		j DESTACK_LOOP
		
	FIM_INVERTER_STRING:	
		#Print mensagem
		li $v0, 4
		la $a0, retornoString
		syscall 
		#imprime a string alterada
		li $v0, 4
		la $a0, stringAlterada
		syscall
		LIMPA_STRING_ALTERADA_3:
			sb $zero, ($a0)       			#Armazena o valor 0 na posicao apontada por $a0
			addi $a0, $a0, 1      			#Incrementa em 1 o endereço da string para ir para o próximo caractere
			lb $t1, 0($a0)        			#Carrega o próximo caractere da string
			bnez $t1, LIMPA_STRING_ALTERADA_3 	#Se o caractere for diferente de zero, continua o loop
		sb $zero, ($a0)
		jr $ra
CAPITALIZAR_STRING:
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string no endereço $a0
	li	$a1, 100		#Tamanho da string
	syscall
	addi $a3, $a3, 32 	#a3 recebe o valor do caractere espaco
	
	lb $t8, 0($a0) 				#t8 recebe a primeira letra
	sle $t7, $t8, 90  			#Se já for MAIUSCULO, set $t1 com 1
	beq $t7, 1, LOOP_CAPITALIZAR_STRING	#Se $t1 for == 1, então pula para a LOOPOPÇÃO4
	addi $t8, $t8, -32 			#Se não pular, então transforma a primeira letra em maiusculo
	sb $t8, 0($a0) 				#Salva a letra na string
	
	LOOP_CAPITALIZAR_STRING:	
		addi $a0 , $a0, 1				#Soma 1 em $a0 para pegar o primeiro caractere 
		lb $t8, 0($a0) 					#Salva esse caractere em $t8
		beq $t8, $zero, FIM_CAPITALIZAR_STRING		#Se $t8 for nulo, quer dizer que chegou no final da string e pula para o FIMOPÇÃO4
		beq $t8, $a3, ESPACO_CAPITALIZAR_STRING	#Se não, testa se o caractere é == espaco ($a1)
		j LOOP_CAPITALIZAR_STRING			#Volta pro loop
		
	ESPACO_CAPITALIZAR_STRING:
		addi $a0 , $a0, 1 		#Soma um em $a0 para ir para o próximo caractere (Pula o espaço no caso)
		
	MAIUSCULO_CAPITALIZAR_STRING:
		lb $t3, 0($a0) 			#$t3 recebe a letra
		sle $t7, $t3, 90  		#Se já for MAIUSCULO, set $t7 com 1
		beq $t7, 1, LOOP_CAPITALIZAR_STRING  	#Se for maiusculo volta pro loop
		beq $t3, 32, LOOP_CAPITALIZAR_STRING 	#Se for um espaco verifica de novo
		add $t3, $t3, -32 		#Transforma em maiusculo
		sb $t3, 0($a0) 			#$t3 recebe uma letra de um endereco atras
		j LOOP_CAPITALIZAR_STRING			#Volta pro loop
		
	FIM_CAPITALIZAR_STRING:	
		#Print mensagem
		li $v0, 4
		la $a0, retornoString
		syscall 
		#imprime a string alterada
		li $v0 , 4
		la $a0, entradaString
		syscall
		sb $zero, ($a0)
		jr $ra
REMOVER_ESPAÇOS_STRING:
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string no endereço $a0
	li	$a1, 100		#Tamanho da string
	syscall
	li $a3, 32 		#$a3 recebe o valor do caractere espaco
	LOOP_REMOVER_ESPAÇOS_STRING:	
		lb $t8, 0($a0) 			#%t8 recebe um caractere
		beq $t8, $zero, FIM_REMOVER_ESPAÇOS_STRING	#Se %t8 for nulo pula para o FIMOPÇÃO5
		beq $t8, $a3, ESPACO_REMOVER_ESPAÇOS_STRING	#Se for um espaço pula para a label ESPACOOPÇÃO5
		addi $a0 , $a0, 1		#Incrementa em 1 o endereço da string para o próximo caractere
		j LOOP_REMOVER_ESPAÇOS_STRING
	
	ESPACO_REMOVER_ESPAÇOS_STRING:
		la $t4, 0($a0) 	#$t4 recebe o endereço do espaco
		la $t3, 1($t4) #$t3 recebe o endereço depois do espaco
	
	ESPACO_LOOP_REMOVER_ESPAÇOS_STRING:
		lb $t9, 0($t3) 		#$t9 recebe o endereço depois do espaço
		sb $t9, ($t4) 		#$t9 store letra um endereco atras
		addi $t3, $t3, 1	#Incrementa em um o endereço da string
		addi $t4, $t4, 1
		beq $t9, $zero, LOOP_REMOVER_ESPAÇOS_STRING	#Se $t9 for nulo pula para o LOOPOPÇÃO5
		j ESPACO_LOOP_REMOVER_ESPAÇOS_STRING		#Se não continua nesse loop salvando procurando por espaço e salvando o valor da frente do espaço
	
	FIM_REMOVER_ESPAÇOS_STRING:
		#Print mensagem
		li $v0, 4
		la $a0, retornoString
		syscall 
		#imprime a string alterada
		li $v0 , 4
		la $a0, entradaString
		syscall
		LIMPA_STRING_ALTERADA_5:
			sb $zero, ($a0)       			#Armazena o valor 0 na posicao apontada por $a0
			addi $a0, $a0, 1      			#Incrementa em 1 o endereço da string para ir para o próximo caractere
			lb $t1, 0($a0)        			#Carrega o próximo caractere da string em $t1
			bnez $t1, LIMPA_STRING_ALTERADA_5  	#Se o caractere for diferente de zero, continua o loop
		li $t3, 0
		sb $zero, ($a0)
		jr $ra
VERIFICAR_SUBSTRING:
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string no endereço $a0
	li	$a1, 50			#Tamanho da string
	syscall 
	#Print mensagem
	li $v0, 4
	la $a0, digitarString
	syscall 
	lb $t0, ($a0)
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, substring		#Salva a string no endereço $a0
	li	$a1, 50			#Tamanho da string
	syscall
	la $a2, substring
	la $a1, entradaString
	lb $t1, ($a2)		#Salva em $t1 o primeiro caractere de $a2 (substring)
	PERCORRE_STRING:
		lb $t0, ($a1)				#Salva em $t0 um caractere de $a0
		beq $t0, $t1, PRIMEIRA_LETRA_IGUAL	#Se o caractere de $t0 for igual ao de $t1 pula para o PRIMEIRA_LETRA_IGUAL
		beq $t0, 10, NAO_É_SUBSTRING		#Se $t0 for nulo, pula para não é uma substring
		addi $a1, $a1, 1 
		j PERCORRE_STRING
	PRIMEIRA_LETRA_IGUAL:
		la $a3, 1($a1)		#Da um load do caractere em $ao para $a3
	ACHOU:				
		addi $a1, $a1, 1 		#Incrementa para o próximo caractere
		addi $a2, $a2, 1		#Incrementa para o próximo caractere
		lb $t0, ($a1)			#Da um load do caractere em $t0
		lb $t1, ($a2)			#Da um load do caractere em $t1
		beq $t1, 10, É_SUBSTRING	#Se chegou no final da string pula para É_SUBSTRING
		beq $t0, 10, NAO_É_SUBSTRING	#Se o caractere em $t0 é nulo, pula para NÃO_É_SUBSTRING
		bne $t0, $t1, NÃO_ACHOU		#Se %t0 e $t1 são diferente pula para NÃO_ACHOU
		j ACHOU				#Loop do achou
		
	NÃO_ACHOU:
		la $a1, 0($a3)
		la $a2, substring
		lb $t1, ($a2)
		j PERCORRE_STRING	
	
	NAO_É_SUBSTRING:
		li $v0, 4
		la $a0, ñSubstringMensagem
		syscall
		li $v0, 10
		sb $zero, ($a0)
		jr $ra
	É_SUBSTRING:
		li $v0, 4
		la $a0, éSubstringMensagem
		syscall
		li $v0, 10
		sb $zero, ($a0)
		jr $ra
FIM:
