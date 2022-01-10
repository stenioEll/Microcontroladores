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

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_ON & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT   ; MCLRE OFF PARA MANTER TODOS OS LEDS APAGADOS INCLUSIVE O GP3

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
LIMPAWDT
	CLRWDT               ; LIMPANDO WDT
PISCALED0                   ;LABEL DE CONTROLE DO PISCA DO LED REFERENTE AO GP0, O QUAL DEVE PISCAR 4 VEZES E SE MANTER LIGADO POR 50 MS E DEPOIS DESLIGADO POR 50 MS
	BANK1
	MOVLW	B'00000000'	;CONFIGUREI O GP1 COMO saida para poder desligar todos os leds
	MOVWF	TRISIO		;COMO SAÍDAS
	;MOVLW	B'00000111'	; AJUSTEI O PRE-ESCALE PARA 1:256 E DESLIGUEI O BIT 3 INDICANDO QUE USAREI O TMR0
	;MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	BANK0
	CLRF GPIO               ;desligando todos os leds
LIGA50US
	BSF GPIO, GP0             ;LIGANDO LED
	MOVLW B'10101111'       ; MOVENDO OS PRIMEIROS 8 BITS DO RESULTADO DA SUBTRAÇÃO DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1L
	MOVLW B'00111100'       ; MOVENDO OS ULTIMOS 8 BITS DO RESULTADO DA SUBTRAÇÃO DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1H
	
	;CLRF TMR0		;ZERANDO O TMR0
	;MOVLW .61		; inicializando com o valor gerado da diferença de 256 - 195 = 61 para provocar o estouro com 50us
	;MOVWF TMR0
	GOTO CONTALIGADO
CONTALIGADO
	BTFSS PIR1, TMR1IF	; estourou? Sim! CONTA DESLIGADO
	GOTO CONTALIGADO
	GOTO DESLIGA50US
DESLIGA50US
	BCF GPIO, GP0             ;DESLIGANDO LED
	MOVLW B'10101111'       ; MOVENDO OS PRIMEIROS 8 BITS DO RESULTADO DA SUBTRAÇÃO DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1L
	MOVLW B'00111100'       ; MOVENDO OS ULTIMOS 8 BITS DO RESULTADO DA SUBTRAÇÃO DO MAXIMO TO TMR1 - 50MS
	MOVWF TMR1H
	GOTO CONTADESLIGADO
CONTADESLIGADO
	BTFSS PIR1, TMR1IF	; estourou? Sim! vai incrementar a variavel
	GOTO CONTADESLIGADO
	INCF CONTADOR           ;PISCOU, incrementa a variável para controlar a contagem
	MOVLW .4		; VERIFICANDO SE CONTOU 4 VEZES 50Us A TAREFA ACABOU
	SUBWF CONTADOR, W
	BTFSC STATUS, C		; SE TIVER CONTADO 50K 2000 VEZES, TEREMOS 10M us e
	GOTO CONFIGURA
	GOTO DESLIGA50US
CONFIGURA                      ;VOLTANDO AS CONFIGURAÇÕES ANTERIORES E SAINDO DA INTERRUPÇÃO
	BANK1
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA para poder gerar a interrupção,  e os demais saida, sabendo que gp0 corresponde ao led que deve ser aceso POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS SÃO SAÍDAS, COM exceção gp3 que não muda
	MOVWF	TRISIO		;COMO SAÍDAS
	;MOVLW	B'00001101'	; AJUSTEI O PRE-ESCALE PARA 1:32 E SETEI O BIT 3 INDICANDO QUE É REFERENTE AO WATCHDOG
	;MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	BANK0
	BCF INTCON, GPIF
	
	



	
	

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
	MOVLW	B'00000010'	;CONFIGUREI O GP1 COMO ENTRADA para poder gerar a interrupção,  e os demais saida, sabendo que gp0 corresponde ao led que deve ser aceso POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS SÃO SAÍDAS, COM exceção gp3 que não muda
	MOVWF	TRISIO		;
	CLRF ANSEL
	MOVLW	B'00001101'	; AJUSTEI O PRE-ESCALE PARA 1:32 E SETEI O BIT 3 INDICANDO QUE É REFERENTE AO WATCHDOG
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'10001000'	;ATIVANDO INTERRUPÇÃO POR PORTA 
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000010'	;INTERRUPÇÃO PELA A MUDANÇA DE PORTA DO GP1 ATIVADA
	MOVWF	IOC		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW   B'00000000'	;NÃO UTILIZAREI
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000001'     ;USANDO PRESCALE 1:1 PARA CONTAR 50 MS E HABILITEI O 
	MOVWF	T1CON 
	MOVLW	B'00000000'     ;DESLIGANDO O REGISTRADOR DE CONVERSAO
	MOVWF	ADCON0 
	MOVLW	B'00000111'	; DESLIGANDO O CMCON REGISTRADOR DE COMPARAÇÃO
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
DORME   ;Label que fará o microcontrolador dormir
	CLRF GPIO
	SLEEP		    ; O MICRO ACORDARÁ QUANDO WDT ESTOURAR, COM O PRE-SCALE DE 32, PRÓXIMO A 550 MS, RESPEITANDO A MARGEM DE ERRO
	NOP
AGUARDAINSTRUCAO            ;logo para executar qualquer tarefa enquanto o micro esta acordado, mude o gp1 de estado
	GOTO AGUARDAINSTRUCAO
	GOTO DORME
	
	
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     CONSUMO DE ENERGIA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;MODO SLEEP
	
;A CORRENTE DO WATCHDOG PARA TENSÃO DE 5V É DE 17UA, ELE SERÁ UTILIZADO POR 2,2SEGUNDOS, APÓS ISSO É LIMPO
;Convertendo 2,2 segundos para horas temos 0,000611111 que é aproximadamente 611 uH
;Multiplicando pelo valor da corrente de WDT teremos 17UA * 611Uh = 0,010378uH
;O consumo do watchdog é de 0,010378uWh

;MODO ACORDADO
; A CORRENTE PARA ACENDER UM LED É DE 1UA para 5V no pior caso o programa roda em 60us
; Transformando 60us em horas temos 0,016667 uH 
; Multiplicando pela a corrente teremos  0,016667uWh pois a corrente é 1uA, esse é o consumo no pior caso

; ECONOMIA
; Enquanto o microcontrolador dorme o consumo de energia por 2,2 segundos é equivalente a 0,010378 uWh logo 
; Fazendo o consumo quando o microcontrolador está ligado - está desligado teremos =  0,016667uWh - 0,010378 uWh
; Portanto economiza-se 0,006289uWh, pois com o sleep o funcionamento do gpio estará desligado 


FIM
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
