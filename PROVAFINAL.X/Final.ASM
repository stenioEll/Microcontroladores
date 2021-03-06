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

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_ON & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT   ; MCLRE OFF PARA MANTER TODOS OS LEDS APAGADOS INCLUSIVE O GP3

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
		CONTADOR
		
	
	
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
	; VERIFICANDO A POSI��O DA INTERRUP�A�
LIMPAWDT
	CLRWDT               ; LIMPANDO WDT
PISCALED0                   ;LABEL DE CONTROLE DO PISCA DO LED REFERENTE AO GP0, O QUAL DEVE PISCAR 4 VEZES E SE MANTER LIGADO POR 50 MS E DEPOIS DESLIGADO POR 50 MS
	BANK1
	MOVLW	B'00000000'	;CONFIGUREI O GP1 COMO saida para poder desligar todos os leds
	MOVWF	TRISIO		;COMO SA�DAS
	;MOVLW	B'00000111'	; AJUSTEI O PRE-ESCALE PARA 1:256 E DESLIGUEI O BIT 3 INDICANDO QUE USAREI O TMR0
	;MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	BANK0
	CLRF GPIO               ;desligando todos os leds
LIGA50US
	BSF GPIO, GP0             ;LIGANDO LED
	MOVLW B'10101111'       ; MOVENDO OS PRIMEIROS 8 BITS DO RESULTADO DA SUBTRA��O DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1L
	MOVLW B'00111100'       ; MOVENDO OS ULTIMOS 8 BITS DO RESULTADO DA SUBTRA��O DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1H
	
	;CLRF TMR0		;ZERANDO O TMR0
	;MOVLW .61		; inicializando com o valor gerado da diferen�a de 256 - 195 = 61 para provocar o estouro com 50us
	;MOVWF TMR0
	GOTO CONTALIGADO
CONTALIGADO
	BTFSS PIR1, TMR1IF	; estourou? Sim! CONTA DESLIGADO
	GOTO CONTALIGADO
	GOTO DESLIGA50US
DESLIGA50US
	BCF GPIO, GP0             ;DESLIGANDO LED
	MOVLW B'10101111'       ; MOVENDO OS PRIMEIROS 8 BITS DO RESULTADO DA SUBTRA��O DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1L
	MOVLW B'00111100'       ; MOVENDO OS ULTIMOS 8 BITS DO RESULTADO DA SUBTRA��O DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1H
	GOTO CONTADESLIGADO
CONTADESLIGADO
	BTFSS PIR1, TMR1IF	; estourou? Sim! vai incrementar a variavel
	GOTO CONTADESLIGADO
	INCF CONTADOR           ;PISCOU, incrementa a vari�vel para controlar a contagem
	MOVLW .4		; VERIFICANDO SE CONTOU 4 VEZES 50Us A TAREFA ACABOU
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 2000 VEZES, TEREMOS 10M us e
	GOTO CONFIGURA
	GOTO DESLIGA50US
CONFIGURA                      ;VOLTANDO AS CONFIGURA��ES ANTERIORES E SAINDO DA INTERRUP��O
	BANK1
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA para poder gerar a interrup��o,  e os demais saida, sabendo que gp0 corresponde ao led que deve ser aceso POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS S�O SA�DAS, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;COMO SA�DAS
	;MOVLW	B'00001101'	; AJUSTEI O PRE-ESCALE PARA 1:32 E SETEI O BIT 3 INDICANDO QUE � REFERENTE AO WATCHDOG
	;MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	BANK0
	BCF INTCON, GPIF
	
	



	
	

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



	;CORPO DA ROTINA


 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA para poder gerar a interrup��o,  e os demais saida, sabendo que gp0 corresponde ao led que deve ser aceso POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS S�O SA�DAS, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;
	CLRF ANSEL
	MOVLW	B'00001101'	; AJUSTEI O PRE-ESCALE PARA 1:32 E SETEI O BIT 3 INDICANDO QUE � REFERENTE AO WATCHDOG
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'10001000'	;ATIVANDO INTERRUP��O POR PORTA 
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000010'	;INTERRUP��O PELA A MUDAN�A DE PORTA DO GP1 ATIVADA
	MOVWF	IOC		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW   B'00000000'	;N�O UTILIZAREI
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000001'     ;USANDO PRESCALE 1:1 PARA CONTAR 50 MS E HABILITEI O 
	MOVWF	T1CON 
	MOVLW	B'00000000'     ;DESLIGANDO O REGISTRADOR DE CONVERSAO
	MOVWF	ADCON0 
	MOVLW	B'00000111'	; DESLIGANDO O CMCON REGISTRADOR DE COMPARA��O
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
DORME   ;Label que far� o microcontrolador dormir
	CLRF GPIO
	SLEEP		    ; O MICRO ACORDAR� QUANDO WDT ESTOURAR, COM O PRE-SCALE DE 32, PR�XIMO A 550 MS, RESPEITANDO A MARGEM DE ERRO
	NOP
AGUARDAINSTRUCAO            ;logo para executar qualquer tarefa enquanto o micro esta acordado, mude o gp1 de estado
	GOTO AGUARDAINSTRUCAO
	GOTO DORME
	
	
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     CONSUMO DE ENERGIA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;MODO SLEEP
	
;A CORRENTE DO WATCHDOG PARA TENS�O DE 5V � DE 17UA, ELE SER� UTILIZADO POR 2,2SEGUNDOS, AP�S ISSO � LIMPO
;Convertendo 2,2 segundos para horas temos 0,000611111 que � aproximadamente 611 uH
;Multiplicando pelo valor da corrente de WDT teremos 17UA * 611Uh = 0,010378uH
;O consumo do watchdog � de 0,010378uWh

;MODO ACORDADO
; A CORRENTE PARA ACENDER UM LED � DE 1UA para 5V no pior caso o programa roda em 60us
; Transformando 60us em horas temos 0,016667 uH 
; Multiplicando pela a corrente teremos  0,016667uWh pois a corrente � 1uA, esse � o consumo no pior caso

; ECONOMIA
; Enquanto o microcontrolador dorme o consumo de energia por 2,2 segundos � equivalente a 0,010378 uWh logo 
; Fazendo o consumo quando o microcontrolador est� ligado - est� desligado teremos =  0,016667uWh - 0,010378 uWh
; Portanto economiza-se 0,006289uWh, pois com o sleep o funcionamento do gpio estar� desligado 


FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
