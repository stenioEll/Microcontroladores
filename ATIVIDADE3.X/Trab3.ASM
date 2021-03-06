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
		PERIODO
		ONDA
		int5kInicial
		int5kFinal
		int10kInicial
		int10kFinal
		int20kInicial
		int20kFinal
		int30kInicial
		int30kFinal
		
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

ALGORITMO		 
	CLRF TMR0		;Zero o timer para contar o tempo que o sinal est� em em nivel alto 
	
CONTADOR
	BTFSC GPIO, GP2		 ;gp2 foi para nivel baixo? Se sim continue contando at� subir novamente 
	GOTO CONTADOR		 ;continuar contando o tempo
	GOTO AGUARDA		 ; Label para manter o tmr0 contando enquanto ficou embaixo at� o proximo pulso
	
AGUARDA				
	BTFSS GPIO, GP2		 ;Testando a proxima subida do clock para ter o periodo da onda
	GOTO AGUARDA		
	MOVFW TMR0		 ; Movendo o valor do tmr0 para o work 
	MOVWF PERIODO		 ; Movendo o periodo para uma variavel
	GOTO Hz5k		; Indo verificar se � a frequencia de 5000 hertz
Hz5k
	
	MOVLW .87		; Movendo o INTERVALO inicial 180/2 pois o PRE SCALE � 1:2 conta 1 micro a cada 2 micro, respeitando a margem de erro  da frequ�ncia de onda 5000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instru��o abaixo , pois n�o � menor que o intervalo inicial  
	GOTO Hz10k		; Label para testar se � outra frequ�ncia
	
	MOVLW .110		; Movendo o INTERVALO inicial 220/2, respeitando a margem de erro  da frequ�ncia de onda 5000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instru��o abaixo 
	GOTO Hz10k		; Label para testar se � outra frequ�ncia
	GOTO LED0		; Label para acender o led correspondente
	
Hz10k
	MOVLW .42		; Movendo o INTERVALO inicial 90/2, respeitando a margem de erro  da frequ�ncia de onda 10000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instru��o abaixo , pois n�o � menor que o intervalo inicial 
	GOTO Hz20k		; Label para testar se � outra frequ�ncia
	
	MOVLW .55		; Movendo o INTERVALO inicial 110/2, respeitando a margem de erro  da frequ�ncia de onda 10000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instru��o abaixo  
	GOTO Hz20k		; Label para testar se � outra frequ�ncia
	GOTO LED1		; Label para acender o led correspondente
	
Hz20k
	MOVLW .18		; Movendo o INTERVALO inicial 45/2, respeitando a margem de erro  da frequ�ncia de onda 20000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instru��o abaixo , pois n�o � menor que o intervalo inicial
	GOTO Hz30k		; Label para testar se � outra frequ�ncia
	
	MOVLW .27		; Movendo o INTERVALO inicial 55/2, respeitando a margem de erro  da frequ�ncia de onda 20000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instru��o abaixo 
	GOTO Hz30k		; Label para testar se � outra frequ�ncia
	GOTO LED4		; Label para acender o led correspondente
Hz30k
	MOVLW .14		; Movendo o INTERVALO inicial 33/2, respeitando a margem de erro  da frequ�ncia de onda 30000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instru��o abaixo , pois n�o � menor que o intervalo inicial 
	GOTO Hz10k		; Label para testar se � outra frequ�ncia
	
	MOVLW .18		; Movendo o INTERVALO inicial 36/2, respeitando a margem de erro  da frequ�ncia de onda 30000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estar� em 0, indicando que a subtra��o resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instru��o abaixo 
	GOTO ERRO		; Label para testar se � outra frequ�ncia
	GOTO LED5		; Label para acender o led  correspondente

LED0 
	BSF GPIO, GP0		; Atribuindo nivel l�gico 1 para o gp0 para indicar o acendimento do led da frequ�ncia 5k
	GOTO MAIN
	
LED1
	BSF GPIO, GP1		; Atribuindo nivel l�gico 1 para o gp1 para indicar o acendimento do led da frequ�ncia 10k
	GOTO MAIN
LED4
	BSF GPIO, GP4		; Atribuindo nivel l�gico 1 para o acendimento do led da frequ�ncia 20k
	GOTO MAIN
LED5
	BSF GPIO, GP5		; Atribuindo nivel l�gico 1 para o acendimento do led da frequ�ncia 30k
	GOTO MAIN
ERRO
	GOTO FIM
	;CORPO DA ROTINA

	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00100100' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SA�DAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000000'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'10000100'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	BSF GPIO, GP0
	BCF INTCON, GP2
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN

	BTFSC GPIO, GP2		 ;Verificando se GP2 est� em nivel l�gico baixo
	CALL ALGORITMO
	GOTO MAIN
ZERA

	GOTO CONTADOR




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
