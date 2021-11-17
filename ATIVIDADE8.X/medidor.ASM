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

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_ON & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

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
		VALORDIGITAL
		TENSAO_4V
		TENSAO_3V
		TENSAO_2V
		CORRENTE_WDT
		
	
	
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
TRATA_SINALC1 ;CASO 1, TENSÃO MENOR QUE 2V
	MOVFW TENSAO_2V			    ; MOVENDO O LIMITE DE 2V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA 
	SUBWF VALORDIGITAL, W		    ; Querendo saber se foi é menor que 2V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero é menor que o valor referente ao sinal digital de 2V convertido
	GOTO TRATA_SINALC4                  ; Se pular para esse label já podemos afirmar que a tensão é maior que 2V       
	GOTO LIGA1
TRATA_SINALC4 ;CASO 4, TENSÃO MAIOR QUE 4V
	MOVFW TENSAO_4V			   ; MOVENDO O LIMITE DE 4V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se é MAIOR que 4V
	BTFSS STATUS, C			    ; Se o bit c for 1, o numero é maior que o valor referente ao sinal digital de 4V convertido
	GOTO TRATA_SINALC3                  ; Se pular para esse podemos afirmar que a tensão é menor que 4V e maior que 2V                        
	GOTO LIGA5
TRATA_SINALC3 ;CASO 3, TENSÃO MAIOR QUE 3V E MENOR QUE 4V
	MOVFW TENSAO_3V			   ; MOVENDO O LIMITE DE 3V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se é MAIOR que 3V
	BTFSS STATUS, C			    ; Se o bit c for 1, o numero é maior que o valor referente ao sinal digital de 3V convertido
	GOTO LIGA2                          ; Se pular para esse podemos afirmar que a tensão é menor que 4V e maior que 2V e menor que 3V                       
	GOTO LIGA4

	
	
LIGA1
	CLRF GPIO
	BSF GPIO, GP1
	GOTO DORME
LIGA2	
	CLRF GPIO
	BSF GPIO, GP2
	GOTO DORME
LIGA4
	CLRF GPIO
	BSF GPIO, GP4
	GOTO DORME
LIGA5
	CLRF GPIO
	BSF GPIO, GP5
	GOTO DORME


 

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000001'	;CONFIGUREI O GP0 COMO ENTRADA POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS SÃO SAÍDAS, COM exceção gp3 que não muda
	MOVWF	TRISIO		;COMO SAÍDAS
	MOVLW	B'00010001'	;ANSEL CONFIGURADO COMO ENTRADA ANALÓGICA REFERENTE A GP0 e divisão 8
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00001111'	; AJUSTEI O PRE-ESCALE PARA 1:128 E SETEI O BIT 3 INDICANDO QUE É REFERENTE AO WATCHDOG
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'00000000'	;NÃO PRECISA CONFIGURAR PARA USAR A FLAG DO ESTOURO
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW	B'00000000'	;N utilizarei interrupção 
	MOVWF	IOC		;DEFINE OPÇÕES DE INTERRUPÇÕES
	MOVLW   B'00000000'	;NÃO UTILIZAREI
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000001'     ;HABILITEI E CONVERSOR E e selecionei o canal analógico 0 referente ao gp0
	MOVWF	ADCON0 
	MOVLW	B'00000000'	; 
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
VARIAVEIS ;Nessa label são armazenados os valores de sinais convertidos referentes a cada tensão 
	MOVLW .204
	MOVWF TENSAO_4V
	MOVLW .153
	MOVWF TENSAO_3V
	MOVLW .102
	MOVWF TENSAO_2V	
DORME   ;Label que fará o microcontrolador dormir
	SLEEP		    ; O MICRO ACORDARÁ QUANDO WDT ESTOURAR, COM O PRE-SCALE DE 128
	NOP
	CLRWDT
	BSF ADCON0, 1         ; INICIANDO A CONVERSÃO
CONVERSOR
	BTFSC ADCON0, 1                     ;Testo o mesmo bit go/done se foi para 0, pois indicará para mim se a conversão foi finalizada 
	GOTO CONVERSOR                      ; Fica no loop enquantonão tiver terminado a conversão
	MOVFW ADRESH                        ; Movendo o valor da conversão que estará contido no adresh, pois configurei o registrador ADCON0 com a justificativa pela esquerda 
	MOVWF VALORDIGITAL                  ; Salvando esse sinal analógico convertido para digital em uma variável para tratar futuramente
FORAINTERVALO1                              ; Label para caso o estímulo não se encaixe em nenhum dos intervalos, se satisfazer as instruções abaixo, significa que pode ser analizado
	MOVFW TENSAO_2V			    ; MOVENDO O LIMITE DE 2V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA 
	SUBWF VALORDIGITAL, W		    ; Querendo saber se foi é menor que 2V
	BTFSC STATUS, Z			    ; Se o bit z for 1, o numero é igual ao o valor referente ao sinal digital de 2V convertido
	GOTO FIM                            ; Se pular para esse label já podemos afirmar que a tensão é IGUAL a 2V, logo não se encaixa em nenhuma restrição da tabela       
	MOVFW TENSAO_3V			    ; MOVENDO O LIMITE DE 3V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se é IGUAL que 3V
	BTFSC STATUS, Z			    ; Se o bit z for 1, o numero é igual ao o valor referente ao sinal digital de 3V convertido
	GOTO FIM                            ; Se pular para esse label já podemos afirmar que a tensão é IGUAL a 3V, logo não se encaixa em nenhuma restrição da tabela                       
	MOVFW TENSAO_4V			   ; MOVENDO O LIMITE DE 4V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRIÇÃO DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se é IGUAL que 4V
	BTFSC STATUS, C			    ; Se o bit z for 1, o numero é igual ao o valor referente ao sinal digital de 3V convertido
	GOTO FIM                            ; Se pular para esse podemos afirmar que a tensão é IGUAL a 4V                         
	CALL TRATA_SINALC1

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
