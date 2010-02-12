PIADDA  EQU     $600001       ; Datariktningsregistret PORT A
PIADA   EQU     $600001       ; Dataregistret PORT A
PIACA   EQU     $600003       ; Kontrollregistret PORT A
PIADDB  EQU     $600005       ; Datariktningsregistret PORT B
PIADB   EQU     $600005       ; Dataregistret PORT B
PIACB   EQU     $600007       ; Kontrollregistret PORT B
DELAYMS EQU  	2222          ;ger 10   ms

LEDS	EQU	PIADB
TENMS	EQU	2222		;~10 ms
DELAY2	EQU	2222


PROGRAM	EQU 	$403000
DATA	EQU	$405000

	ORG 	DATA
KBOUT  	DS.B    2
KEYTAB	DC.B    %01010111             ; 0
	DC.B    %01101110             ; 1
	DC.B    %01011110             ; 2
	DC.B    %00111110             ; 3
	DC.B    %01101101             ; 4
    	DC.B    %01011101             ; 5
	DC.B    %00111101             ; 6
	DC.B    %01101011             ; 7
	DC.B    %01011011             ; 8
	DC.B    %00111011             ; 9
	DC.B    %01100111             ; *
	DC.B    %00110111             ; #
	DC.B    -1

	ORG	PROGRAM

	BRA	INITPIA

BLINK	MOVE.B	#11,LEDS		;Tänd
	MOVE.L	#TENMS,D7
	BRA	WAIT1

	MOVE.B	#00,LEDS		;Släck
	MOVE.L	#TENMS,D7
	BRA	WAIT1
	
	BRA	BLINK
AGAIN	BRA	AGAIN

**************************************************************
**************************************************************
**************************************************************

READKEY MOVEM.L D5-D7/A0,-(A7)
	MOVE.B  #255,KBOUT
 	MOVE.L  #DELAYMS,D7     	;vänta på avstudsning
 	BSR     DELAY
	MOVE.B  PIADA,D6        	;Avläs kol
	ANDI.B  #%01110000,D6
 	CMPI.B  #%01110000,D6
	BEQ.B   NOKEY

*	MOVE.L  #DELAYMS,D7     	;vänta ytterligare en stund
* 	BSR   DELAY
* 	MOVE.B  PIADA,D7        	;Avläs kol igen
* 	ANDI.B  #%01110000,D7
*   	CMP.B   D7,D6           	;Lika avläsningar?
*  	BNE.B   NOKEY

   	MOVE.B  #%01110000,D7   	;Kol ut rader in
   	BSR   INITKEY
   	MOVE.B  #%10001111,PIADA
   	MOVE.B  PIADA,D7           	;Avläs rader
   	ANDI.B  #%00001111,D7
   	OR.B    D6,D7                   ;Slå ihop avläsningar

   	MOVEA.L #KEYTAB,A0    		;Slå i tabell
   	MOVEQ   #0,D6
TABLOOP MOVE.B  0(A0,D6.W),D5
	BMI.B   MATCH                   ;Slut på tabell
	CMP.B   D5,D7
	BEQ.B   MATCH
	ADDQ.B  #1,D6
	BRA.B   TABLOOP

MATCH  	MOVE.B  D6,KBOUT
      	MOVE.B  #%00001111,D7     	;Återställ kol in rader ut
	BSR.B   INITKEY
	MOVE.B  #%11110000,PIADA

RELEASE MOVE.B  PIADA,D7        	;Tangent uppsläppt?
	ANDI.B  #$70,D7
	CMPI.B  #$70,D7
	BNE.B   RELEASE
	MOVE.L  #DELAYMS,D7     	;Vänta på studs
	BSR     DELAY

NOKEY  	TST.B   PIADA                       ;Nollställ CA1
       	MOVEM.L (A7)+,D5-D7/A0
       	RTS

DELAY  	SUBQ.L  #1,D7
       	BNE.B   DELAY
       	RTS

INITKEY MOVE.B  #0,PIACA
       	MOVE.B  D7,PIADDA
       	MOVE.B  #$36,PIACA           ;#$37 då avbrott används
       	RTS
**************************************************************
**************************************************************
**************************************************************

WAIT1  	SUBQ.L  #1,D7
       	BNE.B   WAIT1
       	RTS

INITPIA MOVE.B  #0,PIACA
        MOVE.B  #$0F,PIADDA
        MOVE.B  #7,PIACA
        MOVE.B  #0,PIACB
        MOVE.B  #$FF,PIADDB
        MOVE.B  #4,PIACB
        MOVE.B  #0,PIADA
        MOVE.W  #HALFSEC,MINNE
    	MOVE.L	#INT,AVEC5
	MOVE.W	#$2000,SR
        RTS