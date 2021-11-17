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
	; VERIFICANDO A POSIÇÃO DA INTERRUPÇAÕ


	

	



	
	

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



	;CORPO DA ROTINA


 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000111'	;CONFIGUREI O GP0 E GP2 COMO ENTRADA SENDO OS SENSORES E GP1 COMO ENTRADA Q RECEBRÁ O SINAL ANALÓGICO REFERENTE AO SENSOR DE TEMP, E OS MOTORES SAIDA, COM exceção gp3 que não muda
	MOVWF	TRISIO		;COMO SAÍDAS
	MOVLW	B'00000010'	;ANSEL CONFIGURADO COMO ENTRADA ANALÓGICA REFERENTE A GP1
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000111'	; AJUSTEI O PRE-ESCALE PARA 1:256
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'10000000'	;CHAVE GERAL LIGADA
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000000'	;N utilizarei interrupção 
	MOVWF	IOC		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW   B'10001010'	;Ajustando a tensão de referência para o high, escala do valor 9 referente a config do tmax de 2,6V
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000000'     ;NÃO UTILIZAREI CONVERSOR
	MOVWF	ADCON0 
	MOVLW	B'00000100'	; Configurando o comparador como 100, pois é o modelo que se aplica a prova
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
LABEL1
	BTFSC GPIO, GP0         ; SENSOR1 TÁ EM 0? SE SIM DESLIGA O MOTOR1, SE NAO LIGA O MOTOR1
	GOTO LIGAMOTOR1
	GOTO DESLIGAMOTOR1

DESLIGAMOTOR1
	BCF GPIO, GP4          ;DESLIGA O MOTOR 1
	GOTO LABEL2
LIGAMOTOR1
	BSF GPIO, GP4           ; LIGA MOTOR1
	GOTO LABEL2
LABEL2
	BTFSC GPIO, GP2         ; SENSOR2 TÁ EM 0? SE SIM DESLIGA O MOTOR2, SE NAO LIGA O MOTOR2
	GOTO LIGAMOTOR2
	GOTO DESLIGAMOTOR2
DESLIGAMOTOR2
	BCF GPIO, GP5          ;DESLIGA O MOTOR 2
	GOTO LABEL3
LIGAMOTOR2
	BSF GPIO, GP5           ; LIGA MOTOR 2
	GOTO LABEL3
LABEL3 
	BTFSS CMCON, 6          ; VERIFICANDO SE A TEMPERATURA É MAIOR DO QUE A TEMPERATURA MÁXIMA
	GOTO DESLIGATUDO
	GOTO LABEL1
DESLIGATUDO
	BCF GPIO, GP4           ; DESLIGA TODOS OS MOTORES
	BCF GPIO, GP5
	GOTO DELAY
DELAY
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estouro com 50us
	MOVWF TMR0		
CONTA
	BTFSS INTCON, T0IF	; estourou? Sim! vai incrementar a variavel
	GOTO CONTA
	INCF CONTADOR
	MOVLW .200		; VERIFICANDO SE CONTOU 200 VEZES 50Us TEREI OS 10 MILHÕES US Q EQUIVALE A 10 SEGUNDOS
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 2000 VEZES, TEREMOS 10M us e
	GOTO LABEL1
	BCF INTCON, T0IF
	CLRF TMR0		;ZERANDO O TMR0
	MOVLW .61		; inicializando com o valor gerado da diferenã de 256 - 195 = 61 para provocar o estou com 50us
	MOVWF TMR0
	GOTO CONTA
	
	
	




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
