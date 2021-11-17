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
		INTERRUPTOR
		CONTADOR
		PERIODO
		OPCAO
		CONTADOR0
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
	;BTFSS INTCON, 1
	;GOTO ALERTA
	;GOTO ESQUERDA
	BCF GPIO, GP4
	BCF GPIO, GP4
ALERTA
	BTFSS GPIO, GP0                    ;TESTANDO SE GP0 TA ATIVADO 
	GOTO DIREITA			    ; OUTRO TESTE
	GOTO OPC1
OPC1
	MOVLW .1			;SALVANDO A OPCAO 1 QUE IDENTIFICA Q O ALERTA FOI LIGADO
	MOVWF OPCAO
	BCF INTCON, 0			    ; LIMPANDO A FLAG 
	GOTO PRIORIDADE2
DIREITA
	BTFSS GPIO, GP1                    ;SE GP1 E GP2 FORMAREM 01 Q É 1 EM BINARIO, LOGO TESTO SE GP1 ESTÁ EM 1 E GP2 EM 0 
	GOTO ESQUERDA			    ; OUTRO TESTE
	GOTO OPC2
OPC2
	MOVLW .2                           ;SALVANDO A OPCAO 2 QUE IDENTIFICA Q O LED-D DIREITO FOI LIGADO
	MOVWF OPCAO
	BCF INTCON, 0			    ; LIMPANDO A FLAG DO GP2
	GOTO SAI_INT
ESQUERDA
	BTFSS GPIO, GP2                    ;SE GP1 E GP2 FORMAREM 10 Q É 2 EM BINARIO, LOGO TESTO SE GP1 ESTÁ EM 0 E GP2 EM 1 
	GOTO SAI_INT			   
	GOTO OPC3			   
OPC3
	MOVLW .3
	MOVWF OPCAO			;SALVANDO A OPCAO 3 QUE IDENTIFICA Q O LED-E FOI LIGADO
	BCF INTCON, 0			;LIMPANDO A FLAG
	GOTO SAI_INT	
PRIORIDADE2
	BCF GPIO, GP4     ; DESLIGANDO OS LEDS
	BCF GPIO, GP5	  
	BSF GPIO, GP4     ; LIGANDO O LED ESQUERDO
	BSF GPIO, GP5	  ; LIGANDO O LED DIREITO
	GOTO CONTAGP0_ON
CONTAGP0_ON
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0		
TESTEGP0_ON
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTEGP0_ON
	INCF CONTADOR0
	MOVLW .10		; VERIFICANDO SE CONTOU 10 VEZES 50Us
	SUBWF CONTADOR0, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 10 VEZES, TEREMOS 500K us e
	GOTO DESLIGAGP0_ON
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO TESTEGP0_ON
DESLIGAGP0_ON
	BCF GPIO, GP4     ; DESLIGANDO OS LEDS
	BCF GPIO, GP5
	CLRF CONTADOR0
	GOTO CONTAGP0_OFF	   ; CONTA DESLIGADO
CONTAGP0_OFF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0		
TESTEGP0_OFF
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTEGP0_OFF
	BTFSS GPIO, GP0
	GOTO SAI_INT
	INCF CONTADOR0
	MOVLW .10		; VERIFICANDO SE CONTOU 10 VEZES 50Us
	SUBWF CONTADOR0, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 10 VEZES, TEREMOS 500K us e
	GOTO ZERAGP0
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO TESTEGP0_OFF
ZERAGP0
	CLRF CONTADOR0
	;BTFSS GPIO, GP0
	GOTO SAI_INT
	;GOTO MAIN	  ; CONTA DESLIGADO

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
PRIORIDADE                          ; LOOP PARA MANTER ACESO OS LEDS RESPECTIVO A LAVANCA Q AINDA ESTA LIGADA
	BTFSC GPIO, GP2		    ; SE A FLAG DE GP2 ESTIVER ATIVA
	GOTO ESQUERDA_INT
	BTFSS GPIO, GP1
	GOTO MAIN
	GOTO DIREITA_INT 
