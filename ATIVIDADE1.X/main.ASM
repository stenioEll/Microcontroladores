;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*              MODIFICAÇÕES PARA USO COM 12F675                   *
;*                FEITAS PELO PROF. MARDSON                        *
;*                      MARÇO DE 2021                              *
;*                 BASEADO NO EXEMPLO DO LIVRO                     *
;*           Desbravando o PIC. David José de Souza                *
;*-----------------------------------------------------------------*
;*   MODELO PARA O PIC 12F675                                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINIÇÕES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p12f675.inc>	;ARQUIVO PADRÃO MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINAÇÃO DE MEMÓRIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINIÇÃO DE COMANDOS DE USUÁRIO PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAMÓRIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARIÁVEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20	;ENDEREÇO INICIAL DA MEMÓRIA DE
					;USUÁRIO
		W_TEMP		  ;REGISTRADORES TEMPORÁRIOS PARA USO
		STATUS_TEMP	  ;JUNTO ÀS INTERRUPÇÕE
		DD                ; Dia da data
		MM                ; Mes da data
		AA		  ; Ano da data
		formulaBissextoX  ; Formula para o ano Bissexto ano/4
		formulaBissextoY  ; Formula para o ano Bissexto ano/100
		formulaBissextoZ  ; Formula para o ano Bissexto ano/400
		x                 ; Formula para encontrar o resto de FormulaBissextoX
		y                 ; Formula para encontrar o resto de FormulaBissextoY
		z                 ; Formula para encontrar o resto de FormulaBissextoZ
		w                 ; Informa o dia (-produto + k )
		anoLimiteInicial  ; Ano minimo
		anoLimiteFinal    ; Ano máximo
		k                 ; fórmula para encontrar o dia
		contador          ; Contador       
		divisao           ; k/7 
		produto           ; 7*k
		anoIntervaloInicial
		anoIntervaloFinal
		mesIntervaloFinal
		mesLimite
		diaLimite
		contaMes
	
		;COLOQUE AQUI SUAS NOVAS VARIÁVEIS
		;NÃO ESQUEÇA COMENTÁRIOS ESCLARECEDORES

	ENDC			;FIM DO BLOCO DE DEFINIÇÃO DE VARIÁVEIS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SAÍDAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDEREÇO INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    INÍCIO DA INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDEREÇO DE DESVIO DAS INTERRUPÇÕES. A PRIMEIRA TAREFA É SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERAÇÃO FUTURA

	ORG	0x04			;ENDEREÇO INICIAL DA INTERRUPÇÃO
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SERÃO ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUPÇÕES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SAÍDA DA INTERRUPÇÃO                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUPÇÃO

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRIÇÃO DE FUNCIONAMENTO
; E UM NOME COERENTE ÀS SUAS FUNÇÕES.

SUBROTINA1

	;CORPO DA ROTINA

	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000000' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SAÍDAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN

	;CORPO DA ROTINA PRINCIPAL
	MOVLW .04
	MOVWF anoLimiteInicial
	MOVLW .99
	MOVWF anoLimiteFinal
	MOVLW .21
	MOVWF DD
	MOVLW .10
	MOVWF MM
	MOVLW .21
	MOVWF AA
	
	;VARIAVEIS DO IF
	
	MOVLW .29					   ;Caso o ano seja menor que 30, há a possibilidade de ser uma data fora da especificação
	MOVWF anoIntervaloFinal
	MOVLW .21					   ;Caso o ano seja menor que 21, há a possibilidade de ser uma data fora da especificação
	MOVWF anoIntervaloInicial
	MOVLW .12					   ; Caso o mes seja maior que 13, consiste em uma data inexiste, ou seja data fora da especificação
	MOVWF mesLimite					   ; se for menor que 30 e maior que 21, de fato é uma data fora da especificação
	MOVLW .31
	MOVWF diaLimite
	
	; Variaveis da multiplicacao
	MOVLW .10
	MOVWF contaMes


	
;TRATAMENTO DE ERROS 	

