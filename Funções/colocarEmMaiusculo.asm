.data 
	stringAlterada: .space 100	#Tamanho do espaço de memória para a string
	entradaString: .space 100  	
.text
	li 	$v0, 8			#Código do syscall de leitura de string
	la 	$a0, entradaString	#Salva a string 
	li	$a1, 100		#Tamanho da string
	syscall
	
	la $t0, stringAlterada 		#Endereço da stringAlterada
	la $t1, entradaString		#Salva nesse endenreço a string digitada pelo usuario
	
loop:
	lbu 	$s0, ($t1)			#Le o primeiro caractere da string no registrador $s1
	beq 	$s0, $zero, fim			#Verifica se o caractere não é vazio, se for pula para o final do código, se não
	blt 	$s0, 97, letraMaiuscula		#Se for menor que 97, não é um caracter válido e pula para o proximo caractere
	bgt 	$s0, 122, iteração		#Se for maior que 122, não é um caracter válido e pula para o proximo caractere
	addi 	$s0, $s0, -32			#Substrai -32 para colocar a letra em maiusculo
	sb 	$s0, ($t0)			#Salva o valor de $s0 em $a0
	j iteração				#Pula para a interação
	
letraMaiuscula:
	blt 	$s0, 65, iteração		#Se for uma letra entre 65 e 90 na tabela ASCII
	bgt 	$s0, 90, iteração		#quer dizer que a letra já é maiuscula, então eu pulo ela indo direto para iteração
	sb 	$s0, ($t0)			#Salva o valor de $s0 em $t0
	j iteração
	
iteração:
	addi 	$t0, $t0, 1		#Incrementa em 1 o valor na memória para ir para o próximo caracter 
	addi 	$t1, $t1, 1
	j loop
	
fim:					#imprime a string alterada
	li 	$v0, 4
	la 	$a0, stringAlterada
	syscall