CONTAON
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0		
TESTEON
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTEON
	INCF CONTADOR
	MOVLW .10		; VERIFICANDO SE CONTOU 10 VEZES 50Us
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 10 VEZES, TEREMOS 500K us e
	GOTO DESLIGA
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO TESTEON
DESLIGA
	BCF GPIO, GP4     ; DESLIGANDO OS LEDS
	BCF GPIO, GP5
	CLRF CONTADOR
	GOTO CONTAOFF	   ; CONTA DESLIGADO
CONTAOFF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0		
TESTEOFF
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO TESTEOFF
	INCF CONTADOR
	MOVLW .10		; VERIFICANDO SE CONTOU 10 VEZES 50Us
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 10 VEZES, TEREMOS 500K us e
	GOTO ZERA
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO TESTEOFF
ZERA
	CLRF CONTADOR
	BTFSS GPIO, GP0
	CALL PRIORIDADE
	GOTO ALERTA_INT
	;CORPO DA ROTINA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000111'	;CONFIGUREI O GP2 e GP1 COMO ENTRADA E OS OUTROS SÃO SAÍDAS, COM exceção gp3 que não muda
	MOVWF	TRISIO		;COMO SAÍDAS
	CLRF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000111'	; 1:256
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'10011000'	;Liguei a chave geral e habilitei mudar quando gp2 mudar
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000111'	;criando interrupçao quando gp0 estiver em 1 e gp2 tb
	MOVWF	IOC		;DEFINE OPÇÕES DE INTERRUPÇÕES
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
	MOVFW OPCAO			    ;TESTANDO SE ALGUMA SETA OU ALARME FOI ATIVADA
	BTFSC STATUS, Z			    ; SE ESTIVER LIGADO VAI DESCOBRIR QUAL LED LIGAR BASEADO NA OPÇÃO SALVA NA INTERRUPÇÃO
	GOTO MAIN
	;ALERTA
	MOVLW .1		    
	SUBWF OPCAO, W			    ;SUBTRAINDO O WORK 0 PELO INTERRUPTOR QUE SE ESTIVER EM 0,O Z SERÁ IGUAL A 1
	BTFSC STATUS, Z			    ; Z IGUAL A 1? VALOR DA SUBTRAÇÃO DEU 0, LOGO N PULA SE Z FOSSE 0 PULARIA
	GOTO ALERTA_INT			    ; FLUXO CONTINUA E VAI PARA O LABEL COM INSTRUÇÕES A RESPEITO
	;DIREITA
	MOVLW .2
	SUBWF OPCAO, W			    ;SUBTRAINDO O WORK 0 PELO INTERRUPTOR QUE SE ESTIVER EM 1,O Z SERÁ IGUAL A 1
	BTFSC STATUS, Z			    ; Z IGUAL A 1? VALOR DA SUBTRAÇÃO DEU 0, LOGO N PULA SE Z FOSSE 0 PULARIA
	GOTO DIREITA_INT		    ; FLUXO CONTINUA E VAI PARA O LABEL COM INSTRUÇÕES A RESPEITO
	;ESQUERDA
	MOVLW .3
	SUBWF OPCAO, W			    ;SUBTRAINDO O WORK 0 PELO INTERRUPTOR QUE SE ESTIVER EM 2,O Z SERÁ IGUAL A 1
	BTFSC STATUS, Z			    ; Z IGUAL A 1? VALOR DA SUBTRAÇÃO DEU 0, LOGO N PULA SE Z FOSSE 0 PULARIA
	GOTO  ESQUERDA_INT		    ; FLUXO CONTINUA E VAI PARA O LABEL COM INSTRUÇÕES A RESPEITO

ESQUERDA_INT 
	BCF GPIO, GP5
	BSF GPIO, GP4     ; LIGANDO O LED
	CALL CONTAON
	
DIREITA_INT
	BCF GPIO, GP4	       ; DESLIGANDO OS LEDS  
	BSF GPIO, GP5	       ; LIGANDO O LED DIREITO
	CALL CONTAON
		 
ALERTA_INT
	BCF GPIO, GP4     ; DESLIGANDO OS LEDS
	BCF GPIO, GP5	  
	BSF GPIO, GP4     ; LIGANDO O LED ESQUERDO
	BSF GPIO, GP5	  ; LIGANDO O LED DIREITO
	CALL CONTAON

	





	
FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
