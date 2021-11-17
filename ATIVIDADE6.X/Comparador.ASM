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
		VALORDIGITAL
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
;CONDICAO1
;	BSF GPIO, GP2		; SE a temperatura é maior que a tmax, liga o compressor
;	;Configurando para Tmin
;	BANK1
;	MOVLW   B'10000111'	;Ajustando a tensão de referência para o low(vrr), escala do valor 7 referente a config do tmin
;	MOVWF	VRCON
;	BANK0
;	GOTO C3
;CONDICAO2
;	BCF GPIO, GP2		; SE a temperatura é menor que a tmIN, desliga o compressor
;	;Configurando para Tmax
;	BANK1
;	MOVLW   B'10001010'	;Ajustando a tensão de referência para o high(vrr), escala do valor 10 referente a config do tmax
;	MOVWF	VRCON
;	BANK0
;	GOTO C1

 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA, POIS RECEB O SINAL DE TEMPERATURA, COM exceção gp3 que não muda
	MOVWF	TRISIO		;COMO SAÍDAS
	MOVLW	B'00000010'	;divisor de clock configurado para dividir por 8 e an3 configurado como entrada analógico
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000101'	; 1:64
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'00000000'	;lIGUEI A INTERRUPÇÃO PARA O ESTOURO 
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000000'	;N utilizarei interrupção 
	MOVWF	IOC		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW   B'10001010'	;Ajustando a tensão de referência para o high, escala do valor 10 referente a config do tmax
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000101'     ;habilitei o conversor e selecionei o canal analógico 1 referente ao gp1
	MOVWF	ADCON0 
	MOVLW	B'00000100'	; Configurando o comparador como 100, pois é o modelo que se aplica a atividade
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C1
	BTFSC CMCON, 6          ; COMPARANDO TENSÃO REFERANCIAL COM A ENTRADA, SE A ENTRADA FOR MAIOR, OUTPUT = 0, SE NÃO OUTPUT = 1
	GOTO C1
	BSF GPIO, GP2		; SE a temperatura é maior que a tmax, liga o compressor
	;Configurando para Tmin
	BANK1
	MOVLW   B'10100111'	;Ajustando a tensão de referência para o low(vrr), escala do valor 7 referente a config do tmin
	MOVWF	VRCON
	BANK0
C2
	BTFSS CMCON, 6
	GOTO C2
	BCF GPIO, GP2
	;Configurando para Tmin
	BANK1
	MOVLW   B'10001010'	;Ajustando a tensão de referência para o high(vrr), escala do valor 10 referente a config do tmax
	MOVWF	VRCON
	BANK0
	GOTO C1
	
	;BSF GPIO, GP2		; SE a temperatura é maior que a tmax, liga o compressor
	;Configurando para Tmin
	;MOVLW   B'10000111'	;Ajustando a tensão de referência para o low(vrr), escala do valor 7 referente a config do tmin
	;MOVWF	VRCON
	;GOTO MAIN
;2
	;BTFSS CMCON, 6
	;GOTO C2
	;CALL CONDICAO2
	;BSF GPIO, GP2		; SE a temperatura é menor que a tmIN, desliga o compressor
	;Configurando para Tmax
	;MOVLW   B'10001010'	;Ajustando a tensão de referência para o high(vrr), escala do valor 10 referente a config do tmax
	;MOVWF	VRCON
	;GOTO CONDICAO2
;C3
	;GOTO FIM

	
	




FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
