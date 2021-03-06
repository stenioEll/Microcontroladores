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
		INTERRUPTOR
		CONTADOR
		PERIODO
		VALORDIGITAL
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
	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.



	;CORPO DA ROTINA
TRATA_SINAL1
	CLRF W
	MOVLW .255			    ; Valor digital de 5V
	SUBWF VALORDIGITAL, W               ; Querendo saber se foi 5V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 5V convertido
	GOTO TRATA_SINAL2
	BSF GPIO, GP0
TRATA_SINAL2
	CLRF W
	MOVLW .204			    ; Valor digital de 4V
	SUBWF VALORDIGITAL, W               ; Querendo saber se foi 4V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 4V convertido
	GOTO TRATA_SINAL3
	GOTO TRATA_4V
TRATA_SINAL3
	CLRF W
	MOVLW .153			    ; Valor digital de 3V
	SUBWF VALORDIGITAL, W               ; Querendo saber se foi 3V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 3V convertido
	GOTO TRATA_SINAL4
	GOTO TRATA_3V
TRATA_SINAL4
	CLRF W
	MOVLW .102			    ; Valor digital de 2V
	SUBWF VALORDIGITAL, W               ; Querendo saber se foi 2V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 2V convertido
	GOTO TRATA_SINAL5
	GOTO TRATA_2V
TRATA_SINAL5
	CLRF W
	MOVLW .51			    ; Valor digital de 1V
	SUBWF VALORDIGITAL, W               ; Querendo saber se foi 1V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 1V convertido
	GOTO DESLIGALED
	GOTO TRATA_1V
TRATA_4V
	BSF GPIO, GP0
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .25		; inicializando com o valor gerado da diferen� de 64 - 39 = 25 para provocar o estouro em 20 us
	MOVWF TMR0		
TESTE400hz
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTE400hz
	INCF CONTADOR
	MOVLW .1		; VERIFICANDO SE CONTOU 1 VEZES 2,5K
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 2K 1 VEZ, TEREMOS 2,5K us e
	GOTO DESLIGALED
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	GOTO LIGALED
	
TRATA_3V
	BSF GPIO, GP0
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .25		; inicializando com o valor gerado da diferen� de 64 - 39 = 25 para provocar o estouro em 20 us
	MOVWF TMR0	

TESTE300hz
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTE200hz
	INCF CONTADOR
	MOVLW .1		; VERIFICANDO SE CONTOU 1 VEZES 2,5K
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 2K 1 VEZ, TEREMOS 2,5K us e
	GOTO 
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	GOTO LIGALED
TRATA_2V
	BSF GPIO, GP0
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .25		; inicializando com o valor gerado da diferen� de 64 - 39 = 25 para provocar o estouro em 20 us
	MOVWF TMR0

TESTE200hz
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTE100hz
	INCF CONTADOR
	MOVLW .1		; VERIFICANDO SE CONTOU 1 VEZES 2,5K
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 2K 1 VEZ, TEREMOS 2,5K us e
	GOTO 
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	GOTO LIGALED
	GOTO TESTEGP0_ON
TRATA_1V
	BSF GPIO, GP0
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .25		; inicializando com o valor gerado da diferen� de 64 - 39 = 25 para provocar o estouro em 20 us
	MOVWF TMR0
TESTE100hz
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTE500hz
	INCF CONTADOR
	MOVLW .1		; VERIFICANDO SE CONTOU 1 VEZES 2,5K
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 2K 1 VEZ, TEREMOS 2,5K us e
	GOTO 
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	GOTO LIGALED
	GOTO TESTEGP0_ON
 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00010000'	;CONFIGUREI O GP4 COMO ENTRADA, POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS S�O SA�DAS, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;COMO SA�DAS
	MOVLW	B'00011000'	;divisor de clock configurado para dividir por 8 e an3 configurado como entrada anal�gico
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000101'	; 1:64
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'10100000'	;lIGUEI A INTERRUP��O PARA O ESTOURO 
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000000'	;N utilizarei interrup��o 
	MOVWF	IOC		;DEFINE OP��ES DE INTERRUP��ES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00001101'     ;habilitei o conversor e selecionei o canal anal�gico 3 referente ao gp4
	MOVWF	ADCON0 
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	BSF ADCON0,1                         ;Setando o bit go/done para iniciar a convers�o
CONV
	BTFSC ADCON0, 1                      ;Testo o mesmo bit go/done se foi para 0, pois indicar� para mim se a convers�o foi finalizada 
	GOTO CONV                           ; Fica no loop enquanton�o tiver terminado a convers�o
	MOVFW ADRESH                        ; Movendo o valor da convers�o que estar� contido no adresh, pois configurei o registrador ADCON0 com a justificativa pela esquerda 
	MOVWF VALORDIGITAL                  ; Salvando esse sinal anal�gico convertido para digital em uma vari�vel para tratar futuramente
	CALL TRATA_SINAL1
DESLIGALED
	BCF GPIO, GP0
	CLRF ADRESH
	CLRF ADCON0, 1
	GOTO MAIN



FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
