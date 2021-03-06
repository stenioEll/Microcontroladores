;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*              MODIFICA��ES PARA USO COM 12F675                   *
;*                FEITAS PELO PROF. MARDSON                        *
;*                      MAR�O DE 2021                              *
;*                 BASEADO NO EXEMPLO DO LIVRO                     *
;*           Desbravando o PIC. David Jos� de Souza                *
;*-----------------------------------------------------------------*
;*   MODELO PARA O PIC 12F675                                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINI��ES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p12f675.inc>	;ARQUIVO PADR�O MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINA��O DE MEM�RIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINI��O DE COMANDOS DE USU�RIO PARA ALTERA��O DA P�GINA DE MEM�RIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARI�VEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
		W_TEMP		  ;REGISTRADORES TEMPOR�RIOS PARA USO
		STATUS_TEMP	  ;JUNTO �S INTERRUP��E
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
		anoLimiteFinal    ; Ano m�ximo
		k                 ; f�rmula para encontrar o dia
		contador          ; Contador       
		divisao           ; k/7 
		produto           ; 7*k
		anoIntervaloInicial
		anoIntervaloFinal
		mesIntervaloFinal
		mesLimite
		diaLimite
		contaMes
	
		;COLOQUE AQUI SUAS NOVAS VARI�VEIS
		;N�O ESQUE�A COMENT�RIOS ESCLARECEDORES

	ENDC			;FIM DO BLOCO DE DEFINI��O DE VARI�VEIS

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SA�DAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO SA�DA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    IN�CIO DA INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDERE�O DE DESVIO DAS INTERRUP��ES. A PRIMEIRA TAREFA � SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERA��O FUTURA

	ORG	0x04			;ENDERE�O INICIAL DA INTERRUP��O
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SER�O ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUP��ES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SA�DA DA INTERRUP��O                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUP��O

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.

SUBROTINA1

	;CORPO DA ROTINA

	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000000' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SA�DAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
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
	
	MOVLW .29					   ;Caso o ano seja menor que 30, h� a possibilidade de ser uma data fora da especifica��o
	MOVWF anoIntervaloFinal
	MOVLW .21					   ;Caso o ano seja menor que 21, h� a possibilidade de ser uma data fora da especifica��o
	MOVWF anoIntervaloInicial
	MOVLW .12					   ; Caso o mes seja maior que 13, consiste em uma data inexiste, ou seja data fora da especifica��o
	MOVWF mesLimite					   ; se for menor que 30 e maior que 21, de fato � uma data fora da especifica��o
	MOVLW .31
	MOVWF diaLimite
	
	; Variaveis da multiplicacao
	MOVLW .10
	MOVWF contaMes


	
;TRATAMENTO DE ERROS 	

VERIFICAERRO1 ; O c�digo ap�s este Label se diz respeito a verifica��o de caso o ano esteja no intervalo entre 21 e 30
	
	;VERIFICANDO SE O ANO � MENOR QUE 30
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoIntervaloFinal, W			; SUBTRA��O DO VALOR EM WORK  MENOS O ANO INTERVALO FINAL 30	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, OU SEJA ANO MENOR QUE 30
							; Caso seja 0, o c�digo ser� desviado para outro label, continuando o fluxo previsto pelo c�digo
	GOTO VERIFICAERRO2				; Ano n�o faz parte do intervalo, Label VerificaErro1 finalizado
	
							; SKIP acionado, sabemos que o ano � menor que 30
							;Sabendo que o fluxo do c�digo obteve uma interrup��o, sabemos de fato que o ano � menor que 30, por�m para o erro ser completo
							; Devemos saber se � maior que 21, logo verei se ele � menor que 21, pois caso seja estar� fora do intervalo
							;VERIFICANDO SE O ANO � MENOR QUE 21
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoIntervaloInicial, W			; SUBTRA��O DO VALOR EM WORK  MENOS O ANO, AGORA SENDO ANO INICIAL DO INTERVALO, 21	
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, 
							;OU SEJA ANO MENOR QUE 21, CASO SEJA 0, O ANO EST� NO INTERVALO 
	GOTO FORADAESPECIFICAO				; Data fora da especifica��o
	GOTO VERIFICAERRO2				;Ano n�o faz parte do intervalo, Label VerificaErro1 finalizado 

