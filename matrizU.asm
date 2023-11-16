.data
	matriz_C: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
	matriz_B: .word 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
	matriz_A: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	solicita: .asciz "Informe a ordem da matriz: "	
	linha: .asciz "\n"
	tab: .asciz "\t"
	mensagem_opcao: .asciz "Escolha (0 para linha-coluna, 1 para coluna-linha): "
	
.text
jal zero, main

soma_matrizes:
    #lw a5, opcao_soma
    beqz a0 linha_coluna
    j coluna_linha

linha_coluna:
	#Imprime string
	addi a7, zero, 4
	la a0, solicita
	ecall
	
	#Le inteiro
	addi a7, zero, 5
	ecall
	
	add t6, zero, a0
	for_i:
		beq t0, t6, fim_i
		add t1, zero, zero #j=0
		for_j:
			beq t1, t6, fim_j
			#calculo da posicao da matriz
			mul t2, t0, t6 #t2 = linha*ordem 
			slli t2, t2, 2 # 4*t2
			slli t3, t1, 2 # 4*j
			add t4, t2, t3  
			add t5, t4, a1 #m[t2][t3]
			lw a0, 0(t5)   #a0 = m[t2][t3]
			
			
			add t5, t4, a3 # a2 MATRIZ B
			lw a4, 0(t5)
			
			add a0, a0, a4 # Soma MATRIZ B(a4) com MATRIZ C(a0)
			
			add t5, t4, a2 # a3 MATRIZ A
			sw a0, 0(t5) #armazena resultado
			
			lw a0, 0(t5)
			#sw a0, 0(t5)
			
			#imprime
			addi a7, zero, 1
			ecall
			#imprime tabula��o
			addi a7, zero, 4
			la a0, tab
			ecall
		
			addi t1, t1, 1 #j++
			jal zero, for_j
		fim_j:
		#imprime pula linha
		addi a7, zero, 4
		la a0, linha
		ecall
		
		addi t0, t0, 1 #i++
		jal zero, for_i
	fim_i:
	jalr zero, ra, 0
	
coluna_linha:
	#Imprime string
	addi a7, zero, 4
	la a0, solicita
	ecall
	
	#Le inteiro
	addi a7, zero, 5
	ecall
	
	add t6, zero, a0
	add t1, zero, zero # j=0
	for_aj:
	    beq t1, t6, fim_aj
	    add t0, zero, zero # i=0
	    for_ai:
	        beq t0, t6, fim_ai
	        #calculo da posicao da matriz
	        mul t2, t6, t0 #t2 = ordem*coluna
	        slli t2, t2, 2 # 4*t2
	        slli t3, t1, 2 # 4*j
	        add t4, t2, t3
	        add t5, t4, a1 #m[t2][t3]
	        lw a0, 0(t5)   #a0 = m[t2][t3]
	
	        add t5, t4, a3 # a2 MATRIZ B
	        lw a4, 0(t5)
	
	        add a0, a0, a4 # Soma MATRIZ B(a4) com MATRIZ C(a0)
	
	        add t5, t4, a2 # a3 MATRIZ A
	        sw a0, 0(t5) #armazena resultado
	
	        lw a0, 0(t5)
	        #sw a0, 0(t5)
	
	        #imprime
	        addi a7, zero, 1
	        ecall
	        #imprime tabula��o
	        addi a7, zero, 4
	        la a0, tab
	        ecall
	
	        addi t0, t0, 1 #i++
	        jal zero, for_ai
	    fim_ai:
	    #imprime pula linha
	    addi a7, zero, 4
	    la a0, linha
	    ecall
	
	    addi t1, t1, 1 #j++
	    jal zero, for_aj
	fim_aj:
	jalr zero, ra, 0
	
main:
	
	#a0, cont�m a ordem da matriz
	la a1, matriz_C
	la a2, matriz_A
	la a3, matriz_B
	#jal ra, imprime_matriz
	

	# Pede ao usuário para escolher linha-coluna ou coluna-linha
	addi a7, zero, 4
	la a0, mensagem_opcao
	ecall
	
	# Lê a opção do usuário
	addi a7, zero, 5
	ecall
	#sw a0, opcao_soma
	
	# Chama a função de soma
	jal ra, soma_matrizes
	
	#Finaliza programa
	addi a7, zero, 10
	ecall