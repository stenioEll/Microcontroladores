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
#include "p16f628a.inc"

; CONFIG
; __config 0xFFFF
 __CONFIG _FOSC_EXTRCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_ON & _LVP_ON & _CPD_OFF & _CP_OFF

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
		W_TEMP		;REGISTRADORES TEMPOR�RIOS PARA USO
		STATUS_TEMP	;JUNTO �S INTERRUP��ES

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
INICIA
	MOVLW .208
	BANK1                                ;Movendo pr2 de banco pois � necess�rio
	MOVWF PR2
	BANK0				    ; voltando de banco
	;VOLTAR PARA O BANK0
CONTA
	BTFSS PIR1,  TMR2IF
	GOTO CONTA
	;CLRF PORTB                 
	BCF PIR1, TMR2IF
	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000010'
	MOVWF	TRISA	       ;CONFIGURA O PINO 0 PARA O PRIMEIRO CASO QUE PINO 0 � ENTRADA
	MOVLW	B'10000100'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000000'
	MOVWF	TRISB	       ;CONFIGURA O PINO 0 PARA O PRIMEIRO CASO QUE PINO 0 � ENTRADA
	MOVLW   B'11100010'     ; CONFIGURANDO PARA LOW RANGE E O VALOR 2 ENCONTRADO NO C�LCULO REFERENTE A 0,35V e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00100101'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO
	MOVLW   B'01110110'     ; DEFINI O PRESCALE COMO PARA 1:16 E O POSCALE 1:15 E ATIVEI O TIMER 2
	MOVWF   T2CON


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN

	;CORPO DA ROTINA PRINCIPAL
	;OBSERVA��ES
	;USEI COMPARADOR 2
	;TABELA PARA AUXILIAR NA VERIFICA��O DO DISPLAY PELO PORTB
	;OS C�LCULOS NEM SEMPRE DERAM A TENS�O EXATA PARA CONFIGURAR A TENS�O DE REFERENCIA NO COMPARADOR, LOGO ALGUNS INTERVALOS MAIORES IGUAIS PRECISAM DE UMA CERTA MARGEM EX: 0,35<=V
	;DISPLAY DE 7 SEGMENTOS
	
	;               A                                                               *     PORTB      *
	;             -----                         A  = RB0         0 = |0||0|1|1|1|1|1|1|                 5 = |0||1|1|0|1|1|0|1|
	;           F|     |B                       B  = RB1         1 = |0||0|0|0|0|1|1|0|                 6 = |0||1|1|1|1|1|0|1|
	;            |  G  |                        C  = RB2         2 = |0||1|0|1|1|0|1|1|                 7 = |0||0|0|0|0|1|1|1|
	;             -----                         D  = RB3         3 = |0||1|0|0|1|1|1|1|                 8 = |0||1|1|1|1|1|1|1|
	;           E|     |C                       E  = RB4         4 = |0||1|1|0|0|1|1|0|                 9 = |0||1|1|0|1|1|1|1|
	;            |     |                        F  = RB5          
	;             -----                         G  = RB6         
	;               D
	;
	;
	;
	;
C1                              ;CASO DE TESTE SE A TENS�O � MENOR QUE 0,35 VOLTS
	BANK1                   ; CHAVEANDO OS BANCOS PARA CONFIGURA VRCON, POIS A TENS�O REFERENCIA IR� MUDAR CONSTANTEMENTE
	MOVLW   B'11100010'     ; CONFIGURANDO PARA LOW RANGE E O VALOR 2 ENCONTRADO NO C�LCULO REFERENTE A 0,35V e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0
	BTFSS CMCON, 7		  ; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY0
	GOTO C2
DISPLAY0                        ; Acende segmentos para representar o 0 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 1
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 4
	BSF  PORTB, 5
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS 
C2				; Caso em que  seja 0,35 <= x < 0,7, se veio para c� ent�o sabemos que � maior ou igual que 0,35 
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11100011'     ; CONFIGURANDO PARA LOW RANGE E O VALOR 3 ENCONTRADO NO C�LCULO REFERENTE A 0,7V e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0				;RETORNA PARA O BANCO
	BTFSS CMCON, 7		  ; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY1
	GOTO C3