VERIFICAERRO2
	
	;VERIFICANDO SE O ANO EST� ENTRE 1910 E 2100
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoLimiteFinal, W				; SUBTRA��O DO VALOR EM WORK  MENOS O ANO LIMITE FINAL 100, 	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, OU SEJA ANO MENOR QUE 100
	GOTO VERIFICAERRO3				; Caso seja 0, o c�digo ser� desviado para outro label, continuando o fluxo previsto pelo c�digo

	MOVLW .0					; ZERANDO O WORK
	MOVFW AA					; ATRIBUINDO O ANO A VARIAVEL WORK 
	SUBWF anoLimiteInicial, W			; SUBTRA��O DO VALOR EM WORK  MENOS O ANO INICIAL DO INTERVALO, AGORA SENDO ANO INICIAL DO INTERVALO, 05
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, 
							;OU SEJA ANO MENOR QUE 10, SENDO UM MES VALIDO, LOGO SENDO 0, O ANO PODE EST� FORA DA ESPECIFICA��O

	
	GOTO VERIFICAERRO3				; Ano faz parte do intervalo 2021 a 1930, Fluxo do c�digo procede
	GOTO FORADAESPECIFICAO				; Data fora da especifica��o

	

VERIFICAERRO3
	
	;Verificar se o mes � inv�lido
	
	MOVLW .0					; ZERANDO O WORK
	MOVFW MM					; ATRIBUINDO O M�S A VARIAVEL WORK 
	SUBWF mesLimite, W				; SUBTRA��O DO VALOR EM WORK  MENOS O M�S LIMITE FINAL 13,	
	BTFSS STATUS, C					; SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, OU SEJA MES MENOR QUE 13
	GOTO  FORADAESPECIFICAO				; Label para Data fora da especifica��o
	GOTO  VERIFICAERRO4
	

	
VERIFICAERRO4
	
	;Verificando se o m�s � nulo 
	MOVFW MM
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a vari�vel MM n�o � nula, continuando o fluxo previsto pelo c�digo
							; Se bit Z = 1, logo ser� o dado da variavel m�s � nulo
	GOTO FORADAESPECIFICAO				; Data fora da especifica��o
	GOTO VERIFICAERRO5
	
	
	
VERIFICAERRO5
	
	;Verificar se o dia � valido
	MOVLW .0					; ZERANDO O WORK
	MOVFW DD					; ATRIBUINDO O DIA A VARIAVEL WORK 
	SUBWF diaLimite, W				; SUBTRA��O DO VALOR EM WORK  MENOS O DIA,COM INTUITO DE SABER SE O DIA � MENOR 31	
	BTFSS STATUS, C					;SE O BIT C FOR 1 A LINHA ABAIXO SER� PULADA, INDICANDO QUE O RESULTADO DA SUBTRA��O FOI NEGATIVO, 
	GOTO FORADAESPECIFICAO
	GOTO VERIFICAERRO6				;OU SEJA ANO MENOR QUE 32, SENDO UM DIA QUASE VALIDO, LOGO C SENDO IGUAL A 0, O ANO EST� FORA DA ESPECIFICA��O
	
	
VERIFICAERRO6
	
	;Verificar se o dia n�o � nulo
	MOVFW DD					
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a vari�vel DD, dia n�o � nula, continuando o fluxo previsto pelo c�digo
							; Se bit Z = 1, logo ser� o dado da variavel m�s � nulo
	GOTO FORADAESPECIFICAO				; Data NULA, fora da especifica��o
	GOTO DIACERTO1	    				; Se bit Z = 0, logo ser� desviado para outro label, continuando o fluxo previsto pelo c�digo


