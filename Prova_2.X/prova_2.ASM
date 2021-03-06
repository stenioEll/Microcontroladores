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
	MOVLW	B'00000111'	;CONFIGUREI O GP0 E GP2 COMO ENTRADA SENDO OS SENSORES E GP1 COMO ENTRADA Q RECEBR� O SINAL ANAL�GICO REFERENTE AO SENSOR DE TEMP, E OS MOTORES SAIDA, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;COMO SA�DAS
	MOVLW	B'00000010'	;ANSEL CONFIGURADO COMO ENTRADA ANAL�GICA REFERENTE A GP1
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000111'	; AJUSTEI O PRE-ESCALE PARA 1:256
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'10000000'	;CHAVE GERAL LIGADA
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000000'	;N utilizarei interrup��o 
	MOVWF	IOC		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW   B'10001010'	;Ajustando a tens�o de refer�ncia para o high, escala do valor 9 referente a config do tmax de 2,6V
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000000'     ;N�O UTILIZAREI CONVERSOR
	MOVWF	ADCON0 
	MOVLW	B'00000100'	; Configurando o comparador como 100, pois � o modelo que se aplica a prova
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
LABEL1
	BTFSC GPIO, GP0         ; SENSOR1 T� EM 0? SE SIM DESLIGA O MOTOR1, SE NAO LIGA O MOTOR1
	GOTO LIGAMOTOR1
	GOTO DESLIGAMOTOR1

DESLIGAMOTOR1
	BCF GPIO, GP4          ;DESLIGA O MOTOR 1
	GOTO LABEL2
LIGAMOTOR1
	BSF GPIO, GP4           ; LIGA MOTOR1
	GOTO LABEL2
LABEL2
	BTFSC GPIO, GP2         ; SENSOR2 T� EM 0? SE SIM DESLIGA O MOTOR2, SE NAO LIGA O MOTOR2
	GOTO LIGAMOTOR2
	GOTO DESLIGAMOTOR2
DESLIGAMOTOR2
	BCF GPIO, GP5          ;DESLIGA O MOTOR 2
	GOTO LABEL3
LIGAMOTOR2
	BSF GPIO, GP5           ; LIGA MOTOR 2
	GOTO LABEL3
LABEL3 
	BTFSS CMCON, 6          ; VERIFICANDO SE A TEMPERATURA � MAIOR DO QUE A TEMPERATURA M�XIMA
	GOTO DESLIGATUDO
	GOTO LABEL1
DESLIGATUDO
	BCF GPIO, GP4           ; DESLIGA TODOS OS MOTORES
	BCF GPIO, GP5
	GOTO DELAY
DELAY
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferen� de 256 - 195 = 61 para provocar o estouro com 50us
	MOVWF TMR0		
CONTA
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO CONTA
	INCF CONTADOR
	MOVLW .200		; VERIFICANDO SE CONTOU 200 VEZES 50Us TEREI OS 10 MILH�ES US Q EQUIVALE A 10 SEGUNDOS
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 2000 VEZES, TEREMOS 10M us e
	GOTO LABEL1
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferen� de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO CONTA
	
	
	




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