DISPLAY1                        ; Acende segmentos para representar o 1 no display
	CLRF PORTB
	BSF  PORTB, 1
	BSF  PORTB, 2
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C3                              ; Caso em que  seja 0,7 <= x < 1,05, se veio para c� ent�o sabemos que � maior ou igual que 0,7 
	
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11100101'     ; CONFIGURANDO PARA LOW RANGE E O VALOR 5 ENCONTRADO NO C�LCULO REFERENTE A 1,05 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY2
	GOTO C4
DISPLAY2                        ; Acende segmentos para representar o 2 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 1
	BSF  PORTB, 3
	BSF  PORTB, 4
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C4                              ; Caso em que  seja 1,05 <= x < 1,4, se veio para c� ent�o sabemos que � maior ou igual que 1,05 
	
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11000001'     ; CONFIGURANDO PARA HIGH RANGE E O VALOR 1 ENCONTRADO NO C�LCULO REFERENTE A 1,4 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY3
	GOTO C5
DISPLAY3                       ; Acende segmentos para representar o 3 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 1
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C5                              ; Caso em que  seja 1,4 <= x < 1,75, se veio para c� ent�o sabemos que � maior ou igual que 1,4 
	
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11000011'     ; CONFIGURANDO PARA HIGH RANGE E O VALOR 3 ENCONTRADO NO C�LCULO REFERENTE A 1,75 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY4
	GOTO C6
DISPLAY4                        ; Acende segmentos para representar o 4 no display
	CLRF PORTB
	BSF  PORTB, 1
	BSF  PORTB, 2
	BSF  PORTB, 5
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS

C6                              ; Caso em que  seja 1,75 <= x < 2,1, se veio para c� ent�o sabemos que � maior ou igual que 1,75
	
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11000101'     ; CONFIGURANDO PARA LOW RANGE E O VALOR 10 ENCONTRADO NO C�LCULO REFERENTE A 2,1 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY5
	GOTO C7
DISPLAY5                        ; Acende segmentos para representar o 5 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 5
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C7                               ; Caso em que  seja 2,1 <= x < 2,45, se veio para c� ent�o sabemos que � maior ou igual que 2,1
                             
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11001000'     ; CONFIGURANDO PARA HIGH RANGE E O VALOR 8 ENCONTRADO NO C�LCULO REFERENTE A 2,1 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY6
	GOTO C8
DISPLAY6                        ;Acende segmentos para representar o 6 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 4
	BSF  PORTB, 5
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C8                               ; Caso em que  seja 2,45 <= x < 2,85, se veio para c� ent�o sabemos que � maior ou igual que 2,45
                             
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11001010'     ; CONFIGURANDO PARA HIGH RANGE E O VALOR 10 ENCONTRADO NO C�LCULO REFERENTE A 2,85 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY7
	GOTO C9
DISPLAY7                        ;Acende segmentos para representar o 7 no display
	CLRF PORTB
	BSF PORTB, 0
	BSF PORTB, 1
	BSF PORTB, 2            ;MOSTRANDO O VALOR 7 EM BIN�RIO NO DISPLAY
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
C9                               ; Caso em que  seja 2,85 <= x < 3,2, se veio para c� ent�o sabemos que � maior ou igual que 2,45
                             
	BANK1                   ; CHAVEANDO OS BANCOS PARA FAZER A MUDAN�A DO INTERVALO COMPARADO
	MOVLW   B'11001100'     ; CONFIGURANDO PARA HIGH RANGE E O VALOR 12 ENCONTRADO NO C�LCULO REFERENTE A 3,2 e ligando ele
	MOVWF	VRCON		;DEFINE A TENS�O DE REFERENCIA
	BANK0			;RETORNA PARA O BANCO
	BTFSS CMCON, 7		; se for menor que a tens�o bit 7 = 0, se n�o bit 7 = 1, pois estou usando o comparador 2
	GOTO DISPLAY8
	GOTO DISPLAY9
DISPLAY8                        ;Acende segmentos para representar o 8 no display
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 1
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 4
	BSF  PORTB, 5
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
DISPLAY9                        ;SE FOR MAIOR QUE TODOS OS INTERVALOS OU IGUAL A 3,2 O 9 DEVE SER MOSTRADO NO DISPLAY
	CLRF PORTB
	BSF  PORTB, 0
	BSF  PORTB, 1
	BSF  PORTB, 2
	BSF  PORTB, 3
	BSF  PORTB, 5
	BSF  PORTB, 6
	CALL INICIA
	GOTO C1                 ;LOOP DE CONTROLE DE INTERVALOS
	
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