DIACERTO1
	MOVLW .0					; reiniciando o work
	MOVlW .24					; Atribuindo o dia ao work
	SUBWF DD, W					;verificando se � igual 24, pois o dia faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
							; Se bit Z = 1, logo o dia � 24, pois 24 - 24 = 0, n�o haver� skip de instru��o
	
	GOTO MESCERTO1					; logo ser� desviado para outro label para verificar o m�s
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF DD, W					; verificando se � igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
							; Se bit Z = 1, logo o dia � 21, pois 21 - 21 = 0, n�o haver� skip de instru��o
							
	;Dia 21 pode ser a data 21/10/21 caso os anos sejam subtraidos e resulte 0 pode ser a data, necessitando so verificar o m�s
	
	GOTO MESCERTO2					; Label para verificar se � dia 21/10/21
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF DD, W					; verificando se � igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
							; Se bit Z = 1, logo o dia � 21, pois 21 - 21 = 0, n�o haver� skip de instru��o
	GOTO MESCERTO1					; logo ser� desviado para outro label para verificar o mes
	
	MOVLW .0					; reiniciando o work
	MOVlW .10					; Atribuindo o dia ao work
	SUBWF DD, W					;verificando se � igual 21 novamente, pois outra data faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
	
	GOTO MESCERTO1
	MOVLW .0					
	MOVlW .2					
	SUBWF DD, W					
	BTFSC STATUS, Z					
							
	GOTO MESCERTO1					
	GOTO FORADAESPECIFICAO				;Caso nenhum dia seja confirmado, a data est� fora da especifica��o


MESCERTO2
	;Para a data que tem o dia igual ao ano 2021
	MOVLW .0					; reiniciando o work
	MOVlW .21					; Atribuindo o dia ao work
	SUBWF AA, W					; verificando se � igual ao ano 2021, pois o dia 21 j� foi verificado em DIACERTO1
	BTFSC STATUS, Z					; Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
	GOTO MESCERTO3					; Verificar o m�s para confirmar a data
	GOTO MESCERTO1					; Ainda h� uma data com o dia 21, logo o m�s deve ser verificado mesmo que a subtra��o do dia pelo ano resulte em 0
	
MESCERTO3
	;Verificando o m�s da data que o ano - dia resulta em 0
	MOVLW .0					; reiniciando o work
	MOVlW .10					; Atribuindo o dia ao work
	SUBWF MM, W					;verificando se � igual 21, pois o dia faz parte da tabela
	BTFSC STATUS, Z					;Caso o bit Z seja 0, pular� uma linha do c�digo indicando que a subtra��o n�o resultou em 0
							; Se bit Z = 1, logo o m�s � 10, pois 10 - 10 = 0
	GOTO DIADADATA1					; Label para aplicar o valor de W referente ao dia da data
	GOTO FORADAESPECIFICAO				; data fora da tabela

	
MESCERTO1	
	;Verifica��o de meses feita da mesma forma, com subta��o e teste do bit Z, a diferen�a que ser�o transferidas ou para o label ANOCERTO1
	;ou FORA DA ESPECIFICA��O
	
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
	;Validar o ano tamb�m testando o bit Z e direcionando para o Label da data correspondente ou para fora da especifica��o
	
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
	
	MOVLW .7					;02/04/2005, Sab�do
	GOTO FIM

DIADADATA3
	
	MOVLW .3					;10/08/2021, Ter�a-feira
	GOTO FIM

DIADADATA4
	
	MOVLW .5					;24/02/1955, Quinta-feira
	GOTO FIM

DIADADATA5
	
	MOVLW .1					;21/06/1970, Domingo
	GOTO FIM

FORADAESPECIFICAO
	
	;Caso os meses, dias e anos que n�o passarem nos testes de verifica��o vir�o para c�
	
	MOVLW .0					; Data fora da especifica��o
	GOTO FIM					; Programa finalizado


FIM
	GOTO FIM

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