VERIFICAERRO1 ; O código após este Label se diz respeito a verificação de caso o ano esteja no intervalo entre 21 e 30
	
	;VERIFICANDO SE O ANO É MENOR QUE 30
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoIntervaloFinal, W			; SUBTRAÇÃO DO VALOR EM WORK  MENOS O ANO INTERVALO FINAL 30	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, OU SEJA ANO MENOR QUE 30
							; Caso seja 0, o código será desviado para outro label, continuando o fluxo previsto pelo código
	GOTO VERIFICAERRO2				; Ano não faz parte do intervalo, Label VerificaErro1 finalizado
	
							; SKIP acionado, sabemos que o ano é menor que 30
							;Sabendo que o fluxo do código obteve uma interrupção, sabemos de fato que o ano é menor que 30, porém para o erro ser completo
							; Devemos saber se é maior que 21, logo verei se ele é menor que 21, pois caso seja estará fora do intervalo
							;VERIFICANDO SE O ANO É MENOR QUE 21
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoIntervaloInicial, W			; SUBTRAÇÃO DO VALOR EM WORK  MENOS O ANO, AGORA SENDO ANO INICIAL DO INTERVALO, 21	
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, 
							;OU SEJA ANO MENOR QUE 21, CASO SEJA 0, O ANO ESTÁ NO INTERVALO 
	GOTO FORADAESPECIFICAO				; Data fora da especificação
	GOTO VERIFICAERRO2				;Ano não faz parte do intervalo, Label VerificaErro1 finalizado 

VERIFICAERRO2
	
	;VERIFICANDO SE O ANO ESTÁ ENTRE 1910 E 2100
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoLimiteFinal, W				; SUBTRAÇÃO DO VALOR EM WORK  MENOS O ANO LIMITE FINAL 100, 	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, OU SEJA ANO MENOR QUE 100
	GOTO VERIFICAERRO3				; Caso seja 0, o código será desviado para outro label, continuando o fluxo previsto pelo código

	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoLimiteInicial, W			; SUBTRAÇÃO DO VALOR EM WORK  MENOS O ANO INICIAL DO INTERVALO, AGORA SENDO ANO INICIAL DO INTERVALO, 05
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, 
							;OU SEJA ANO MENOR QUE 10, SENDO UM MES VALIDO, LOGO SENDO 0, O ANO PODE ESTÁ FORA DA ESPECIFICAÇÃO

	
	GOTO VERIFICAERRO3				; Ano faz parte do intervalo 2021 a 1930, Fluxo do código procede
	GOTO FORADAESPECIFICAO				; Data fora da especificação

	

VERIFICAERRO3
	
	;Verificar se o mes é inválido
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW MM					; ATRIBUINDO O MÊS A VARIAVEL WORK 
	SUBWF mesLimite, W				; SUBTRAÇÃO DO VALOR EM WORK  MENOS O MÊS LIMITE FINAL 13,	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, OU SEJA MES MENOR QUE 13
	GOTO  FORADAESPECIFICAO				; Label para Data fora da especificação
	GOTO  VERIFICAERRO4
	

	
VERIFICAERRO4
	
	;Verificando se o mês é nulo 
	MOVFW MM
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pulará uma linha do código indicando que a variável MM não é nula, continuando o fluxo previsto pelo código
							; Se bit Z = 1, logo será o dado da variavel mês é nulo
	GOTO FORADAESPECIFICAO				; Data fora da especificação
	GOTO VERIFICAERRO5
	
	
	
VERIFICAERRO5
	
	;Verificar se o dia é valido
	MOVLW .0					; ZERANDO O WORK
	MOVFW DD					; ATRIBUINDO O DIA A VARIAVEL WORK 
	SUBWF diaLimite, W				; SUBTRAÇÃO DO VALOR EM WORK  MENOS O DIA,COM INTUITO DE SABER SE O DIA É MENOR 31	
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SERÁ PULADA, INDICANDO QUE O RESULTADO DA SUBTRAÇÃO FOI NEGATIVO, 
	GOTO FORADAESPECIFICAO
	GOTO VERIFICAERRO6				;OU SEJA ANO MENOR QUE 32, SENDO UM DIA QUASE VALIDO, LOGO C SENDO IGUAL A 0, O ANO ESTÁ FORA DA ESPECIFICAÇÃO
	
	
VERIFICAERRO6
	
	;Verificar se o dia não é nulo
	MOVFW DD					
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pulará uma linha do código indicando que a variável DD, dia não é nula, continuando o fluxo previsto pelo código
							; Se bit Z = 1, logo será o dado da variavel mês é nulo
	GOTO FORADAESPECIFICAO				; Data NULA, fora da especificação
	GOTO DIACERTO1	    				; Se bit Z = 0, logo será desviado para outro label, continuando o fluxo previsto pelo código


