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
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.



	;CORPO DA ROTINA
;CONDICAO1
;	BSF GPIO, GP2		; SE a temperatura � maior que a tmax, liga o compressor
;	;Configurando para Tmin
;	BANK1
;	MOVLW   B'10000111'	;Ajustando a tens�o de refer�ncia para o low(vrr), escala do valor 7 referente a config do tmin
;	MOVWF	VRCON
;	BANK0
;	GOTO C3
;CONDICAO2
;	BCF GPIO, GP2		; SE a temperatura � menor que a tmIN, desliga o compressor
;	;Configurando para Tmax
;	BANK1
;	MOVLW   B'10001010'	;Ajustando a tens�o de refer�ncia para o high(vrr), escala do valor 10 referente a config do tmax
;	MOVWF	VRCON
;	BANK0
;	GOTO C1

 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA, POIS RECEB O SINAL DE TEMPERATURA, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;COMO SA�DAS
	MOVLW	B'00000010'	;divisor de clock configurado para dividir por 8 e an3 configurado como entrada anal�gico
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000101'	; 1:64
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'	;lIGUEI A INTERRUP��O PARA O ESTOURO 
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000000'	;N utilizarei interrup��o 
	MOVWF	IOC		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW   B'10001010'	;Ajustando a tens�o de refer�ncia para o high, escala do valor 10 referente a config do tmax
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000101'     ;habilitei o conversor e selecionei o canal anal�gico 1 referente ao gp1
	MOVWF	ADCON0 
	MOVLW	B'00000100'	; Configurando o comparador como 100, pois � o modelo que se aplica a atividade
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C1
	BTFSC CMCON, 6          ; COMPARANDO TENS�O REFERANCIAL COM A ENTRADA, SE A ENTRADA FOR MAIOR, OUTPUT = 0, SE N�O OUTPUT = 1
	GOTO C1
	BSF GPIO, GP2		; SE a temperatura � maior que a tmax, liga o compressor
	;Configurando para Tmin
	BANK1
	MOVLW   B'10100111'	;Ajustando a tens�o de refer�ncia para o low(vrr), escala do valor 7 referente a config do tmin
	MOVWF	VRCON
	BANK0
C2
	BTFSS CMCON, 6
	GOTO C2
	BCF GPIO, GP2
	;Configurando para Tmin
	BANK1
	MOVLW   B'10001010'	;Ajustando a tens�o de refer�ncia para o high(vrr), escala do valor 10 referente a config do tmax
	MOVWF	VRCON
	BANK0
	GOTO C1
	
	;BSF GPIO, GP2		; SE a temperatura � maior que a tmax, liga o compressor
	;Configurando para Tmin
	;MOVLW   B'10000111'	;Ajustando a tens�o de refer�ncia para o low(vrr), escala do valor 7 referente a config do tmin
	;MOVWF	VRCON
	;GOTO MAIN
;2
	;BTFSS CMCON, 6
	;GOTO C2
	;CALL CONDICAO2
	;BSF GPIO, GP2		; SE a temperatura � menor que a tmIN, desliga o compressor
	;Configurando para Tmax
	;MOVLW   B'10001010'	;Ajustando a tens�o de refer�ncia para o high(vrr), escala do valor 10 referente a config do tmax
	;MOVWF	VRCON
	;GOTO CONDICAO2
;C3
	;GOTO FIM

	
	




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
