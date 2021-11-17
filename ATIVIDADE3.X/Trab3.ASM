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

ALGORITMO		 
	CLRF TMR0		;Zero o timer para contar o tempo que o sinal está em em nivel alto 
	
CONTADOR
	BTFSC GPIO, GP2		 ;gp2 foi para nivel baixo? Se sim continue contando até subir novamente 
	GOTO CONTADOR		 ;continuar contando o tempo
	GOTO AGUARDA		 ; Label para manter o tmr0 contando enquanto ficou embaixo até o proximo pulso
	
AGUARDA				
	BTFSS GPIO, GP2		 ;Testando a proxima subida do clock para ter o periodo da onda
	GOTO AGUARDA		
	MOVFW TMR0		 ; Movendo o valor do tmr0 para o work 
	MOVWF PERIODO		 ; Movendo o periodo para uma variavel
	GOTO Hz5k		; Indo verificar se é a frequencia de 5000 hertz
Hz5k
	
	MOVLW .87		; Movendo o INTERVALO inicial 180/2 pois o PRE SCALE É 1:2 conta 1 micro a cada 2 micro, respeitando a margem de erro  da frequência de onda 5000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estará em 0, indicando que a subtração resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instrução abaixo , pois não é menor que o intervalo inicial  
	GOTO Hz10k		; Label para testar se é outra frequência
	
	MOVLW .110		; Movendo o INTERVALO inicial 220/2, respeitando a margem de erro  da frequência de onda 5000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estará em 0, indicando que a subtração resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instrução abaixo 
	GOTO Hz10k		; Label para testar se é outra frequência
	GOTO LED0		; Label para acender o led correspondente
	
Hz10k
	MOVLW .42		; Movendo o INTERVALO inicial 90/2, respeitando a margem de erro  da frequência de onda 10000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estará em 0, indicando que a subtração resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instrução abaixo , pois não é menor que o intervalo inicial 
	GOTO Hz20k		; Label para testar se é outra frequência
	
	MOVLW .55		; Movendo o INTERVALO inicial 110/2, respeitando a margem de erro  da frequência de onda 10000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estará em 0, indicando que a subtração resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instrução abaixo  
	GOTO Hz20k		; Label para testar se é outra frequência
	GOTO LED1		; Label para acender o led correspondente
	
Hz20k
	MOVLW .18		; Movendo o INTERVALO inicial 45/2, respeitando a margem de erro  da frequência de onda 20000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estará em 0, indicando que a subtração resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instrução abaixo , pois não é menor que o intervalo inicial
	GOTO Hz30k		; Label para testar se é outra frequência
	
	MOVLW .27		; Movendo o INTERVALO inicial 55/2, respeitando a margem de erro  da frequência de onda 20000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estará em 0, indicando que a subtração resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instrução abaixo 
	GOTO Hz30k		; Label para testar se é outra frequência
	GOTO LED4		; Label para acender o led correspondente
Hz30k
	MOVLW .14		; Movendo o INTERVALO inicial 33/2, respeitando a margem de erro  da frequência de onda 30000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O periodo pelo work, caso seja menor, o bit C estará em 0, indicando que a subtração resultou em um numero negativo
	BTFSS STATUS, C		; teste do bit C se for 1 pula a instrução abaixo , pois não é menor que o intervalo inicial 
	GOTO Hz10k		; Label para testar se é outra frequência
	
	MOVLW .18		; Movendo o INTERVALO inicial 36/2, respeitando a margem de erro  da frequência de onda 30000 hertz para o work
	SUBWF PERIODO, W	; Subtraindo e se O resultado for menor, o bit C estará em 0, indicando que a subtração resultou em um numero positivo ou igual a 220/2
	BTFSC STATUS, C		; teste do bit C se for 0, pula a instrução abaixo 
	GOTO ERRO		; Label para testar se é outra frequência
	GOTO LED5		; Label para acender o led  correspondente

LED0 
	BSF GPIO, GP0		; Atribuindo nivel lógico 1 para o gp0 para indicar o acendimento do led da frequência 5k
	GOTO MAIN
	
LED1
	BSF GPIO, GP1		; Atribuindo nivel lógico 1 para o gp1 para indicar o acendimento do led da frequência 10k
	GOTO MAIN
LED4
	BSF GPIO, GP4		; Atribuindo nivel lógico 1 para o acendimento do led da frequência 20k
	GOTO MAIN
LED5
	BSF GPIO, GP5		; Atribuindo nivel lógico 1 para o acendimento do led da frequência 30k
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
	MOVWF	TRISIO		;COMO SAÍDAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000000'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'10000100'
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	BSF GPIO, GP0
	BCF INTCON, GP2
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN

	BTFSC GPIO, GP2		 ;Verificando se GP2 está em nivel lógico baixo
	CALL ALGORITMO
	GOTO MAIN
ZERA

	GOTO CONTADOR




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