DIACERTO1
	MOVLW .0					; reiniciando o work
	MOVlW .24					; Atribuindo o dia ao work
	SUBWF DD, W					;verificando se é igual 24, pois o dia faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
							; Se bit Z = 1, logo o dia é 24, pois 24 - 24 = 0, não haverá skip de instrução
	
	GOTO MESCERTO1					; logo será desviado para outro label para verificar o mês
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF DD, W					; verificando se é igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
							; Se bit Z = 1, logo o dia é 21, pois 21 - 21 = 0, não haverá skip de instrução
							
	;Dia 21 pode ser a data 21/10/21 caso os anos sejam subtraidos e resulte 0 pode ser a data, necessitando so verificar o mês
	
	GOTO MESCERTO2					; Label para verificar se é dia 21/10/21
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF DD, W					; verificando se é igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
							; Se bit Z = 1, logo o dia é 21, pois 21 - 21 = 0, não haverá skip de instrução
	GOTO MESCERTO1					; logo será desviado para outro label para verificar o mes
	
	MOVLW .0					; reiniciando o work
	MOVlW .10					; Atribuindo o dia ao work
	SUBWF DD, W					;verificando se é igual 21 novamente, pois outra data faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
	
	GOTO MESCERTO1
	MOVLW .0					
	MOVlW .2					
	SUBWF DD, W					
	BTFSC STATUS, Z					
							
	GOTO MESCERTO1					
	GOTO FORADAESPECIFICAO				;Caso nenhum dia seja confirmado, a data está fora da especificação


MESCERTO2
	;Para a data que tem o dia igual ao ano 2021
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF AA, W					; verificando se é igual ao ano 2021, pois o dia 21 já foi verificado em DIACERTO1
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
	GOTO MESCERTO3					; Verificar o mês para confirmar a data
	GOTO MESCERTO1					; Ainda há uma data com o dia 21, logo o mês deve ser verificado mesmo que a subtração do dia pelo ano resulte em 0
	
MESCERTO3
	;Verificando o mês da data que o ano - dia resulta em 0
	MOVLW .0					; reiniciando o work
	MOVlW .10					; Atribuindo o dia ao work
	SUBWF MM, W					;verificando se é igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pulará uma linha do código indicando que a subtração não resultou em 0
							; Se bit Z = 1, logo o mês é 10, pois 10 - 10 = 0
	GOTO DIADADATA1					; Label para aplicar o valor de W referente ao dia da data
	GOTO FORADAESPECIFICAO				; data fora da tabela

	
MESCERTO1	
	;Verificação de meses feita da mesma forma, com subtação e teste do bit Z, a diferença que serão transferidas ou para o label ANOCERTO1
	;ou FORA DA ESPECIFICAÇÃO
	
	MOVLW .0					
	MOVlW .2					
	SUBWF MM, W					
	BTFSC STATUS, Z					
							
	GOTO ANOCERTO1
	MOVLW .0					
	MOVlW .4					
	SUBWF MM, W					
	BTFSC STATUS, Z					
							
	GOTO ANOCERTO1
	MOVLW .0					
	MOVlW .6					
	SUBWF MM, W					
	BTFSC STATUS, Z					
							
	GOTO ANOCERTO1
	MOVLW .0					
	MOVlW .8					
	SUBWF MM, W					
	BTFSC STATUS, Z					
							
	GOTO ANOCERTO1
	GOTO FORADAESPECIFICAO


ANOCERTO1
	;Validar o ano também testando o bit Z e direcionando para o Label da data correspondente ou para fora da especificação
	
	MOVLW .0					
	MOVLW .5					
	SUBWF AA, W					
	BTFSC STATUS, Z					
								
	GOTO DIADADATA2					
	MOVLW .0					
	MOVLW .21					
	SUBWF AA, W					
	BTFSC STATUS, Z					
								
	GOTO DIADADATA3					
	MOVLW .0					
	MOVLW .55					
	SUBWF AA, W					
	BTFSC STATUS, Z					
								
	GOTO DIADADATA4
	MOVLW .0					
	MOVLW .70					
	SUBWF AA, W					
	BTFSC STATUS, Z					
								
	GOTO DIADADATA5
	
	GOTO FORADAESPECIFICAO				

DIADADATA1
	
	MOVLW .5					;21/10/1955, Quinta-feira
	GOTO FIM

DIADADATA2
	
	MOVLW .7					;02/04/2005, Sabádo
	GOTO FIM

DIADADATA3
	
	MOVLW .3					;10/08/2021, Terça-feira
	GOTO FIM

DIADADATA4
	
	MOVLW .5					;24/02/1955, Quinta-feira
	GOTO FIM

DIADADATA5
	
	MOVLW .1					;21/06/1970, Domingo
	GOTO FIM

FORADAESPECIFICAO
	
	;Caso os meses, dias e anos que não passarem nos testes de verificação virão para cá
	
	MOVLW .0					; Data fora da especificação
	GOTO FIM					; Programa finalizado


FIM
	GOTO FIM

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
