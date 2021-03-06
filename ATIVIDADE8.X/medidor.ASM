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

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_ON & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

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
		VALORDIGITAL
		TENSAO_4V
		TENSAO_3V
		TENSAO_2V
		CORRENTE_WDT
		
	
	
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
TRATA_SINALC1 ;CASO 1, TENS�O MENOR QUE 2V
	MOVFW TENSAO_2V			    ; MOVENDO O LIMITE DE 2V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA 
	SUBWF VALORDIGITAL, W		    ; Querendo saber se foi � menor que 2V
	BTFSC STATUS, C			    ; Se o bit c for 0, o numero � menor que o valor referente ao sinal digital de 2V convertido
	GOTO TRATA_SINALC4                  ; Se pular para esse label j� podemos afirmar que a tens�o � maior que 2V       
	GOTO LIGA1
TRATA_SINALC4 ;CASO 4, TENS�O MAIOR QUE 4V
	MOVFW TENSAO_4V			   ; MOVENDO O LIMITE DE 4V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se � MAIOR que 4V
	BTFSS STATUS, C			    ; Se o bit c for 1, o numero � maior que o valor referente ao sinal digital de 4V convertido
	GOTO TRATA_SINALC3                  ; Se pular para esse podemos afirmar que a tens�o � menor que 4V e maior que 2V                        
	GOTO LIGA5
TRATA_SINALC3 ;CASO 3, TENS�O MAIOR QUE 3V E MENOR QUE 4V
	MOVFW TENSAO_3V			   ; MOVENDO O LIMITE DE 3V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se � MAIOR que 3V
	BTFSS STATUS, C			    ; Se o bit c for 1, o numero � maior que o valor referente ao sinal digital de 3V convertido
	GOTO LIGA2                          ; Se pular para esse podemos afirmar que a tens�o � menor que 4V e maior que 2V e menor que 3V                       
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
	MOVLW	B'00000001'	;CONFIGUREI O GP0 COMO ENTRADA POIS FOI DEMANDADO PELA ATIVIDADE E OS OUTROS S�O SA�DAS, COM exce��o gp3 que n�o muda
	MOVWF	TRISIO		;COMO SA�DAS
	MOVLW	B'00010001'	;ANSEL CONFIGURADO COMO ENTRADA ANAL�GICA REFERENTE A GP0 e divis�o 8
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00001111'	; AJUSTEI O PRE-ESCALE PARA 1:128 E SETEI O BIT 3 INDICANDO QUE � REFERENTE AO WATCHDOG
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'	;N�O PRECISA CONFIGURAR PARA USAR A FLAG DO ESTOURO
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW	B'00000000'	;N utilizarei interrup��o 
	MOVWF	IOC		;DEFINE OP��ES DE INTERRUP��ES
	MOVLW   B'00000000'	;N�O UTILIZAREI
	MOVWF	VRCON
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000001'     ;HABILITEI E CONVERSOR E e selecionei o canal anal�gico 0 referente ao gp0
	MOVWF	ADCON0 
	MOVLW	B'00000000'	; 
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
VARIAVEIS ;Nessa label s�o armazenados os valores de sinais convertidos referentes a cada tens�o 
	MOVLW .204
	MOVWF TENSAO_4V
	MOVLW .153
	MOVWF TENSAO_3V
	MOVLW .102
	MOVWF TENSAO_2V	
DORME   ;Label que far� o microcontrolador dormir
	SLEEP		    ; O MICRO ACORDAR� QUANDO WDT ESTOURAR, COM O PRE-SCALE DE 128
	NOP
	CLRWDT
	BSF ADCON0, 1         ; INICIANDO A CONVERS�O
CONVERSOR
	BTFSC ADCON0, 1                     ;Testo o mesmo bit go/done se foi para 0, pois indicar� para mim se a convers�o foi finalizada 
	GOTO CONVERSOR                      ; Fica no loop enquanton�o tiver terminado a convers�o
	MOVFW ADRESH                        ; Movendo o valor da convers�o que estar� contido no adresh, pois configurei o registrador ADCON0 com a justificativa pela esquerda 
	MOVWF VALORDIGITAL                  ; Salvando esse sinal anal�gico convertido para digital em uma vari�vel para tratar futuramente
FORAINTERVALO1                              ; Label para caso o est�mulo n�o se encaixe em nenhum dos intervalos, se satisfazer as instru��es abaixo, significa que pode ser analizado
	MOVFW TENSAO_2V			    ; MOVENDO O LIMITE DE 2V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA 
	SUBWF VALORDIGITAL, W		    ; Querendo saber se foi � menor que 2V
	BTFSC STATUS, Z			    ; Se o bit z for 1, o numero � igual ao o valor referente ao sinal digital de 2V convertido
	GOTO FIM                            ; Se pular para esse label j� podemos afirmar que a tens�o � IGUAL a 2V, logo n�o se encaixa em nenhuma restri��o da tabela       
	MOVFW TENSAO_3V			    ; MOVENDO O LIMITE DE 3V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se � IGUAL que 3V
	BTFSC STATUS, Z			    ; Se o bit z for 1, o numero � igual ao o valor referente ao sinal digital de 3V convertido
	GOTO FIM                            ; Se pular para esse label j� podemos afirmar que a tens�o � IGUAL a 3V, logo n�o se encaixa em nenhuma restri��o da tabela                       
	MOVFW TENSAO_4V			   ; MOVENDO O LIMITE DE 4V PARA O WORK PARA COMPARAR COM O VALOR CONVERTIDO E VERIFICAR A RESTRI��O DA TABELA  
	SUBWF VALORDIGITAL, W		    ; Querendo saber se � IGUAL que 4V
	BTFSC STATUS, C			    ; Se o bit z for 1, o numero � igual ao o valor referente ao sinal digital de 3V convertido
	GOTO FIM                            ; Se pular para esse podemos afirmar que a tens�o � IGUAL a 4V                         
	CALL TRATA_SINALC1

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
