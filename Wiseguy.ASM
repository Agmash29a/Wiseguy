;*************************************************************
;TITLE	 : 
;AUTHOR	 : cHiLlErS of EntropY
;WATCHDOG: Off
;CLOCK	 : 4 MHz (instruction speed is OSC/4 = 1 MHz = 1us)
;PIC	 : 16C74A
;*************************************************************
;FUNCTION:
;*************************************************************
LIST    p=16C74A ; PIC16C74A is the target processor
;*************************************************************



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*- BANK 0 - Registers *-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*



;		****************************
;		*     Standard registers   *
;		****************************


		INDF		equ	h'00'
		TMR0		equ	h'01'
		PCL 		equ	h'02'
		STATUS		equ	h'03'
		FSR		equ	h'04'
		PORTA		equ	h'05'
		PORTB		equ	h'06'
		PORTC		equ	h'07'
		PORTD		equ	h'08'
		PORTE		equ	h'09'
		PCLATH		equ	h'0A'
		INTCON		equ	h'0B'
		PIR1		equ	h'0C'
		PIR2		equ	h'0D'
		TMR1L		equ	h'0E'
		TMR1H		equ	h'0F'
		T1CON		equ	h'10'
		TMR2		equ	h'11'
		T2CON		equ	h'12'
		SSPBUF		equ	h'13'
		SSPCON		equ	h'14'
		CCPR1L		equ	h'15'
		CCPR1H		equ	h'16'
		CCP1CON		equ	h'17'
		RCSTA		equ	h'18'
		TXREG		equ	h'19'
		RCREG		equ	h'1A'
		CCPR2L		equ	h'1B'
		CCPR2H		equ	h'1C'
		CCP2CON		equ	h'1D'
		ADRES		equ	h'1E'
		ADCON0		equ	h'1F'



;****************************
;*   Storage for the time   *
;****************************

TIME_10HRS		equ	h'20';Incremented every 10 hours
TIME_HRS		equ	h'21';Incremented every hour
TIME_10MINS		equ	h'22';Incremented every 10 minutes
TIME_MINS		equ	h'23';Incremented every minute
TIME_10SECS		equ	h'24';Incremented every 10 seconds
TIME_SECS		equ	h'25';Incremented every second
HALFSECONDS		equ	h'26';updated every 1/2 a sec.



;****************************
;*  Temporary time storage  *
;*  ----------------------  *
;* Used for storing times   *
;* during display and edit- *
;* ing pages (values may    *
;* only be changed between  *
;* pages - otherwise use    *
;* the TEMP_XXX registers)  *
;****************************

HRS10			equ	h'27';Storage for 10 hours
HRS			equ	h'28';Storage for hours	
MINS100			equ	h'29';Storage for 100 minutes	
MINS10			equ	h'2A';Storage for 10 minutes	
MINS			equ	h'2B';Storage for minutes
SECS10			equ	h'2C';Storage for 10 seconds
SECS			equ	h'2D';Storage for seconds

TEMPHRS10		equ	h'2E';temporary storage for the above	
TEMPHRS			equ	h'2F';
TEMPMINS100		equ     h'30';
TEMPMINS10		equ	h'31';	
TEMPMINS		equ	h'32';
TEMPSECS10		equ	h'33';
TEMPSECS		equ	h'34';



;****************************
;*    Control registers     *
;*    -----------------     *
;* These registers contain  *
;* various control bits.    *
;****************************

;*-----------*
;* CONTROL 1 *
;*-----------*

CONTROL1		equ	h'35';

;Various bits for CONTROL 1
;--------------------------

					;bit 0 = seconds (1) , no seconds (0)
BUTTDELAYFLAG		equ	h'01'	;bit 1 = BUTTDELAYFLAG	0 = delay has finished
OKFLAG			equ	h'02'	;bit 2 = OKflag
					;bit 3 = cursor has changed position flag/increment 
					;	 has occured
ACRFLAG			equ	h'04'	;bit 4 = ACRflag
UPFLAG			equ	h'05'	;bit 5 = UPlag
PAGEBIT			equ	h'06'	;bit 6 = PAGEBIT, set if times have 
					;	 been written to temp time registers
UPDATE			equ	h'07'	;bit 7 = UPDATE , set if ok has been pressed

;*-----------*
;* CONTROL 2 *
;*-----------*

CONTROL2		equ	h'36';

;Various bits for CONTROL 1
;--------------------------

PUMP_ON_BIT		equ	h'00'	;bit 0 = PUMP control bit (1) mins, 
					;	 min = 5, mins10, min = 1
DECREMENT_UPDATE 	equ	h'01'	;bit 1 = set to 0 if the decrementing process has
					;	 reached 000 in the Decrement subroutine 
					;	 (DECREMENTMINS) 
GR		 	equ	h'02'	;bit 2 = set if the xxxGRE registers are greater than the 
					;	 temporary time registers in the GreEqu 
					;	 subroutine (GREATERHRS10)
EQ		 	equ	h'03'	;bit 3 = set if the xxxGRE registers are equal to the 
					;	 temporary time registers in the GreEqu 
					;	 subroutine (GREATERHRS10)
TURNON			equ	h'04'	;bit 4 = turn on the particular device! 
MINUTEFLAG		equ	h'05'	;bit 5 = set if the minutes have just been updated
CHANGEFLAG		equ	h'06'	;bit 6 = change if the value (pump.. etc.) 
					; 	 has changed (1)=change
LIGHTFLAG		equ	h'07'	;bit 7 = flag is set once light is turned on
					;	 to let CO2_Stage set to fan and then
					;	 continue on (set to 0 when light is off)


;****************************
;*      LCD registers       *
;****************************

LCD_DATA		equ	PORTB	;Data line for the LCD - PORTB
LCD_CTRL		equ	PORTC	;Control line for the LCD - PORTC
LCD_TEMP		equ	h'37'	;Temporary storage for the LCD

;Various bits for LCD_CTRL
;-------------------------

LCD_E			equ	h'02'
LCD_RW			equ	h'01'
LCD_RS			equ	h'00'



;****************************
;*     	 Page Number        *
;****************************
	
PAGENUM			equ	h'38';	The current page number



;****************************
;*     xxxGRE registers     *
;*     ----------------     *
;* if the xxxGRE registers  *
;* are equal/greater to the *
;* temporary time registers *
;* in the GreEqu subroutine *
;* (GREATERHRS10) then the  *
;* GR/EQ bits are set in    *
;* CONTROL 2.		    *	
;****************************

MINSGRE			equ	h'39'	;storage mins - hrs10 for comparison 
MINS10GRE		equ	h'3A'
HRSGRE			equ	h'3B'
HRS10GRE		equ	h'3C'



;****************************
;*       Button Port        *
;*       -----------        *
;* Port where the buttons   *
;* are read in.		    *
;****************************

BUTTONPORT		equ	PORTC	;PORTC

;Various bit addresses for buttons in the Button Port (PortC)
;------------------------------------------------------------

ACRBUTTON		equ	h'03'
UPBUTTON		equ	h'04'
OK			equ	h'05'



;****************************
;*  Light Timer registers   *
;*  ---------------------   *
;* Values for when the 	    *
;* lights are turned on/off *
;****************************

LIGHT1_ON_10HRS		equ	h'3D';
LIGHT1_ON_HRS		equ	h'3E';
LIGHT1_ON_10MINS	equ	h'3F';
LIGHT1_ON_MINS		equ	h'40';

LIGHT1_OFF_10HRS	equ	h'41';
LIGHT1_OFF_HRS		equ	h'42';
LIGHT1_OFF_10MINS	equ	h'43';
LIGHT1_OFF_MINS		equ	h'44';

TIMER_ON_10HRS		equ	h'45';
TIMER_ON_HRS		equ	h'46';
TIMER_ON_10MINS	equ	h'47';
TIMER_ON_MINS		equ	h'48';

TIMER_OFF_10HRS	equ	h'49';
TIMER_OFF_HRS		equ	h'4A';
TIMER_OFF_10MINS	equ	h'4B';
TIMER_OFF_MINS		equ	h'4C';



;****************************
;*   Pump Timer registers   *
;*   --------------------   *
;* Values for when the pump *
;* is turned on/off.	    *
;****************************

PUMP_ON_100MINS		equ	h'4D';
PUMP_ON_10MINS		equ	h'4E';
PUMP_ON_MINS		equ	h'4F';

PUMP_OFF_100MINS	equ	h'50';
PUMP_OFF_10MINS		equ	h'51';
PUMP_OFF_MINS		equ	h'52';

PUMP_PORT		equ	PORTA;

;*** Pump bit

PUMP_BIT		equ	h'0';



;****************************
;*  Temp regs. for Timer1   *
;*  ---------------------   *
;* Values are stored in     *
;* these registers for use  *
;* in the Timer1 subroutine *
;* (TIMER1TEST1)            *
;****************************

OFFTIME_HRS10		equ	h'53';
OFFTIME_MINS10		equ	h'54';	
OFFTIME_MINS		equ	h'55';	
OFFTIME_HRS		equ	h'56';

ONTIME_HRS10		equ	h'57';
ONTIME_MINS10		equ	h'58';	
ONTIME_MINS		equ	h'59';	
ONTIME_HRS		equ	h'5A';



;****************************
;*  	Temp regs. for      *
;*  incrementing the time   *
;*  ---------------------   *
;* Used as temporary regs   *
;* for storing values for   *
;* incrementing var. times. *
;****************************

IHRS10			equ	h'5B';	
IHRS			equ	h'5C';
IMINS10			equ	h'5D';	
IMINS			equ	h'5E';
ISECS10			equ	h'5F';
ISECS			equ	h'60';



;****************************
;*    CURSOR registers	    *
;****************************

CURSORSTART		equ	h'61';start pos of cursor
CURSORPOSITION  	equ	h'62';Where the cursor is currently
NO_CURSOR_POSITIONS	equ	h'63';The number of cursor positions



;****************************
;*  	   DIVISOR          *
;*         -------          *
;* Used in routines when    *
;* inequalities must be     *
;* solved (x<y) etc.        *
;* i.e. INCREMENT. etc.     *
;****************************
 
DIVISOR			equ	h'64';



;****************************
;*     TEMP01 and TEMP02    *
;*     -----------------    *
;* When writing to the LCD  * 
;* the number of letters    *	
;* the print (-1) should be *
;* in TEMP01 the address of *
;* the LAST letter should   *
;* be in TEMP02		    *
;****************************

TEMP01			equ	h'65';	
TEMP02			equ	h'66';	



;****************************
;*     DELAY & X_DELAY      *
;*     ---------------      *
;* Used for storing values  *
;* for the time delays in   *
;* DELAY500 & DELAY500      *
;****************************

DELAY			equ	h'67';	
X_DELAY			equ	h'68';



;****************************
;*	 TEMP_OPTION	    *
;*       -----------        *
;* Used for various options *
;* in editing pages.	    *
;****************************

TEMP_OPTION		equ 	h'69';



;****************************
;*  Interrupt temp. values  *
;****************************

TEMP_W			equ	h'7E';(must be in the same location in b1/b0)
TEMP_STATUS		equ	h'7F';



;****************************
;*          Values          *
;*	    ------          *
;* Remember - don't hard    *
;* code values :)           *
;****************************

ADDER			equ	B'00110000';



;****************************
;*  	Gas Port (CO2)      *
;****************************

GAS_PORT		equ	PORTA;

;*** pins

GAS_PIN			equ	h'01'	;*** pin(1)
FAN_PIN			equ	h'02'	;*** pin(2)



;****************************
;*  	a/c Port (NEW)      *
;****************************

ACPORT			equ	PORTA;
ACPIN			equ	h'03'	;*** pin(3)

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*- BANK 1 - Registers *-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

		INDF1		equ	h'80'
		OPTIONR		equ	h'81'
		PCL1		equ	h'82'
		STATUS1		equ	h'83'
		FSR1		equ	h'84'
		TRISA		equ	h'85'
		TRISB		equ	h'86'
		TRISC		equ	h'87'
		TRISD		equ	h'88'
		TRISE		equ	h'89'
		PCLATH1		equ	h'8A'
		INTCON1		equ	h'8B'
		PIE1		equ	h'8C'
		PIE2		equ	h'8D'
		PCON		equ	h'8E'
		PR2		equ	h'92'
		SSPADD		equ	h'93'
		SSPSTAT		equ	h'94'
		TXSTA		equ	h'98'
		SPBRG		equ	h'99'
		ADCON1		equ	h'9F'



;****************************
;* 	 CO2 Fan Time       *
;****************************

CO2_ON_100MINS		equ	h'B0';The amount of time specified by the user
CO2_ON_10MINS		equ	h'B1';
CO2_ON_MINS		equ	h'B2';

CO2_ON_100MINS_DEC	equ	h'B9';The actual time that is being decremented
CO2_ON_10MINS_DEC	equ	h'BA';
CO2_ON_MINS_DEC		equ	h'BB';



;****************************
;* 	 CO2 Gas Time       *
;****************************

GAS_ON_100MINS		equ	h'B3';The amount of time specified by the user
GAS_ON_10MINS		equ	h'B4';
GAS_ON_MINS		equ	h'B5';

GAS_ON_100MINS_DEC	equ	h'BC';The actual time that is being decremented
GAS_ON_10MINS_DEC	equ	h'BD';
GAS_ON_MINS_DEC		equ	h'BE';



;****************************
;* 	CO2 Hold Time       *
;****************************

CO2_HOLD_100MINS	equ	h'B6';The amount of time specified by the user
CO2_HOLD_10MINS		equ	h'B7';
CO2_HOLD_MINS		equ	h'B8';

CO2_HOLD_100MINS_DEC	equ	h'BF';The actual time that is being decremented
CO2_HOLD_10MINS_DEC	equ	h'D0';
CO2_HOLD_MINS_DEC	equ	h'D1';



;****************************
;* 	  CO2 Stage         *
;*        ---------         *
;* The stage the CO2 is at. *
;****************************

CO2_STAGE		equ	h'D2'	;

;***  BITS - (1) = ACTIVE, (0) = OFF

FANSTAGE		EQU	H'00';BIT (2) HOLD
SPOOLING		EQU	H'01';BIT (3) SPOOL
GASSTAGE		EQU	H'02';BIT (0) CO2
HOLDING			EQU	H'03';BIT (1) GAS
CO2OFF			EQU	H'04';BIT (4) OFF




;****************************
;* 	Pump decrement      *
;****************************

PUMP_ON_100MINS_DEC	equ	h'D3';On decrement
PUMP_ON_10MINS_DEC	equ	h'D4';
PUMP_ON_MINS_DEC	equ	h'D5';

PUMP_OFF_100MINS_DEC	equ	h'D6';Off decrement
PUMP_OFF_10MINS_DEC	equ	h'D7';
PUMP_OFF_MINS_DEC	equ	h'D8';



;****************************
;* 	  Pump Stage        *
;*        ----------        *
;* The stage the pump is at *
;****************************

PUMP_STAGE		equ	h'D9';(0) - off, (1) - on



;****************************
;*  Interrupt temp. values  *
;****************************

TEMP_W1			equ	h'FE';bank 1 TEMP_W
TEMP_STATUS1		equ	h'FF';bank 1 TEMP_STATUS



;		   -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		*-*-		           PAGE 0			  *-*-
;		*-*		    	   ------			   -*-
;		 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		   -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-



;****************************
;*     	Reset Vector	    *
;****************************

	ORG	00			;Jump to here on reset
	goto 	INIT			;Goto the Initialisation phase



;****************************
;*     Interrupt Vector     *
;****************************
 	
	ORG	04

	movwf	TEMP_W			;preserve W reg(in b1 or 0)
	swapf	STATUS,0		;preserve 0 flag
	movwf	TEMP_STATUS		;save the status reg

	bcf	STATUS,5		;set to bank 0

	incf	HALFSECONDS		;increment time
	bcf	PIR1,0			;clear interrupt flag
	movlw	h'0b'
	movwf	TMR1H
	movlw	h'a4'
	movwf	TMR1L			;delay to Timer

	swapf	TEMP_STATUS,0		;restore status reg
	movwf	STATUS

	swapf	TEMP_W			;restore W reg without
					;changing STATUS bits
	swapf	TEMP_W,0		;(double swap)

	retfie



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-* INITIALISATION PHASE *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

INIT				;Start of code	



;****************************
;*  Set up LCD and PORTC    *
;*  --------------------    *
;* The LCD display needs    *
;* certain delays between   *
;* sending control info.    *
;* these are specified in   *
;* AMTEX - Displays comput- *
;* er systems 1997          *
;****************************

 
	movlw	h'1e'		;30 * 0.5mS = 15mS
	call	X_DELAY500
	movlw	b'00111000'	;set up inputs and outputs
	tris	PORTC		;for PORTC

	call	LCDINIT
	movlw	h'1e'		;30 * 0.5mS = 15mS
	call	X_DELAY500
	movlw	00
	call	LCDSDDA
	movlw	h'1e'		;30 * 0.5mS = 15mS
	call	X_DELAY500
	call	LCDBUSY
	movlw	B'00000100'	;cursor off
	call	LCDDMODE



;****************************
;*   Initialise registers   *
;****************************

	movlw	00		;Set these registers to 0

	movwf	TIME_SECS
	movwf	TIME_10SECS
	movwf	TIME_MINS
	movwf	TIME_10MINS
	movwf	TIME_HRS
	movwf	TIME_10HRS
	movwf	HALFSECONDS

	movwf	CONTROL2

	movwf	SECS
	movwf	SECS10
	movwf	MINS
	movwf	MINS10
	movwf	HRS
	movwf	HRS10

	movwf	PAGENUM

	movwf	LIGHT1_ON_10HRS		
	movwf	LIGHT1_ON_HRS		
	movwf	LIGHT1_ON_10MINS	
	movwf	LIGHT1_ON_MINS		
	
	movwf	LIGHT1_OFF_10HRS	
	movwf	LIGHT1_OFF_HRS		
	movwf	LIGHT1_OFF_10MINS	
	movwf	LIGHT1_OFF_MINS		

	movwf	TIMER_ON_10HRS		
	movwf	TIMER_ON_HRS		
	movwf	TIMER_ON_10MINS	
	movwf	TIMER_ON_MINS		

	movwf	TIMER_OFF_10HRS	
	movwf	TIMER_OFF_HRS		
	movwf	TIMER_OFF_10MINS	
	movwf	TIMER_OFF_MINS		



	movlw	d'00'
	movwf	PUMP_ON_100MINS	
	movwf	PUMP_ON_10MINS
	movlw	d'01'	
	movwf	PUMP_ON_MINS	
	movlw	d'00'
	movwf	PUMP_OFF_100MINS
	movwf	PUMP_OFF_10MINS	
	movlw	d'01'
	movwf	PUMP_OFF_MINS	


	movlw	b'00000000'	;** set up porta as outputs
	TRIS	PORTA		;
	movlw	b'00000000'
	movwf	PORTA

	bsf	STATUS,5	;** access bank 1 of registers **

	movlw	h'00'
	movwf	PUMP_STAGE

	movlw	h'ff'		;set up a/d to d
	movwf	ADCON1

	movlw	h'00'

	movwf	CO2_ON_100MINS		
	movwf	CO2_ON_10MINS
	movlw	d'01'		
	movwf	CO2_ON_MINS		
	movlw	d'00'
	movwf	GAS_ON_100MINS		
	movwf	GAS_ON_10MINS	
	movlw	d'01'	
	movwf	GAS_ON_MINS		
	movlw	d'00'
	movwf	CO2_HOLD_100MINS	
	movwf	CO2_HOLD_10MINS	
	movlw	d'01'	
	movwf	CO2_HOLD_MINS		
	movlw	d'00'
	movwf	CO2_ON_100MINS_DEC		
	movwf	CO2_ON_10MINS_DEC
	movlw	d'01'	
	movwf	CO2_ON_MINS_DEC	
	movlw	d'00'
	movwf	GAS_ON_100MINS_DEC		
	movwf	GAS_ON_10MINS_DEC
	movlw	d'01'	
	movwf	GAS_ON_MINS_DEC	
	movlw	d'00'
	movwf	CO2_HOLD_100MINS_DEC	
	movwf	CO2_HOLD_10MINS_DEC
	movlw	d'01'	
	movwf	CO2_HOLD_MINS_DEC


	movlw	d'00'
	movwf	PUMP_ON_100MINS_DEC
	movwf	PUMP_ON_10MINS_DEC
	movlw	d'01'
	movwf	PUMP_ON_MINS_DEC
	movlw	d'00'
	movwf	PUMP_OFF_100MINS_DEC
	movwf	PUMP_OFF_10MINS_DEC
	movlw	d'01'
	movwf	PUMP_OFF_MINS_DEC

	movlw	B'00010000'
	movwf	CO2_STAGE


	bcf	STATUS,5	;** access bank 0 of registers **

	movlw	b'00001000'	;Set to b#00001000
	movwf	CONTROL1	;set cursor flag

	movlw	06		;Set to 6
	movwf	CURSORPOSITION



;****************************
;*    Set CLOCK running     *
;****************************

	movlw	b'11000000'	;Set all interrupts ON
	movwf	INTCON
	bsf	STATUS,5	;bank1		
	movlw	b'00000001'	;Turn on interrupt (clock)
	movwf	PIE1
	bcf	STATUS1,5	;bank0
	movlw	b'00110001'	;Turn ON clock and prescalar
	movwf	T1CON



;****************************
;*    Jump to main code     *
;****************************

	bsf	PCLATH,3	;select PROM page 1
	goto	MAIN



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PAGE DISPLAY subroutines *-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	
PAGE0
DISPLAY

	call	LCDBUSY
	call	LCDHOME

	call	PRINTTIME

	movlw	d'33'		;32 spaces
	call	PRINTSPACES

	;****   Check for lower line display

	movlw	h'06'			;no cursor, used for
	subwf	CURSORPOSITION,0	;2nd line display
	bz	CO2STAGE		;PUMP or CO2 stage
	goto	PUMPSTAGE

CO2STAGE
	call	CO2		;print 'CO2'

	movlw	h'3A'		;print ':'
	call	LCDPUTCHAR
	
	bsf	STATUS,5	;set to bank 1


	btfsc	CO2_STAGE,FANSTAGE
	goto	CO2FAN
	btfsc	CO2_STAGE,SPOOLING
	goto	CO2SPOOL
	btfsc	CO2_STAGE,GASSTAGE
	goto	CO2GAS
	BTFSC	CO2_STAGE,HOLDING
	goto	CO2HOLD
	GOTO	CO2ISOFF

CO2FAN
	bcf	STATUS,5	;b0
	call	FAN		;print 'FAN'

	movlw	h'20'		;print ''
	call	LCDPUTCHAR

	bsf	STATUS,5	;b1
	movfw	CO2_ON_100MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS100
	bsf	STATUS,5	;b1	
	movfw	CO2_ON_10MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS10	
	bsf	STATUS,5	;b1
	movfw	CO2_ON_MINS_DEC	
	bcf	STATUS,5	;b0	
	movwf	MINS

	call	PRINTTIME5

	call	_MINS		;print '_mins'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

CO2SPOOL
	bcf	STATUS,5	;b0
	movlw	h'53'		;print 'S'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'4c'		;print 'L'
	call	LCDPUTCHAR
	movlw	h'49'		;print 'I'
	call	LCDPUTCHAR
	movlw	h'4e'		;print 'N'
	call	LCDPUTCHAR
	movlw	h'47'		;print 'G'
	call	LCDPUTCHAR

	movlw	d'10'		;9 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

CO2GAS
	bcf	STATUS,5	;b0
	call	GAS		;print 'GAS'

	movlw	h'20'		;print ''
	call	LCDPUTCHAR

	bsf	STATUS,5	;b1
	movfw	GAS_ON_100MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS100	
	bsf	STATUS,5	;b1
	movfw	GAS_ON_10MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS10	
	bsf	STATUS,5	;b1
	movfw	GAS_ON_MINS_DEC
	bcf	STATUS,5	;b0		
	movwf	MINS

	call	PRINTTIME5

	call	_MINS		;print '_MINS'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

CO2HOLD
	bcf	STATUS,5	;b0

	movlw	h'48'		;print 'H'
	call	LCDPUTCHAR
	movlw	h'4c'		;print 'L'
	call	LCDPUTCHAR
	movlw	h'44'		;print 'D'
	call	LCDPUTCHAR

	movlw	h'20'		;print ''
	call	LCDPUTCHAR

	bsf	STATUS,5	;b1
	movfw	CO2_HOLD_100MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS100	
	bsf	STATUS,5	;b1
	movfw	CO2_HOLD_10MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS10	
	bsf	STATUS,5	;b1
	movfw	CO2_HOLD_MINS_DEC
	bcf	STATUS,5	;b0		
	movwf	MINS

	call	PRINTTIME5

	call	_MINS		;print '_MINS'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

CO2ISOFF
	bcf	STATUS,5	;b0
	call	OFF		;print 'OFF'

	movlw	d'14'		;13 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

PUMPSTAGE

;**********************
;*   check for pump   *
;*    on/off mode     *
;*    -----------     *
;**********************

;*** check for 000 on value (ifso, bypass) **************

	bcf	STATUS,5

	movfw	PUMP_ON_MINS
	addlw	00
	bz	PUMPdisplayonCHECKMINS10
	goto	PUMPdisplayonNOTALLZEROS
PUMPdisplayonCHECKMINS10
	movfw	PUMP_ON_10MINS
	addlw	00
	bz	PUMPdisplayonCHECKMINS100
	goto	PUMPdisplayonNOTALLZEROS
PUMPdisplayonCHECKMINS100
	movfw	PUMP_ON_100MINS
	addlw	00
	bz	BypassTurndisplayonPump	
PUMPdisplayonNOTALLZEROS
	GOTO	NotAllZerospump
BypassTurndisplayonPump

;*** check for 000 on value (ifso, bypass) **************

	movfw	PUMP_OFF_MINS
	addlw	00
	bz	PUMPdisplayoffCHECKMINS10
	goto	PUMPdisplayoffNOTALLZEROS
PUMPdisplayoffCHECKMINS10
	movfw	PUMP_OFF_10MINS
	addlw	00
	bz	PUMPdisplayoffCHECKMINS100
	goto	PUMPdisplayoffNOTALLZEROS
PUMPdisplayoffCHECKMINS100
	movfw	PUMP_OFF_100MINS
	addlw	00
	bz	BypassTurndisplayoffPump	
PUMPdisplayoffNOTALLZEROS
	GOTO	NotAllZerospump
BypassTurndisplayoffPump

	GOTO	PUMPSTAGENA

;*** end check *******************************************

NotAllZerospump
;**********************

	bsf	STATUS,5	;b1

	btfss	PUMP_STAGE,0
	goto	PUMPSTAGEOFF

PUMPSTAGEON
	bcf	STATUS,5	;b0

	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	movlw	h'4d'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR

	movlw	h'3A'		;print ':'
	call	LCDPUTCHAR
	
	call	ON		;print 'ON'

	movlw	h'20'		;print ''
	call	LCDPUTCHAR

	bsf	STATUS,5	;b1
	movfw	PUMP_ON_100MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS100	
	bsf	STATUS,5	;b1
	movfw	PUMP_ON_10MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS10	
	bsf	STATUS,5	;b1
	movfw	PUMP_ON_MINS_DEC
	bcf	STATUS,5	;b0		
	movwf	MINS

	call	PRINTTIME5

	call	_MINS		;print '_MINS'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

PUMPSTAGENA
	bcf	STATUS,5	;b0

	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	movlw	h'4d'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR

	movlw	h'3A'		;print ':'
	call	LCDPUTCHAR
	
	call	OFF		;print 'OFF'

	movlw	d'13'		;12 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS

PUMPSTAGEOFF
	bcf	STATUS,5	;b0

	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	movlw	h'4d'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR

	movlw	h'3A'		;print ':'
	call	LCDPUTCHAR

	call	OFF		;print 'OFF'

	movlw	h'20'		;print ''
	call	LCDPUTCHAR

	bsf	STATUS,5	;b1
	movfw	PUMP_OFF_100MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS100	
	bsf	STATUS,5	;b1
	movfw	PUMP_OFF_10MINS_DEC
	bcf	STATUS,5	;b0
	movwf	MINS10	
	bSf	STATUS,5	;b1
	movfw	PUMP_OFF_MINS_DEC
	bcf	STATUS,5	;b0		
	movwf	MINS

	call	PRINTTIME5

	call	_MINS		;print '_MINS'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES


CHECKBUTTONS
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'5'
	movwf	CURSORSTART
	call	CHECKACR
	call	CHECKUP
	call	CHECKOK

	return
;*-----------------------------------------------------------*



PAGE1
	
DISPLAYL1ON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS1	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST1

	call	LIGHT		;print	'LIGHT'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES
	
	call	ON		;print 'ON'

	call	PRINTTIME2
	call	MOVECURSOR2

CHECKBUTTONS1
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'3'
	movwf	CURSORSTART
	call	CHECKACR
	call	CHECKUP
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE2

DISPLAYL1OFF
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS2	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST2

	call	LIGHT		;print 'LIGHT'

	movlw	d'09'		;8 spaces
	call	PRINTSPACES
	
	call	OFF		;print 'OFF'

	call	PRINTTIME2
	call	MOVECURSOR2

CHECKBUTTONS2
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'3'
	movwf	CURSORSTART

	call	CHECKACR
	call	CHECKUP
	call	CHECKOK
	return
;*-----------------------------------------------------------*
	


PAGE3

DISPLAYL2ON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS3	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST3

	call	TIMER		;print 'TIMER'

	movlw	d'10'		;9 spaces
	call	PRINTSPACES
	
	call	ON		;print 'ON'

	call	PRINTTIME2
	call	MOVECURSOR2

CHECKBUTTONS3
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'3'
	movwf	CURSORSTART

	call	CHECKACR
	call	CHECKUP
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE4

DISPLAYL2OFF
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS4	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST4

	call	TIMER		;print 'TIMER'

	movlw	d'09'		;8 spaces
	call	PRINTSPACES
	
	call	OFF		;print 'OFF'

	call	PRINTTIME2
	call	MOVECURSOR2

CHECKBUTTONS4
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'3'
	movwf	CURSORSTART

	call	CHECKACR
	call	CHECKUP
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE5

DISPLAYPUMPON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS5	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST5

	call	PUMP		;print 'PUMP'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	ON		;print 'ON'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	;call	FOR		;print 'FOR'

	movlw	d'09'		;8 spaces
	call	PRINTSPACES
	

	call	PRINTTIME3

	call	_MINS		;print '_MINS'

	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	call	MOVECURSOR3

CHECKBUTTONS5
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'4'
	movwf	CURSORSTART

	call	CHECKACR
	call	CHECKUP3
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE6

DISPLAYPUMPOFF
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS6	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME

	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST6

	call	PUMP		;print 'PUMP'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	OFF		;print 'Off'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	;call	FOR		;print 'FOR'

	movlw	d'08'		;7 spaces
	call	PRINTSPACES

	call	PRINTTIME3	
	
	call	_MINS		;print '_MINS'

	call	MV5LEFT		;move cursor 5 to left

	call	MOVECURSOR3

CHECKBUTTONS6
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'4'
	movwf	CURSORSTART

	call	CHECKACR
	call	CHECKUP3
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE7

DISPLAYFANON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS7	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME

	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST7

	call	CO2		;print 'CO2'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	FAN		;print 'FAN'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	ON		;print 'ON'

	movlw	d'07'		;6 spaces
	call	PRINTSPACES
	
	call	PRINTTIME3	

	call	_MINS		;print '_MINS'

	call 	MV5LEFT		;move cursor 5 to left

	call	MOVECURSOR3

CHECKBUTTONS7
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'4'
	movwf	CURSORSTART
	call	CHECKACR
	call	CHECKUP3
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE8

DISPLAYGASON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS8	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME

	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST8

	call	CO2		;print 'CO2'	

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	GAS		;print 'GAS'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	ON		;print 'ON'

	movlw	d'07'		;6 spaces
	call	PRINTSPACES
	
	call	PRINTTIME3

	call	_MINS		;print '_MINS'

	call	MV5LEFT		;move cursor 5 to left

	call	MOVECURSOR3

CHECKBUTTONS8
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'4'
	movwf	CURSORSTART
	call	CHECKACR
	call	CHECKUP3
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE9

DISPLAYHOLD
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS9	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME

	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST9

	call	CO2		;print 'CO2'

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	HOLD		;print 'HOLD'

	movlw	d'09'		;8 spaces
	call	PRINTSPACES

	call	PRINTTIME3
	
	call	_MINS		;print '_MINS'

	call	MV5LEFT		;move cursor 5 to left

	call	MOVECURSOR3

CHECKBUTTONS9
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'3'

	call	CHECKACR
	call	CHECKUP3
	call	CHECKOK
	return
;*-----------------------------------------------------------*



PAGE10

SETTIME?
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS10	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag

AFTERCURSORTEST10

	movlw	h'53'		;print 'S'
	call	LCDPUTCHAR
	movlw	h'45'		;print 'E'
	call	LCDPUTCHAR
	movlw	h'54'		;print 'T'
	call	LCDPUTCHAR

	movlw	h'20'		;print a space
	call	LCDPUTCHAR

	call	TIME		;print 'TIME'

	movlw	h'3f'		;print a '?'
	call	LCDPUTCHAR
	
	movlw	d'32'		;31 spaces
	call	PRINTSPACES
	

	movfw	TEMP_OPTION
	addlw	00		;IF TEMP_OPTION = 1
	bz	YES
	
NO	

	movlw	h'59'		;print 'Y'
	call	LCDPUTCHAR
	movlw	h'45'		;print 'E'
	call	LCDPUTCHAR
	movlw	h'53'		;print 'S'
	call	LCDPUTCHAR

	movlw	d'15'		;15 spaces
	call	PRINTSPACES

	goto	CHECKBUTTONS10


YES
	movlw	h'4e'		;print 'N'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR

	movlw	d'15'		;15 spaces
	call	PRINTSPACES

CHECKBUTTONS10

	movlw	d'2'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'1'
	movwf	CURSORSTART
	call	CHECKACR
	movlw	d'1'		;subtract 1 from cursor position
	subwf	CURSORPOSITION,0
	movwf	TEMP_OPTION	;find out which option...
	call	CHECKOK
	return
;*-----------------------------------------------------------*	



PAGE12

DISPLAY12ON
	btfss	CONTROL1,03	;check cursor/increment bit in CONTROL1
	goto	CHECKBUTTONS12	;has bit cleared?yes - bypass all printing
	call	LCDBUSY
	call	LCDHOME
	BCF	CONTROL1,03	;clear cursor flag
AFTERCURSORTEST12

	call	TIME		;print 'TIME'

	movlw	d'37'		;36 spaces
	call	PRINTSPACES

	call	PRINTTIME
	call	MOVECURSOR

CHECKBUTTONS12
	movlw	d'6'
	movwf	NO_CURSOR_POSITIONS
	movlw	d'1'
	movwf	CURSORSTART
	call	CHECKACR
	call	CHECKUP
	call	CHECKOK
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-* TEXT subroutines *-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

CO2
	movlw	h'43'		;print 'C'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'32'		;print '2'
	call	LCDPUTCHAR
	return
FAN
	movlw	h'46'		;print 'F'
	call	LCDPUTCHAR
	movlw	h'41'		;print 'A'
	call	LCDPUTCHAR
	movlw	h'4E'		;print 'N'
	call	LCDPUTCHAR
	return
_MINS
	movlw	h'20'		;print ' '
	call	LCDPUTCHAR
	movlw	h'6d'		;print 'm'
	call	LCDPUTCHAR
	movlw	h'69'		;print 'i'
	call	LCDPUTCHAR
	movlw	h'6E'		;print 'n'
	call	LCDPUTCHAR
	movlw	h'73'		;print 's'
	call	LCDPUTCHAR
	return
GAS
	movlw	h'47'		;print 'G'
	call	LCDPUTCHAR
	movlw	h'41'		;print 'A'
	call	LCDPUTCHAR
	movlw	h'53'		;print 'S'
	call	LCDPUTCHAR
	return
HOLD
	movlw	h'48'		;print 'H'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'4c'		;print 'L'
	call	LCDPUTCHAR
	movlw	h'44'		;print 'D'
	call	LCDPUTCHAR
	return
OFF
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'46'		;print 'F'
	call	LCDPUTCHAR
	movlw	h'46'		;print 'F'
	call	LCDPUTCHAR
	return
PUMP
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	movlw	h'55'		;print 'U'
	call	LCDPUTCHAR
	movlw	h'4d'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	return
ON
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'4e'		;print 'N'
	call	LCDPUTCHAR
	return
LIGHT
	movlw	h'4c'		;print 'L'
	call	LCDPUTCHAR
	movlw	h'49'		;print 'I'
	call	LCDPUTCHAR
	movlw	h'47'		;print 'G'
	call	LCDPUTCHAR
	movlw	h'48'		;print 'H'
	call	LCDPUTCHAR
	movlw	h'54'		;print 'T'
	call	LCDPUTCHAR
	return
FOR
	movlw	h'46'		;print 'F'
	call	LCDPUTCHAR
	movlw	h'4f'		;print 'O'
	call	LCDPUTCHAR
	movlw	h'52'		;print 'R'
	call	LCDPUTCHAR
	return
ALWAYS
	movlw	h'41'		;print 'A'
	call	LCDPUTCHAR
	movlw	h'57'		;print 'W'
	call	LCDPUTCHAR
	movlw	h'4c'		;print 'L'
	call	LCDPUTCHAR
	movlw	h'41'		;print 'A'
	call	LCDPUTCHAR
	movlw	h'59'		;print 'Y'
	call	LCDPUTCHAR
	movlw	h'53'		;print 'S'
	call	LCDPUTCHAR
	return
TEMP
	movlw	h'54'		;print 'T'
	call	LCDPUTCHAR
	movlw	h'45'		;print 'E'
	call	LCDPUTCHAR
	movlw	h'4d'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'50'		;print 'P'
	call	LCDPUTCHAR
	return
TIME
	movlw	h'54'		;print 'T'
	call	LCDPUTCHAR
	movlw	h'49'		;print 'I'
	call	LCDPUTCHAR
	movlw	h'4D'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'45'		;print 'E'
	call	LCDPUTCHAR
	return


TIMER
	movlw	h'54'		;print 'T'
	call	LCDPUTCHAR
	movlw	h'49'		;print 'I'
	call	LCDPUTCHAR
	movlw	h'4D'		;print 'M'
	call	LCDPUTCHAR
	movlw	h'45'		;print 'E'
	call	LCDPUTCHAR
	movlw	h'52'		;print 'R'
	call	LCDPUTCHAR
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* NEXT PAGE SETTINGS subroutine *-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;set variuos control bits for the next page

NEXTPAGESETTINGS
	bsf	CONTROL1,03		;	set to write
	bcf	CONTROL1,UPDATE		;	clear UPDATE
	bcf	CONTROL1,PAGEBIT	;	clear PAGEBIT
	bcf 	CONTROL2,CHANGEFLAG	;A change has NOT occured yet!
	incf	PAGENUM			;	next page
	movfw	CURSORSTART
	movwf	CURSORPOSITION
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* CHECK UPBUTTON subroutine *-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;check the UP button

CHECKUP
	btfss	BUTTONPORT,UPBUTTON	;IF UP pressed
	goto	AFTERUPCHECK
	movlw	h'32'			;   	wait 25 ms
	call	X_DELAY500		;	
	btfss	BUTTONPORT,UPBUTTON	;	IF UP still pressed
	goto	AFTERUPCHECK
	bsf	CONTROL1,UPFLAG		;		set UP flag
	return
AFTERUPCHECK
	btfss	CONTROL1,UPFLAG		;ELSE IF UP flag on (UP not pressed)
	return				;
	bcf	CONTROL1,UPFLAG		;	clear UP flag
	bsf	CONTROL1,03		;	set cursor flag
	call	INCREMENT
	return				;ELSE return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* CHECK UPBUTTON3 subroutine -*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;check the UP button

CHECKUP3
	btfss	BUTTONPORT,UPBUTTON	;IF UP pressed
	goto	AFTERUPCHECK3
	movlw	h'32'			;   	wait 25 ms
	call	X_DELAY500		;	
	btfss	BUTTONPORT,UPBUTTON	;	IF UP still pressed
	goto	AFTERUPCHECK3
	bsf	CONTROL1,UPFLAG		;		set UP flag
	bsf	CONTROL2,CHANGEFLAG	;		a change has occured (set flag)
	return
AFTERUPCHECK3
	btfss	CONTROL1,UPFLAG		;ELSE IF UP flag on (UP not pressed)
	return				;
	bcf	CONTROL1,UPFLAG		;	clear UP flag
	bsf	CONTROL1,03		;	set cursor flag
	call	INCREMENT3
	return				;ELSE return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* CHECK UPBUTTON4 subroutine -*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;check the UP button

CHECKUP4
	btfss	BUTTONPORT,UPBUTTON	;IF UP pressed
	goto	AFTERUPCHECK4
	movlw	h'32'			;   	wait 25 ms
	call	X_DELAY500		;	
	btfss	BUTTONPORT,UPBUTTON	;	IF UP still pressed
	goto	AFTERUPCHECK4
	bsf	CONTROL1,UPFLAG		;		set UP flag
	return
AFTERUPCHECK4
	btfss	CONTROL1,UPFLAG		;ELSE IF UP flag on (UP not pressed)
	return				;
	bcf	CONTROL1,UPFLAG		;	clear UP flag
	bsf	CONTROL1,03		;	set cursor flag
	call	INCREMENT4
	return				;ELSE return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* INCREMENT Subroutines *-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;increment the value (MINS,SECS.. etc.) that the cursor is 
;placed under (CURSORPOSITION)

INCREMENT
	movlw	h'01'
	subwf	CURSORPOSITION,0
	bz	IT1
	movlw	h'02'
	subwf	CURSORPOSITION,0
	bz	IT2
	movlw	h'03'
	subwf	CURSORPOSITION,0
	bz	IT3
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	IT4
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	IT5
	goto	IT6
;*-----------------------------------------------------------*
IT1
	movlw	D'08'		;IF SECS < 9 THEN
	movwf	DIVISOR		;
	movfw	SECS		;
	subwf	DIVISOR,0	;
	bnc	IT1RESET	;
	incf	SECS		;	ADD 1 TO SECS
	
	return			;	
IT1RESET
	movlw	00		;ELSE SECS = 0
	movwf	SECS		;

	return
;*-----------------------------------------------------------*
IT2
	movlw	D'04'		;IF SECS10 < 9 THEN
	movwf	DIVISOR		;
	movfw	SECS10		;
	subwf	DIVISOR,0	;
	bnc	IT2RESET	;
	incf	SECS10		;	ADD 1 TO SECS10
	return			;
IT2RESET
	movlw	00		;ELSE SECS10 = 0
	movwf	SECS10		;
	return
;*-----------------------------------------------------------*
IT3
	movlw	D'08'		;IF MINS < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS		;
	subwf	DIVISOR,0	;
	bnc	IT3RESET	;
	incf	MINS		;	ADD 1 TO MINS
	return			;
IT3RESET	
	movlw	00		;ELSE MINS = 0
	movwf	MINS		;
	return
	
;*-----------------------------------------------------------*
IT4
	movlw	D'04'		;IF MINS10 < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS10		;
	subwf	DIVISOR,0	;
	bnc	IT4RESET	;
	incf	MINS10		;	ADD 1 TO MINS10
	return			;
IT4RESET
	movlw	00		;ELSE MINS10 = 0
	movwf	MINS10		;
	return
	
;*-----------------------------------------------------------*
IT5
	movlw	d'02'		;IF HRS10 = 2 GOTO IT5HRS10IS2
	subwf	HRS10,0		;
	bz	IT5HRS10IS2	;

	movlw	D'09'		;IF HRS < 9 THEN
	movwf	DIVISOR		;
	movfw	HRS		;
	subwf	DIVISOR,0	;
	bnc	IT5RESET	;
	incf	HRS		;	ADD 1 TO HRS
	return			;
IT5RESET
	movlw	00		;ELSE HRS = 0
	movwf	HRS		;
	return
;*-----------------------------------------------------------*
IT5HRS10IS2
	movlw	D'02'		;IF HRS < 3 THEN
	movwf	DIVISOR		;
	movfw	HRS		;
	subwf	DIVISOR,0	;
	bnc	IT5HRESET	;
	incf	HRS		;	ADD 1 TO HRS
	return			;
IT5HRESET
	movlw	00		;ELSE HRS = 0
	movwf	HRS		;
	return
;*-----------------------------------------------------------*
IT6
	movlw	D'01'		;IF HRS10 < 2 THEN
	movwf	DIVISOR		;
	movfw	HRS10		;
	subwf	DIVISOR,0	;
	bnc	IT6RESET	;
	incf	HRS10		;	ADD 1 TO HRS10

	movlw	d'02'		;IF HRS10 = 2 GOTO IT6RESET2
	subwf	HRS10,0		;
	bz	IT6RESET2	;

	return			;
IT6RESET2
	movlw	00
	movwf	HRS
	return
IT6RESET
	movlw	00		;ELSE HRS10 = 0
	movwf	HRS10		;
	return
;*-----------------------------------------------------------*



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* INCREMENT2 Subroutines *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;increment the value (MINS,SECS.. etc.) that the cursor is 
;placed under (CURSORPOSITION)

INCREMENT2
	movlw	h'03'
	subwf	CURSORPOSITION,0
	bz	IT21
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	IT22
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	IT23
	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	IT24

;*-----------------------------------------------------------*
IT21
	movlw	D'08'		;IF MINS < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS		;
	subwf	DIVISOR,0	;
	bnc	IT21RESET	;
	incf	MINS		;	ADD 1 TO MINS
	return			;
IT21RESET
	
	movlw	00		;ELSE MINS = 0
	movwf	MINS		;
	return

;*-----------------------------------------------------------*
IT22
	movlw	D'04'		;IF MINS10 < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS10		;
	subwf	DIVISOR,0	;
	bnc	IT22RESET	;
	incf	MINS10		;	ADD 1 TO MINS10
	return			;
IT22RESET

	movlw	00		;ELSE MINS10 = 0
	movwf	MINS10		;
	return

;*-----------------------------------------------------------*
IT23
	movlw	D'02'		;IF HRS < 3 THEN
	movwf	DIVISOR		;
	movfw	HRS		;
	subwf	DIVISOR,0	;
	bnc	IT23RESET	;
	incf	HRS		;	ADD 1 TO HRS
	return			;
IT23RESET
	movlw	00		;ELSE HRS = 0
	movwf	HRS		;
	return
;*-----------------------------------------------------------*
IT24
	movlw	D'01'		;IF HRS10 < 2 THEN
	movwf	DIVISOR		;
	movfw	HRS10		;
	subwf	DIVISOR,0	;
	bnc	IT24RESET	;
	incf	HRS10		;	ADD 1 TO HRS10
	return			;
IT24RESET
	movlw	00		;ELSE HRS10 = 0
	movwf	HRS10		;
	return
;*-----------------------------------------------------------*



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* INCREMENT3 Subroutines *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;increment the value (MINS,SECS.. etc.) that the cursor is 
;placed under (CURSORPOSITION)

INCREMENT3
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	IT31
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	IT32
	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	IT33

;*-----------------------------------------------------------*
IT31
	movlw	D'08'		;IF MINS < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS		;
	subwf	DIVISOR,0	;
	bnc	IT31RESET	;
	incf	MINS		;	ADD 1 TO MINS
	return			;
IT31RESET	
	movlw	01		;ELSE MINS = 1
	movwf	MINS		;
	return

;*-----------------------------------------------------------*
IT32
	movlw	D'08'		;IF MINS10 < 9 THEN
	movwf	DIVISOR		;
	movfw	MINS10		;
	subwf	DIVISOR,0	;
	bnc	IT32RESET	;
	incf	MINS10		;	ADD 1 TO MINS10
	return			;
IT32RESET

	movlw	00		;ELSE MINS10 = 0
	movwf	MINS10		;
	return

;*-----------------------------------------------------------*
IT33
	movlw	D'08'		;IF HRS < 3 THEN
	movwf	DIVISOR		;
	movfw	MINS100		;
	subwf	DIVISOR,0	;
	bnc	IT33RESET	;
	incf	MINS100		;	ADD 1 TO HRS
	return			;
IT33RESET
	movlw	00		;ELSE HRS = 0
	movwf	MINS100		;
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* INCREMENT4 Subroutines *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;increment the value (MINS,SECS.. etc.) that the cursor is 
;placed under (CURSORPOSITION)

INCREMENT4

	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	IT41
	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	IT42

;*-----------------------------------------------------------*
IT41
	movlw	D'08'		;IF SECS < 9 THEN
	movwf	DIVISOR		;
	movfw	SECS		;
	subwf	DIVISOR,0	;
	bnc	IT41RESET	;
	incf	SECS		;	ADD 1 TO SECS
	return			;
IT41RESET	
	movlw	00		;ELSE SECS = 0
	movwf	SECS		;
	return

;*-----------------------------------------------------------*
IT42
	movlw	D'08'		;IF SECS10 < 9 THEN
	movwf	DIVISOR		;
	movfw	SECS10		;
	subwf	DIVISOR,0	;
	bnc	IT42RESET	;
	incf	SECS10		;	ADD 1 TO SECS10
	return			;
IT42RESET

	movlw	00		;ELSE SECS10 = 0
	movwf	SECS10		;
	return

;*-----------------------------------------------------------*



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* MOVE CURSOR Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;move the cursor to the value in CURSORPOSITION (skipping : 
;& .)

MOVECURSOR

	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	MC6
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	MC5
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	MC4
	movlw	h'03'
	subwf	CURSORPOSITION,0
	bz	MC3
	movlw	h'02'
	subwf	CURSORPOSITION,0
	bz	MC2
	goto	MC1
MC1
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC2
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	return
MC3
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC4
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC5
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC6	
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return	



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* MOVE CURSOR2 Subroutines -*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;move the cursor to the value in CURSORPOSITION (skipping : 
;& .)

MOVECURSOR2

	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	MC24
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	MC23
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	MC22
	goto	MC1
MC21
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC22
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	return
MC23
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC24
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* MOVE CURSOR3 Subroutines -*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;move the cursor to the value in CURSORPOSITION (skipping : 
;& .)

MOVECURSOR3

	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	MC34
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	MC33
	movlw	h'04'
	subwf	CURSORPOSITION,0
	bz	MC32

MC32
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC33
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	return
MC34
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* MOVE CURSOR4 Subroutines -*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;move the cursor to the value in CURSORPOSITION (skipping : 
;& .)

MOVECURSOR4

	movlw	h'06'
	subwf	CURSORPOSITION,0
	bz	MC44
	movlw	h'05'
	subwf	CURSORPOSITION,0
	bz	MC43

MC43
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD

	return
MC44
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* MOVE CURSOR5 Subroutine  -*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

MV5LEFT
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	movlw	B'00010000'	;move cursor 1 to left
	call	LCDPUTCMD
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* CHECK ACRBUTTON subroutines *-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;check the across button

CHECKACR
	btfss	BUTTONPORT,ACRBUTTON	;IF ACR pressed
	goto	AFTERACRCHECK
	movlw	h'32'			;   	wait 25 ms
	call	X_DELAY500		;	
	btfss	BUTTONPORT,ACRBUTTON	;	IF ACR still pressed
	goto	AFTERACRCHECK
	bsf	CONTROL1,ACRFLAG	;		set ACR flag
	return
AFTERACRCHECK
	btfss	CONTROL1,ACRFLAG	;ELSE IF ACR flag on (ACR not pressed)
	return				;
	bcf	CONTROL1,ACRFLAG	;	clear ACR flag
	bsf	CONTROL1,03		;	set cursor flag
	movfw	NO_CURSOR_POSITIONS	;
	subwf	CURSORPOSITION,0	;
	bz	ACRMOVEN		;	IF CSPOS = NO_C_P
					;		CSPOS=1	
	incf	CURSORPOSITION		;	ELSE increment CSPOS
	return				;
ACRMOVEN	
	movfw	CURSORSTART
	movwf	CURSORPOSITION	
	return				;ELSE return




;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* CHECK OK Subroutines *-*-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;checks if OK was pressed, if so it sets the UPDATE flag

CHECKOK	
	btfss	BUTTONPORT,OK	;IF OK pressed
	goto	AFTEROKCHECK
	movlw	h'32'		;   	wait 25 ms
	call	X_DELAY500	;	
	btfss	BUTTONPORT,OK	;	IF OK still pressed
	goto	AFTEROKCHECK
	bsf	CONTROL1,OKFLAG	;		set OK flag
	return
AFTEROKCHECK
	btfss	CONTROL1,OKFLAG	;ELSE IF OK flag on (OK not pressed)
	return			;
	bcf	CONTROL1,OKFLAG	;	clear OK flag
				;	set UPDATE bit
	bsf	CONTROL1,UPDATE	;	return
	return			;ELSE return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT SPACES Subroutine *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;The no. of spaces to print should be in the w register

PRINTSPACES
	movwf	TEMP01		;print n spaces in w
LOOP2
	decfsz	TEMP01
	goto	PRINTSPACE
	return
PRINTSPACE
	call	LCDBUSY
	movlw	B'00100000'	;a space
	call	LCDPUTCHAR
	goto	LOOP2



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT TIME  Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

PRINTTIME	
		
	call	LCDBUSY		;print each individual digit
	movfw	HRS10
	addlw	B'00110000'	
	call 	LCDPUTCHAR		
	call	LCDBUSY
	movfw	HRS
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movlw	B'00111010'	;':'
	call	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS10	
	addlw	B'00110000'
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movlw	B'00101110'	;'.'
	call	LCDPUTCHAR
	call	LCDBUSY
	movfw	SECS10
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	SECS
	addlw	B'00110000'	
	call 	LCDPUTCHAR

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT TIME2 Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

PRINTTIME2	
	movlw	D'25'		;print ot 25 spaces
	call	PRINTSPACES			
	call	LCDBUSY		;print each individual digit
	movfw	HRS10
	addlw	B'00110000'	
	call 	LCDPUTCHAR		
	call	LCDBUSY
	movfw	HRS
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movlw	B'00111010'	;':'
	call	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS10	
	addlw	B'00110000'
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS
	addlw	B'00110000'	
	call 	LCDPUTCHAR

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT TIME3 Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

PRINTTIME3	
	movlw	D'25'		;print ot 25 spaces
	call	PRINTSPACES			
	call	LCDBUSY		;print each individual digit
	movfw	MINS100
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS10	
	addlw	B'00110000'
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS
	addlw	B'00110000'	
	call 	LCDPUTCHAR

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT TIME4 Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

PRINTTIME4	
	movlw	D'25'		;print ot 25 spaces
	call	PRINTSPACES			
	call	LCDBUSY		;print each individual digit
	movfw	SECS10
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	SECS	
	addlw	B'00110000'
	call 	LCDPUTCHAR

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-* PRINT TIME5 Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

PRINTTIME5	
		
	call	LCDBUSY		;print each individual digit
	movfw	MINS100
	addlw	B'00110000'	
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS10	
	addlw	B'00110000'
	call 	LCDPUTCHAR
	call	LCDBUSY
	movfw	MINS
	addlw	B'00110000'	
	call 	LCDPUTCHAR

	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-* INCREMENT TIME  Subroutines *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

CHECKSECS

	movlw	D'08'		;ELSE IF SECS < 9 THEN
	movwf	DIVISOR		;
	movfw	ISECS		;
	subwf	DIVISOR,0	;
	bnc	CHECK10SECS	;
	incf	ISECS		;	ADD 1 TO SECS
	return			;
CHECK10SECS
	movlw	D'04'		;ELSE IF SECS10 < 5 THEN
	movwf	DIVISOR		;
	movfw	ISECS10		;
	subwf	DIVISOR,0	;
	bnc	CHECKMINS	;
	incf	ISECS10		;	ADD 1 TO SECS10
	movlw	00		;	SECS = 0
	movwf	ISECS		;
	return			;	
CHECKMINS			;CHECKMINS	
	movlw	D'08'		;(ELSE) IF MINS < 9 THEN
	movwf	DIVISOR		;
	movfw	IMINS		;
	subwf	DIVISOR,0	;
	bnc	CHECK10MINS	;
	incf	IMINS		;	ADD 1 TO MINS
	movlw	00		;	SECS = 0
	movwf	ISECS		;	SECS10 = 0
	movwf	ISECS10		;
	bsf	CONTROL2,MINUTEFLAG	;Set MinuteFlag
	return			;
CHECK10MINS
	movlw	D'04'		;ELSE IF MINS10 < 5 THEN
	movwf	DIVISOR		;
	movfw	IMINS10		;
	subwf	DIVISOR,0	;
	bnc	CHECKHRS	;
	incf	IMINS10		;	ADD 1 TO MINS10
	movlw	00		;	
	movwf	ISECS		;	SECS = 0
	movwf	ISECS10		;	SECS10 = 0
	movwf	IMINS		;	MINS = 0
	return			;
CHECKHRS	
	movlw	D'01'		;ELSE IF HRS10 < 2 THEN
	movwf	DIVISOR		;
	movfw	IHRS10		;
	subwf	DIVISOR,0	;
	bnc	CHECKHRS2	;
	movlw	D'08'		;	IF HRS < 9 THEN
	movwf	DIVISOR		;
	movfw	IHRS		;
	subwf	DIVISOR,0	;
	bnc	CHECK10HRS	;
	incf	IHRS		;		ADD 1 TO HRS
	movlw	00		;		SECS = 0
	movwf	ISECS		;		SECS10 = 0
	movwf	ISECS10		;		MINS=0
	movwf	IMINS		;		MINS10=0
	movwf	IMINS10		;
	return			;
CHECK10HRS
	incf	IHRS10		;	ELSE	ADD 1 TO HRS10
	movlw	00		;		SECS = 0
	movwf	ISECS		;		SECS10 = 0
	movwf	ISECS10		;		MINS=0
	movwf	IMINS		;		MINS10=0
	movwf	IMINS10		;		HRS=0
	movwf	IHRS		;
	return			;	
CHECKHRS2
	movlw	D'02'		;ELSE IF HRS < 3 THEN
	movwf	DIVISOR		;
	movfw	IHRS		;
	subwf	DIVISOR,0	;
	bnc	LASTCHECK	;
	incf	IHRS		;	ADD 1 TO HRS
	movlw	00		;	SECS = 0
	movwf	ISECS		;	SECS10 = 0
	movwf	ISECS10		;	MINS=0
	movwf	IMINS		;	MINS10=0
	movwf	IMINS10		;
	return			;
LASTCHECK
	movlw	00		;ELSE	SECS = 0
	movwf	ISECS		;	SECS10 = 0
	movwf	ISECS10		;	MINS=0
	movwf	IMINS		;	MINS10=0
	movwf	IMINS10		; 	HRS=0
	movwf	IHRS		;	HRS10=0
	movwf	IHRS10		;
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-* Liquid Crystal Display Subroutines *-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

LCDINIT
	clrf	LCD_CTRL	;all port outputs low
	movlw	h'1e'		;30 * 0.5mS = 15mS
	call	X_DELAY500
	movlw	h'38'		;8-bit , 2 line
	call	LCDPUTCMD
	movlw	00		;disp off, curs off, no blink
	call	LCDDMODE
	call	LCDCLEAR
	movlw	h'04'		;disp on, curs off
	call	LCDDMODE
	movlw	h'02'		;auto-inc (shift-cursor)
	call	LCDEMODE
	return
;*-----------------------------------------------------------*
LCDCLEAR
	movlw	h'01'
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDHOME
	movlw	h'02'
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDEMODE			;LCD ENTRY mode
	andlw	h'03'		;strip upper bits
	iorlw	h'04'		;function set
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDDMODE			;LCD DISPLAY mode
	andlw	h'07'		;strip upper bits
	iorlw	h'08'		;function set
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDSCGA				;sets the cgram address
	andlw	h'3f'		;strip upper bits
	iorlw	h'40'		;function set
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDSDDA				;sets the ddram address
	iorlw	h'80'		;function set
	call	LCDPUTCMD
	return
;*-----------------------------------------------------------*
LCDPUTCHAR
	movwf	LCD_TEMP	;char to send is in w
	call	LCDBUSY		;wait for LCD to be ready
	bcf	LCD_CTRL,LCD_RW	;set LCD in read mode
	bsf	LCD_CTRL,LCD_RS	;set LCD in data mode
	bsf	LCD_CTRL,LCD_E	;LCD E-line high
	movf	LCD_TEMP,W
	movwf	LCD_DATA	;send data to LCD
	bcf	LCD_CTRL,LCD_E	;LCD E-line low
	return
;*-----------------------------------------------------------*
LCDPUTCMD
	movwf	LCD_TEMP	;command to send is in w
	call	LCDBUSY		;wait for LCD
	bcf	LCD_CTRL,LCD_RW	;set LCD in read mode
	BCF	LCD_CTRL,LCD_RS	;set LCD in command mode
	bsf	LCD_CTRL,LCD_E	;LCD E-line high
	movf	LCD_TEMP,W	
	movwf	LCD_DATA	;send data to LCD
	BCF	LCD_CTRL,LCD_E	;LCD E-line low
	return
;*-----------------------------------------------------------*
LCDBUSY
	bsf	STATUS,5	;page 1
	movlw	h'ff'
	tris	PORTB		;port b as input
	bcf	STATUS,5	;page 0
	bcf	LCD_CTRL,LCD_RS	;LCD for command mode
	bsf	LCD_CTRL,LCD_RW	;setup to read busy flag
	bsf	LCD_CTRL,LCD_E	;LCD e-line high
	movf	LCD_DATA,W	;read busy flag + DDram address
	bcf	LCD_CTRL,LCD_E	;LCD e-line low
	andlw	h'80'		;check busy,high = busy
	btfss	STATUS,2
	goto 	LCDBUSY
;*-----------------------------------------------------------*
LCDNOTBUSY
	bcf	LCD_CTRL,LCD_RW
	bsf	STATUS,5	;page 1
	movlw	00
	tris	PORTB		;port B for output
	bcf	STATUS,5	;select page 0
	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-* Time Delay Subroutines *-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

DELAY500	movlw	d'165'
		movwf	DELAY
DELAY500_LOOP	decfsz	DELAY,F
		goto	DELAY500_LOOP
DELAY500_END	return

X_DELAY500		movwf	X_DELAY
X_DELAY500_LOOP	call	DELAY500
		decfsz	X_DELAY,F
		goto	X_DELAY500_LOOP
X_DELAY500_END	return



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-**-*-*-*-*-* Decrement subroutine *-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;The value to decremented be should be stored in MINS100-MINS
;if the value has reached 000 then the DECREMENT_UPDATE bit 
;will be set (in CONTROL2)

DECREMENTMINS
	movfw	MINS		;IF MINS # 0 THEN
	addlw	00		;
	bz	DECREMENTMINS10	;   	decrement MINS	
	decf	MINS		;
	bcf	CONTROL2,DECREMENT_UPDATE; clear DECREMENT_UPDATE

;*** Check if counter has reached 000

	movfw	MINS
	addlw	00
	bz	CHECKMINS10
	goto	NOTALLZEROS
CHECKMINS10
	movfw	MINS10
	addlw	00
	bz	CHECKMINS100
	goto	NOTALLZEROS
CHECKMINS100
	movfw	MINS100
	addlw	00
	bz	DECREMENTUPDATE	; IF 000 THEN DECUP (FIX 000 PROB)
NOTALLZEROS
	return			;	

DECREMENTMINS10
	movfw	MINS10		;ELSIF MINS10 # 0 THEN
	addlw	00		;
	bz	DECREMENTMINS100;	
	decf	MINS10		;   	decrement MINS10	
	movlw	09		;	
	movwf	MINS		;	MINS = 9
	bcf	CONTROL2,DECREMENT_UPDATE
	return			;	clear DECREMENT_UPDATE
DECREMENTMINS100
	movfw	MINS100		;ELSIF MINS100 # 0 THEN
	addlw	00		;
	bz	DECREMENTUPDATE	;	
	decf	MINS100		;   	decrement MINS100	
	movlw	09		;	
	movwf	MINS		;	MINS = 9
	movwf	MINS10		;	MINS10 = 9
	bcf	CONTROL2,DECREMENT_UPDATE
	return			;	clear DECREMENT_UPDATE
DECREMENTUPDATE
	bsf	CONTROL2,DECREMENT_UPDATE
	return			;ELSE	set DECREMENT_UPDATE



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-**-*-*-*-*-*-* GreEqu subroutine *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

;Use These registers in this manner for a check
;HRS10GRE	>= HRS10	?
;HRSGRE   	>= HRS		?
;MINS10GRE	>= MINS10	?
;MINSGRE	>= MINS		?

;If the temp registers are greater than the GRE registers then
;the GR bit in CONTROL2 will be set, if equal then the EQ bit
;will be set... if not then both bits will be cleared

GREATERHRS10
	movfw	HRS10GRE	;IF HRS10GRE > HRS10 THEN
	subwf	HRS10,0		;
	bc	EQUALHRS10	;
	bsf	CONTROL2,GR	;	set GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return			;
EQUALHRS10
	movfw	HRS10GRE	;IF HRS10GRE #= HRS10 THEN
	subwf	HRS10		;
	bz	GREATERHRS	;
	bcf	CONTROL2,GR	;	clear GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return
GREATERHRS
	movfw	HRSGRE		;ELSIF HRSGRE > HRS THEN
	subwf	HRS,0		;
	bc	EQUALHRS	;
	bsf	CONTROL2,GR	;	set GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return			;
EQUALHRS
	movfw	HRSGRE		;IF HRSGRE #= HRS THEN
	subwf	HRS		;
	bz	GREATERMINS10	;
	bcf	CONTROL2,GR	;	clear GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return	
GREATERMINS10
	movfw	MINS10GRE	;ELSIF MINS10GRE > MINS10 THEN
	subwf	MINS10,0	;
	bc	EQUALMINS10	;
	bsf	CONTROL2,GR	;	set GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return			;
EQUALMINS10
	movfw	MINS10GRE	;IF MINS10GRE #= MINS10 THEN
	subwf	MINS10		;
	bz	GREATERMINS	;
	bcf	CONTROL2,GR	;	clear GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return
GREATERMINS
	movfw	MINSGRE		;ELSIF MINSGRE > MINS THEN
	subwf	MINS,0		;
	bc	EQUALMINS	;
	bsf	CONTROL2,GR	;	set GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return			;
EQUALMINS
	movfw	MINSGRE		;IF MINSGRE #= MINS THEN
	subwf	MINS		;
	bz	EQUAL		;
	bcf	CONTROL2,GR	;	clear GR bit
	bcf	CONTROL2,EQ	;	clear EQ bit
	return
EQUAL
	bsf	CONTROL2,EQ	;ELSE IF TEMP = GR
	bcf	CONTROL2,GR	;	set EQ bit
	return			;	clear GR bit



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-**-*-*-*-*-*-* Timer1 subroutine *-*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

;Store values in these registers
;OFFTIME_HRS10	
;OFFTIME_MINS10		
;OFFTIME_MINS	
;OFFTIME_HRS	

;ONTIME_HRS10	
;ONTIME_MINS10	
;ONTIME_MINS	
;ONTIME_HRS	
;If the sub. turns on the LIGHT then UPDATE is set, if 
;turning off then TURNON (in CONTROL2) is cleared

TIMER1TEST1	
	movfw	OFFTIME_HRS10
	movwf	HRS10GRE
	movfw	OFFTIME_HRS
	movwf	HRSGRE
	movfw	OFFTIME_MINS10
	movwf	MINS10GRE
	movfw	OFFTIME_MINS
	movwf	MINSGRE

	movfw	ONTIME_HRS10
	movwf	HRS10
	movfw	ONTIME_HRS
	movwf	HRS
	movfw	ONTIME_MINS10
	movwf	MINS10
	movfw	ONTIME_MINS
	movwf	MINS

	call	GREATERHRS10	;IF OFFTIME >= ONTIME

	btfss	CONTROL2,EQ	;
	goto	TIMER1TEST2	;	IF OFFTIME = ONTIME
	bcf	CONTROL2,TURNON	;		TURN OFF
	return			;		return		
TIMER1TEST2				
	btfss	CONTROL2,GR	;(jump to ELSE if GR = 0)
	goto	TIMER1TEST3	;
	
	movfw	TIME_10HRS
	movwf	HRS10GRE
	movfw	TIME_HRS
	movwf	HRSGRE
	movfw	TIME_10MINS
	movwf	MINS10GRE
	movfw	TIME_MINS
	movwf	MINSGRE

	movfw	ONTIME_HRS10
	movwf	HRS10
	movfw	ONTIME_HRS
	movwf	HRS
	movfw	ONTIME_MINS10
	movwf	MINS10
	movfw	ONTIME_MINS
	movwf	MINS

	call	GREATERHRS10	;	IF (TIME >= ONTIME) & (OFFTIME > TIME)

	btfss	CONTROL2,GR	;	(test the GR bit)
	goto	TIMER1TEST2A	;
	goto	TIMER1TEST2B	;	
TIMER1TEST2A
	btfss	CONTROL2,EQ	;	(test the EQ bit)
	goto	TIMER1TEST2OFF	;	(jump to ELSE)
TIMER1TEST2B	
	movfw	OFFTIME_HRS10
	movwf	HRS10GRE
	movfw	OFFTIME_HRS
	movwf	HRSGRE
	movfw	OFFTIME_MINS10
	movwf	MINS10GRE
	movfw	OFFTIME_MINS
	movwf	MINSGRE

	movfw	TIME_10HRS
	movwf	HRS10
	movfw	TIME_HRS
	movwf	HRS
	movfw	TIME_10MINS
	movwf	MINS10
	movfw	TIME_MINS
	movwf	MINS

	call	GREATERHRS10	;	(& (OFFTIME > TIME))

	btfss	CONTROL2,GR	;	(test GR bit)
	goto	TIMER1TEST2OFF	;	(jump to ELSE)
	bsf	CONTROL2,TURNON	;		TURN ON!
	return
TIMER1TEST2OFF
	bcf	CONTROL2,TURNON	;	ELSE	TURN OFF!
	return		
TIMER1TEST3
	movfw	TIME_10HRS
	movwf	HRS10GRE
	movfw	TIME_HRS
	movwf	HRSGRE
	movfw	TIME_10MINS
	movwf	MINS10GRE
	movfw	TIME_MINS
	movwf	MINSGRE

	movfw	ONTIME_HRS10
	movwf	HRS10
	movfw	ONTIME_HRS
	movwf	HRS
	movfw	ONTIME_MINS10
	movwf	MINS10
	movfw	ONTIME_MINS
	movwf	MINS

	call	GREATERHRS10	;ELSIF TIME >= ONTIME

	btfss	CONTROL2,GR	;	(test the GR bit)
	goto	TIMER1TEST3A	;
	goto	TIMER1TEST3B	;	
TIMER1TEST3A
	btfss	CONTROL2,EQ	;	(test the EQ bit)
	goto	TIMER1TEST4	;	(jump to NEXTiF)
TIMER1TEST3B
	bsf	CONTROL2,TURNON	;	TURNON!
	return			;	return
TIMER1TEST4
	
	movfw	OFFTIME_HRS10
	movwf	HRS10GRE
	movfw	OFFTIME_HRS
	movwf	HRSGRE
	movfw	OFFTIME_MINS10
	movwf	MINS10GRE
	movfw	OFFTIME_MINS
	movwf	MINSGRE

	movfw	TIME_10HRS
	movwf	HRS10
	movfw	TIME_HRS
	movwf	HRS
	movfw	TIME_10MINS
	movwf	MINS10
	movfw	TIME_MINS
	movwf	MINS

	call	GREATERHRS10	;IF OFFTIME > TIME

	btfss	CONTROL2,GR	;	(test GR bit)
	goto	TIMER1TEST4OFF	;	(jump to ELSE)
	bsf	CONTROL2,TURNON	;	TURN ON!
	return
TIMER1TEST4OFF
	bcf	CONTROL2,TURNON	;ELSE TURN OFF!
	return	



;		   -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		*-*-		           PAGE 1			  *-*-
;		*-*		    	   ------			   -*-
;		 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
;		   -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-



;****************************
;*     Interrupt Vector     *
;****************************

	ORG	h'804'

	movwf	TEMP_W			;preserve W reg(in b1 or 0)
	swapf	STATUS,0		;preserve 0 flag
	movwf	TEMP_STATUS		;save the status reg

	bcf	STATUS,5		;set to bank 0

	incf	HALFSECONDS		;increment time
	bcf	PIR1,0			;clear interrupt flag
	movlw	h'0b'
	movwf	TMR1H
	movlw	h'a4'
	movwf	TMR1L			;delay to Timer

	swapf	TEMP_STATUS,0		;restore status reg
	movwf	STATUS

	swapf	TEMP_W			;restore W reg without
					;changing STATUS bits
	swapf	TEMP_W,0		;(double swap)

	retfie



;****************************
;*    Start of main code    *
;****************************

	ORG	900			;set to PAGE 1
MAIN
	movlw	h'00'
	subwf	PAGENUM,0
	bz	PAGE0SETUP
	movlw	h'01'
	subwf	PAGENUM,0
	bz	PAGE1SETUP
	movlw	h'02'
	subwf	PAGENUM,0
	bz	PAGE2SETUP
	movlw	h'03'
	subwf	PAGENUM,0
	bz	PAGE3SETUP
	movlw	h'04'
	subwf	PAGENUM,0
	bz	PAGE4SETUP
	movlw	h'05'
	subwf	PAGENUM,0
	bz	PAGE5SETUP
	movlw	h'06'
	subwf	PAGENUM,0
	bz	PAGE6SETUP
	movlw	h'07'
	subwf	PAGENUM,0
	bz	PAGE7SETUP
	movlw	h'08'
	subwf	PAGENUM,0
	bz	PAGE8SETUP
	movlw	h'09'
	subwf	PAGENUM,0
	bz	PAGE9SETUP
	movlw	h'0a'
	subwf	PAGENUM,0
	bz	PAGE10SETUP
	movlw	h'0b'
	subwf	PAGENUM,0
	bz	PAGE11SETUP
	goto    PAGE12SETUP
;*-----------------------------------------------------------*



PAGE0SETUP
	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	NOCLEAR			;

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	H'05'			;set cursor pos.
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT
NOCLEAR
	movfw	TIME_MINS		;	swap times 
	movwf	MINS		
	movfw	TIME_10MINS
	movwf	MINS10	
	movfw	TIME_HRS
	movwf	HRS
	movfw	TIME_10HRS
	movwf	HRS10
	movfw	TIME_10SECS
	movwf	SECS10
	movfw	TIME_SECS
	movwf	SECS

CHECKP0UPDATE
	bcf	PCLATH,3		;select PROM page 0
	call	PAGE0
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR
	goto	AFTERP0UPDATE		;

	movlw	d'3'
	movwf	CURSORSTART

	bcf	PCLATH,3		;select PROM page 0
	call  	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call  	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	movlw	b'00000110'		;cursor on
	call  	LCDDMODE
	bsf	PCLATH,3		;select PROM page 1

AFTERP0UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE1SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP1UPDATE		;
	movfw	LIGHT1_ON_MINS		;	swap times 
	movwf	MINS		
	movfw	LIGHT1_ON_10MINS
	movwf	MINS10	
	movfw	LIGHT1_ON_HRS
	movwf	HRS
	movfw	LIGHT1_ON_10HRS
	movwf	HRS10

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1
	
	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP1UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE1
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR
	goto	AFTERP1UPDATE		;

	movfw	MINS			;	swap times
	movwf	LIGHT1_ON_MINS		 
	movfw	MINS10		
	movwf	LIGHT1_ON_10MINS
	movfw	HRS
	movwf	LIGHT1_ON_HRS
	movfw	HRS10
	movwf	LIGHT1_ON_10HRS

	movlw	d'3'
	movwf	CURSORSTART

	bcf	PCLATH,3		;select PROM page 0
	call  	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

AFTERP1UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE2SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP2UPDATE		;
	movfw	LIGHT1_OFF_MINS		;	swap times 
	movwf	MINS		
	movfw	LIGHT1_OFF_10MINS
	movwf	MINS10	
	movfw	LIGHT1_OFF_HRS
	movwf	HRS	
	movfw	LIGHT1_OFF_10HRS
	movwf	HRS10

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP2UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE2
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP2UPDATE		;

	movfw	MINS			;	swap times
	movwf	LIGHT1_OFF_MINS		 
	movfw	MINS10		
	movwf	LIGHT1_OFF_10MINS
	movfw	HRS
	movwf	LIGHT1_OFF_HRS
	movfw	HRS10	
	movwf	LIGHT1_OFF_10HRS

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

AFTERP2UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE3SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP3UPDATE		;
	movfw	TIMER_ON_MINS		;	swap times 
	movwf	MINS		
	movfw	TIMER_ON_10MINS
	movwf	MINS10	
	movfw	TIMER_ON_HRS
	movwf	HRS	
	movfw	TIMER_ON_10HRS
	movwf	HRS10

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP3UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE3
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP3UPDATE		;

	movfw	MINS			;	swap times
	movwf	TIMER_ON_MINS		 
	movfw	MINS10		
	movwf	TIMER_ON_10MINS
	movfw	HRS
	movwf	TIMER_ON_HRS
	movfw	HRS10	
	movwf	TIMER_ON_10HRS

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1
AFTERP3UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE4SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP4UPDATE		;
	movfw	TIMER_OFF_MINS		;	swap times 
	movwf	MINS		
	movfw	TIMER_OFF_10MINS
	movwf	MINS10	
	movfw	TIMER_OFF_HRS
	movwf	HRS	
	movfw	TIMER_OFF_10HRS
	movwf	HRS10

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP4UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE4
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP4UPDATE		;

	movfw	MINS			;	swap times
	movwf	TIMER_OFF_MINS		 
	movfw	MINS10		
	movwf	TIMER_OFF_10MINS
	movfw	HRS
	movwf	TIMER_OFF_HRS
	movfw	HRS10	
	movwf	TIMER_OFF_10HRS

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1
AFTERP4UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE5SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP5UPDATE		;
	bsf	CONTROL2,PUMP_ON_BIT;	for mins,mins10
	movfw	PUMP_ON_MINS		;	swap times 
	movwf	MINS		
	movfw	PUMP_ON_10MINS
	movwf	MINS10	
	movfw	PUMP_ON_100MINS
	movwf	MINS100

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	h'04'
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP5UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE5
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR
	goto	AFTERP5UPDATE		;
	bcf	CONTROL2,PUMP_ON_BIT;	for mins,mins10

	btfss   CONTROL2,CHANGEFLAG   	;If a change has not occured then
	goto	NoChangePumpOn		;dont change the values of decrementers and timers	

	movfw	MINS			;	swap times and decrementers
	movwf	PUMP_ON_MINS
				 
	bsf	STATUS,5		
	movwf	PUMP_ON_MINS_DEC
	bcf 	STATUS,5

	movfw	MINS10		
	movwf	PUMP_ON_10MINS

	bsf	STATUS,5		
	movwf	PUMP_ON_10MINS_DEC
	bcf 	STATUS,5

	movfw	MINS100
	movwf	PUMP_ON_100MINS

	bsf	STATUS,5		
	movwf	PUMP_ON_100MINS_DEC
	bcf 	STATUS,5

NoChangePumpOn

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1
AFTERP5UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE6SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP6UPDATE		;
	movfw	PUMP_OFF_MINS		;	swap times 
	movwf	MINS		
	movfw	PUMP_OFF_10MINS
	movwf	MINS10	
	movfw	PUMP_OFF_100MINS
	movwf	MINS100

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	h'04'
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP6UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE6
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR
	goto	AFTERP6UPDATE		;

	btfss   CONTROL2,CHANGEFLAG   	;If a change has not occured then
	goto	NoChangePumpOff		;dont change the values of decrementers and timers	

	movfw	MINS			;	swap times
	movwf	PUMP_OFF_MINS		 

	bsf	STATUS,5		
	movwf	PUMP_OFF_MINS_DEC
	bcf 	STATUS,5

	movfw	MINS10		
	movwf	PUMP_OFF_10MINS

	bsf	STATUS,5		
	movwf	PUMP_OFF_10MINS_DEC
	bcf 	STATUS,5

	movfw	MINS100
	movwf	PUMP_OFF_100MINS

	bsf	STATUS,5		
	movwf	PUMP_OFF_100MINS_DEC
	bcf 	STATUS,5

NoChangePumpOff

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1
AFTERP6UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE7SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP7UPDATE		;
					;	start add of
	bsf	STATUS,5		;(b1)	CO2...HRS10

	movfw	CO2_ON_100MINS
	bcf	STATUS,5
	movwf	MINS100
	bsf	STATUS,5
	movfw	CO2_ON_10MINS
	bcf	STATUS,5
	movwf	MINS10
	bsf	STATUS,5
	movfw	CO2_ON_MINS
	bcf	STATUS,5
	movwf	MINS

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	h'04'
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP7UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE7
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP7UPDATE		;


	btfss   CONTROL2,CHANGEFLAG   	;If a change has not occured then
	goto	NoChangePage7		;dont change the values of decrementers and timers	

	bcf	STATUS,5		;(b0)	start add of
					;	CO2...HRS10
	movfw	MINS100
	bsf	STATUS,5
	movwf	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC
	bcf	STATUS,5
	movfw	MINS10
	bsf	STATUS,5
	movwf	CO2_ON_10MINS
	movwf	CO2_ON_10MINS_DEC
	bcf	STATUS,5
	movfw	MINS
	bsf	STATUS,5
	movwf	CO2_ON_MINS
	movwf	CO2_ON_MINS_DEC
	bcf	STATUS,5		;(b0)

NoChangePage7

	bcf	PCLATH,3		;select PROM page 0	
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1
AFTERP7UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE8SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP8UPDATE		;

	bsf	STATUS,5		;(b1)	CO2...HRS10

	movfw	GAS_ON_100MINS
	bcf	STATUS,5
	movwf	MINS100
	bsf	STATUS,5
	movfw	GAS_ON_10MINS
	bcf	STATUS,5
	movwf	MINS10
	bsf	STATUS,5
	movfw	GAS_ON_MINS
	bcf	STATUS,5
	movwf	MINS

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	h'04'
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP8UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE8
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP8UPDATE		;

	btfss   CONTROL2,CHANGEFLAG   	;If a change has not occured then
	goto	NoChangePage8		;dont change the values of decrementers and timers	

	bcf	STATUS,5		;(b0)	start add of
					;	CO2...HRS10
	movfw	MINS100
	bsf	STATUS,5
	movwf	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC
	bcf	STATUS,5
	movfw	MINS10
	bsf	STATUS,5
	movwf	GAS_ON_10MINS
	movwf	GAS_ON_10MINS_DEC
	bcf	STATUS,5
	movfw	MINS
	bsf	STATUS,5
	movwf	GAS_ON_MINS
	movwf	GAS_ON_MINS_DEC
	bcf	STATUS,5		;(b0)	

NoChangePage8

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

AFTERP8UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE9SETUP

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP9UPDATE		;

	bsf	STATUS,5		;(b1)	CO2...HRS10
	movfw	CO2_HOLD_100MINS
	bcf	STATUS,5
	movwf	MINS100
	bsf	STATUS,5
	movfw	CO2_HOLD_10MINS
	bcf	STATUS,5
	movwf	MINS10
	bsf	STATUS,5
	movfw	CO2_HOLD_MINS
	bcf	STATUS,5
	movwf	MINS

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

	movlw	h'04'
	movwf	CURSORPOSITION

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP9UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE9
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is clear
	goto	AFTERP9UPDATE		;

	btfss   CONTROL2,CHANGEFLAG   	;If a change has not occured then
	goto	NoChangePage9		;dont change the values of decrementers and timers	

	bcf	STATUS,5		;(b1)	start add of
					;	CO2...HRS10
	movfw	MINS100
	bsf	STATUS,5
	movwf	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC
	bcf	STATUS,5
	movfw	MINS10
	bsf	STATUS,5
	movwf	CO2_HOLD_10MINS
	movwf	CO2_HOLD_10MINS_DEC
	bcf	STATUS,5
	movfw	MINS
	bsf	STATUS,5
	movwf	CO2_HOLD_MINS
	movwf	CO2_HOLD_MINS_DEC
	bcf	STATUS,5		;(b0)
	
NoChangePage9

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1


AFTERP9UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE10SETUP	;set time?

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP10UPDATE		;
	movlw	d'00'			;	TEMP_OPTION = 0
	movwf	TEMP_OPTION
	movwf	CURSORPOSITION		;	*
	incf	CURSORPOSITION		;	* fix glitch
	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

	bcf	PCLATH,3		;select PROM page 0
	call	LCDBUSY
	bsf	PCLATH,3		;select PROM page 1

	bcf	PCLATH,3		;select PROM page 0
	call	LCDCLEAR
	bsf	PCLATH,3		;select PROM page 1

CHECKP10UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE10
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR

	goto	AFTERP10UPDATE		;	inc page etc.

	bcf	PCLATH,3		;select PROM page 0
	call	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

AFTERP10UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE11SETUP

	movlw	00
	subwf	TEMP_OPTION,0	;IF TEMP_OPTION = 0 
	bz	NOISIT		;	GOTO
YESISIT
	incf	PAGENUM		;PAGENUM = 12
	goto	OUTPUTROUTINES
NOISIT
	movlw	00
	movwf	PAGENUM		;PAGENUM is ZERO
	goto 	OUTPUTROUTINES
;*-----------------------------------------------------------*



PAGE12SETUP	;*** Set time

	btfsc	CONTROL1,PAGEBIT	;IF CONTROL1 is clear
	goto	CHECKP12UPDATE		;
	
	movfw	TIME_MINS		;	swap times 
	movwf	MINS		
	movfw	TIME_10MINS
	movwf	MINS10	
	movfw	TIME_HRS
	movwf	HRS	
	movfw	TIME_10HRS
	movwf	HRS10
	movfw	TIME_SECS
	movwf	SECS
	movfw	TIME_10SECS
	movwf	SECS10

	bsf	CONTROL1,PAGEBIT	;	set PAGEBIT

CHECKP12UPDATE

	bcf	PCLATH,3		;select PROM page 0
	call	PAGE12
	bsf	PCLATH,3		;select PROM page 1

	btfss	CONTROL1,UPDATE		;IF CONTROL1 is CLEAR
	goto	AFTERP12UPDATE		;

	movfw	MINS			;	swap times
	movwf	TIME_MINS		 
	movfw	MINS10		
	movwf	TIME_10MINS
	movfw	HRS
	movwf	TIME_HRS
	movfw	HRS10	
	movwf	TIME_10HRS
	movfw	SECS
	movwf	TIME_SECS
	movfw	SECS10
	movwf	TIME_10SECS

	bcf	PCLATH,3		;select PROM page 0
	call  	NEXTPAGESETTINGS
	bsf	PCLATH,3		;select PROM page 1

	movlw	00
	movwf	PAGENUM			;set next page to ZERO

AFTERP12UPDATE

	goto	OUTPUTROUTINES
;*-----------------------------------------------------------*



;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-* Clock and Decrementers *-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

OUTPUTROUTINES



;****************************
;*       Update clock       *
;*       ------------       *
;* Check HALFSECONDS and    *
;* update time if NEC.	    *
;****************************

	bcf	CONTROL2,MINUTEFLAG	;Clear MinuteFlag
					;Cleared because the flag should only be set if a min.
					;has just ticked over
	movlw	h'02'
	subwf	HALFSECONDS,0		;IF HALFSECONDS = 2 THEN
	bz	SECOND			;	goto SECOND	
	goto	AFTERSECOND	
SECOND
	movfw	TIME_MINS		;	swap times 
	movwf	IMINS		
	movfw	TIME_10MINS
	movwf	IMINS10	
	movfw	TIME_HRS
	movwf	IHRS
	movfw	TIME_10HRS
	movwf	IHRS10
	movfw	TIME_10SECS
	movwf	ISECS10
	movfw	TIME_SECS
	movwf	ISECS

	bcf	PCLATH,3		;select PROM page 0
	call  	CHECKSECS		;Increment time (Setting MINUTEFLAG if nec.)
	bsf	PCLATH,3		;select PROM page 1

	movfw	IMINS
	movwf	TIME_MINS		;	swap times 
	movfw	IMINS10		
	movwf	TIME_10MINS
	movfw	IHRS	
	movwf	TIME_HRS
	movfw	IHRS10
	movwf	TIME_10HRS
	movfw	ISECS10
	movwf	TIME_10SECS
	movfw	ISECS
	movwf	TIME_SECS
	
	movlw	00		;HALFSECONDS = 0
	movwf	HALFSECONDS



;				****************************
;				* 	Decrementers       *
;				*      	------------       *
;				* Ports are turned on and  *
;				* Off here, times are      *
;				* checked and counters are *
;				* decremented.             *
;				****************************	
	
	bcf	STATUS,5		;BANK 0

;*** Move SECS - TEMPHRS10 to temporary registers ***

	movfw	SECS
	movwf	TEMPSECS
	movfw	SECS10
	movwf	TEMPSECS10
	movfw	MINS
	movwf	TEMPMINS
	movfw	MINS10
	movwf	TEMPMINS10
	movfw	MINS100
	movwf	TEMPMINS100
	movfw	HRS
	movwf	TEMPHRS
	movfw	HRS10
	movwf	TEMPHRS10



;*** Turn Light 1 on/off

	movfw	LIGHT1_OFF_MINS		 
	movwf	OFFTIME_MINS		
	movfw	LIGHT1_OFF_10MINS
	movwf	OFFTIME_MINS10	
	movfw	LIGHT1_OFF_HRS
	movwf	OFFTIME_HRS	
	movfw	LIGHT1_OFF_10HRS
	movwf	OFFTIME_HRS10	

	movfw	LIGHT1_ON_MINS		 
	movwf	ONTIME_MINS		
	movfw	LIGHT1_ON_10MINS
	movwf	ONTIME_MINS10	
	movfw	LIGHT1_ON_HRS
	movwf	ONTIME_HRS	
	movfw	LIGHT1_ON_10HRS
	movwf	ONTIME_HRS10	

	bCf	PCLATH,3		;select PROM page 0
	CALL 	TIMER1TEST1
	bSf	PCLATH,3		;select PROM page 1

	BTFSC	CONTROL2,TURNON
	GOTO	TurnOnLight1
	GOTO	TurnOffLight1
TurnOnLight1
	BSF	PORTC,6			;TURN ON LIGHT 1 (BIT 6)
	GOTO	AfterLightCheck
TurnOffLight1
	BCF	PORTC,6			;TURN OFF LIGHT 1 (BIT 6)	
AfterLightCheck



;*** Turn Timer on/off

	movfw	TIMER_OFF_MINS		 
	movwf	OFFTIME_MINS		
	movfw	TIMER_OFF_10MINS
	movwf	OFFTIME_MINS10	
	movfw	TIMER_OFF_HRS
	movwf	OFFTIME_HRS	
	movfw	TIMER_OFF_10HRS
	movwf	OFFTIME_HRS10	

	movfw	TIMER_ON_MINS		 
	movwf	ONTIME_MINS		
	movfw	TIMER_ON_10MINS
	movwf	ONTIME_MINS10	
	movfw	TIMER_ON_HRS
	movwf	ONTIME_HRS	
	movfw	TIMER_ON_10HRS
	movwf	ONTIME_HRS10	

	bCf	PCLATH,3		;select PROM page 0
	CALL 	TIMER1TEST1
	bSf	PCLATH,3		;select PROM page 1

	BTFSC	CONTROL2,TURNON
	GOTO	TurnOnTIMER
	GOTO	TurnOffTIMER
TurnOnTIMER
	BSF	PORTA,5			;TURN ON LIGHT 2 (BIT 7)
	GOTO	AfterTIMERCheck
TurnOffTIMER
	BCF	PORTA,5			;TURN OFF LIGHT 2 (BIT 7)	
AfterTIMERCheck

;*---------------------*
;*   Initialise ports  *
;*   ----------------  *
;* If there are things *
;* To be turned on     *
;* (b4 the min.) then  *
;* do so.	       *
;*---------------------*

	bcf 	STATUS,5
	btfss	PORTC,6
	goto	UpdateEveryMinute

	bsf	STATUS,5
	Btfss	CO2_STAGE,CO2OFF
	goto	UpdateEveryMinute

	bcf 	STATUS,5

	bsf	GAS_PORT,FAN_PIN	;Turn on FAN_BIT
	bcf	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,ACPIN
	
	bsf	STATUS,5
	
	bsf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BcF	CO2_STAGE,SPOOLING
	BcF	CO2_STAGE,CO2OFF
	


;*---------------------*
;* update every minute *
;*---------------------*	
UpdateEveryMinute
	bcf	STATUS,5
	BTFSS	CONTROL2,MINUTEFLAG
	GOTO	NotMinute

EveryMinute

;*** turn pump on/off (ONLY EVERY MINUTE)



;*---------------------*
;*     Pump Phase      *
;*     ----------      *
;*         off	       *
;*---------------------*

	bsf	STATUS,5
	BTFSC	PUMP_STAGE,0		;check pump stage
	goto	DecrementPumpOn

DecrementPumpOff

	bsf	STATUS,5		;copy to MINS - MINS100
	movfw	PUMP_OFF_100MINS_DEC
	bcf 	STATUS,5
	movwf	MINS100

	bsf	STATUS,5		
	movfw	PUMP_OFF_10MINS_DEC
	bcf 	STATUS,5
	movwf	MINS10

	bsf	STATUS,5		
	movfw	PUMP_OFF_MINS_DEC
	bcf 	STATUS,5
	movwf	MINS


	bCf	PCLATH,3		;select PROM page 0
	CALL 	DECREMENTMINS
	bSf	PCLATH,3		;select PROM page 1


	bcf 	STATUS,5		;copy MINS100 back
	movfw	MINS100
	bsf	STATUS,5
	movwf	PUMP_OFF_100MINS_DEC

	bcf 	STATUS,5		;copy MINS10 back
	movfw	MINS10
	bsf	STATUS,5
	movwf	PUMP_OFF_10MINS_DEC

	bcf 	STATUS,5		;copy MINS back
	movfw	MINS
	bsf	STATUS,5
	movwf	PUMP_OFF_MINS_DEC


	bcf 	STATUS,5
	BTFSC	CONTROL2,DECREMENT_UPDATE	
	GOTO	ChangePOn

KeepPOff

	bcf	PUMP_PORT,PUMP_BIT	;Turn off PUMP_BIT
	GOTO	CO2Check

ChangePOn

;*** check for 000 on value (ifso, bypass) **************

	movfw	PUMP_ON_MINS
	addlw	00
	bz	PUMPonCHECKMINS10
	goto	PUMPonNOTALLZEROS
PUMPonCHECKMINS10
	movfw	PUMP_ON_10MINS
	addlw	00
	bz	PUMPonCHECKMINS100
	goto	PUMPonNOTALLZEROS
PUMPonCHECKMINS100
	movfw	PUMP_ON_100MINS
	addlw	00
	bz	BypassTurnOnPump	;bypass pump stage
PUMPonNOTALLZEROS
	GOTO	PumpOn
BypassTurnOnPump
	;keep off PUMP_BIT (Pump stage remains off)
	GOTO	ResetPumpOffValues

;*** end check *******************************************

PumpOn
	bSf	PUMP_PORT,PUMP_BIT	;Turn on PUMP_BIT
	bsf	STATUS,5
	bsf	PUMP_STAGE,0

ResetPumpOffValues				;Swap times

	bcf 	STATUS,5
	movfw	PUMP_OFF_MINS		 
	bsf	STATUS,5		
	movwf	PUMP_OFF_MINS_DEC
	bcf 	STATUS,5

	bcf 	STATUS,5		
	movfw	PUMP_OFF_10MINS
	bsf	STATUS,5		
	movwf	PUMP_OFF_10MINS_DEC
	bcf 	STATUS,5

	bcf 	STATUS,5
	movfw	PUMP_OFF_100MINS
	bsf	STATUS,5		
	movwf	PUMP_OFF_100MINS_DEC
	bcf 	STATUS,5

	GOTO	CO2Check	



;*---------------------*
;*     Pump Phase      *
;*     ----------      *
;*         on	       *
;*---------------------*

DecrementPumpOn

	bsf	STATUS,5		
	movfw	PUMP_ON_100MINS_DEC
	bcf 	STATUS,5
	movwf	MINS100

	bsf	STATUS,5		
	movfw	PUMP_ON_10MINS_DEC
	bcf 	STATUS,5
	movwf	MINS10

	bsf	STATUS,5		
	movfw	PUMP_ON_MINS_DEC
	bcf 	STATUS,5
	movwf	MINS

	bCf	PCLATH,3		;select PROM page 0
	CALL 	DECREMENTMINS
	bSf	PCLATH,3		;select PROM page 1


	bcf 	STATUS,5		;copy MINS100 back
	movfw	MINS100
	bsf	STATUS,5
	movwf	PUMP_ON_100MINS_DEC

	bcf 	STATUS,5		;copy MINS10 back
	movfw	MINS10
	bsf	STATUS,5
	movwf	PUMP_ON_10MINS_DEC

	bcf 	STATUS,5		;copy MINS back
	movfw	MINS
	bsf	STATUS,5
	movwf	PUMP_ON_MINS_DEC

	bcf 	STATUS,5
	BTFSC	CONTROL2,DECREMENT_UPDATE
	GOTO	ChangePOff

KeepPOn

	bsf	PUMP_PORT,PUMP_BIT
	GOTO	CO2Check

ChangePOff

;*** check for 000 on value (ifso, bypass) **************

	movfw	PUMP_OFF_MINS
	addlw	00
	bz	PUMPoffCHECKMINS10
	goto	PUMPoffNOTALLZEROS
PUMPoffCHECKMINS10
	movfw	PUMP_OFF_10MINS
	addlw	00
	bz	PUMPoffCHECKMINS100
	goto	PUMPoffNOTALLZEROS
PUMPoffCHECKMINS100
	movfw	PUMP_OFF_100MINS
	addlw	00
	bz	BypassTurnOffPump	;bypass pump stage
PUMPoffNOTALLZEROS
	GOTO	PumpOff
BypassTurnOffPump
	;keep on PUMP_BIT (Pump stage remains on)
	GOTO	ResetPumpOnValues

;*** end check *******************************************

PumpOff
	bcf	PUMP_PORT,PUMP_BIT	;Turn off PUMP_BIT
	bsf	STATUS,5
	bcf	PUMP_STAGE,0
	bcf	STATUS,5
ResetPumpOnValues
				;Swap times
	movfw	PUMP_ON_MINS		 
	bsf	STATUS,5		
	movwf	PUMP_ON_MINS_DEC
	bcf 	STATUS,5

		
	movfw	PUMP_ON_10MINS
	bsf	STATUS,5		
	movwf	PUMP_ON_10MINS_DEC
	bcf 	STATUS,5

	movfw	PUMP_ON_100MINS
	bsf	STATUS,5		
	movwf	PUMP_ON_100MINS_DEC
	bcf 	STATUS,5

	GOTO	CO2Check





;*** CO2 GAS Check
;First check if the light is on (if not then turn off CO2 pins)

CO2Check

	bcf 	STATUS,5
	btfsc	PORTC,6
	goto	SETCO2ON

	bcf	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,FAN_PIN
	bcf	GAS_PORT,ACPIN
	bcf	CONTROL2,LIGHTFLAG	

	;reset decrementers


	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BCF	CO2_STAGE,SPOOLING
	BSF	CO2_STAGE,CO2OFF

	BCF	STATUS,5

	goto	NotMinute

SETCO2ON

	bcf	STATUS,5

	btfss	CONTROL2,LIGHTFLAG
	GOTO	LIGHTFLAGSET
	GOTO	CO2FanCheck

LIGHTFLAGSET
	bCf	STATUS,5
	bSf	CONTROL2,LIGHTFLAG
	bSf	STATUS,5
	BSF	CO2_STAGE,FANSTAGE
	BCF	CO2_STAGE,CO2OFF

;*---------------------*
;*   CO2 Fan Check     *
;*   -------------     *
;*         on	       *
;*---------------------*

CO2FanCheck

	bsf	STATUS,5
	BTFSS	CO2_STAGE,FANSTAGE		;check CO2 stage
	goto	CO2SpoolCheck


;*** check for 000 on value (ifso, bypass) **************
	bsf 	STATUS,5
	movfw	CO2_ON_MINS
	addlw	00
	bz	FANCHECKMINS10
	goto	FANNOTALLZEROS
FANCHECKMINS10
	movfw	CO2_ON_10MINS
	addlw	00
	bz	FANCHECKMINS100
	goto	FANNOTALLZEROS
FANCHECKMINS100
	movfw	CO2_ON_100MINS
	addlw	00
	bz	GOTOCO2CHECK	;bypass FAN stage
FANNOTALLZEROS
	GOTO	CO2FanCheckb
GOTOCO2CHECK
	bcf 	STATUS,5

	bcf	GAS_PORT,FAN_PIN	;Turn off FAN_BIT
	bcf	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,ACPIN
	
	bsf	STATUS,5
	
	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BSF	CO2_STAGE,SPOOLING
	
GOTO	NotMinute		;Give spool a minute

;*** end check *******************************************

CO2FanCheckb
DecrementFan

	bsf	STATUS,5		
	movfw	CO2_ON_100MINS_DEC
	bcf 	STATUS,5
	movwf	MINS100

	bsf	STATUS,5		
	movfw	CO2_ON_10MINS_DEC
	bcf 	STATUS,5
	movwf	MINS10

	bsf	STATUS,5		
	movfw	CO2_ON_MINS_DEC
	bcf 	STATUS,5
	movwf	MINS

	bCf	PCLATH,3		;select PROM page 0
	CALL 	DECREMENTMINS
	bSf	PCLATH,3		;select PROM page 1

	bcf 	STATUS,5		;copy MINS100 back
	movfw	MINS100
	bsf	STATUS,5
	movwf	CO2_ON_100MINS_DEC

	bcf 	STATUS,5		;copy MINS10 back
	movfw	MINS10
	bsf	STATUS,5
	movwf	CO2_ON_10MINS_DEC

	bcf 	STATUS,5		;copy MINS back
	movfw	MINS
	bsf	STATUS,5
	movwf	CO2_ON_MINS_DEC

	bcf 	STATUS,5
	BTFSC	CONTROL2,DECREMENT_UPDATE	
	GOTO	ChangeFan

KeepFan

	bcf	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,ACPIN
	bsf	GAS_PORT,FAN_PIN	;Turn on FAN 

	GOTO	NotMinute

ChangeFan

	bcf	STATUS,5

				
	bcf	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,ACPIN
	bcf	GAS_PORT,FAN_PIN	;Turn off gas

	bsf	STATUS,5
	
	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BSF	CO2_STAGE,SPOOLING
	
	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	bcf 	STATUS,5

	GOTO	NotMinute

;*---------------------*
;*   CO2 Spl Check     *
;*   -------------     *
;*         on	       *
;*---------------------*


CO2SpoolCheck

	bsf	STATUS,5
	BTFSS	CO2_STAGE,SPOOLING		;check co2 stage
	goto	StartCheck



;*** check for 000 on values (ifso, bypass) **************

	bsf 	STATUS,5
	movfw	GAS_ON_MINS
	addlw	00
	bz	GASspoolCHECKMINS10
	goto	GASspoolNOTALLZEROS
GASspoolCHECKMINS10
	movfw	GAS_ON_10MINS
	addlw	00
	bz	GASspoolCHECKMINS100
	goto	GASspoolNOTALLZEROS
GASspoolCHECKMINS100
	movfw	GAS_ON_100MINS
	addlw	00
	bz	GOTOGASspoolCHECK	;bypass GAS stage
GASspoolNOTALLZEROS
	GOTO	CHANGEGASspool
GOTOGASspoolCHECK
	bcf 	STATUS,5

	bcf	GAS_PORT,GAS_PIN	;Turn off GAS_BIT
	bSf	GAS_PORT,ACPIN
	bcf	GAS_PORT,FAN_PIN	;Turn off gas

	bsf 	STATUS,5

	bcf	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,SPOOLING
	BSF	CO2_STAGE,HOLDING		

;********** Now check if the hold cycle is 000 ***********

	bsf 	STATUS,5
	movfw	CO2_HOLD_MINS
	addlw	00
	bz	HOLDspoolCHECKMINS10
	goto	HOLDspoolNOTALLZEROS
HOLDspoolCHECKMINS10
	movfw	CO2_HOLD_10MINS
	addlw	00
	bz	HOLDspoolCHECKMINS100
	goto	HOLDspoolNOTALLZEROS
HOLDspoolCHECKMINS100
	movfw	CO2_HOLD_100MINS
	addlw	00
	bz	GOTOFANspoolCHECK	;bypass CO2_HOLD stage
HOLDspoolNOTALLZEROS
	GOTO	CHANGEHOLDINGspool
GOTOFANspoolCHECK

	bSf 	STATUS,5
	
	bcf	CO2_STAGE,SPOOLING
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	bSf	CO2_STAGE,FANSTAGE

	bcf 	STATUS,5

	bcf	ACPORT,ACPIN
	BCF	GAS_PORT,GAS_PIN
	BSF	GAS_PORT,FAN_PIN

;********** Now check if the fan cycle is 000 ***********

	bsf 	STATUS,5
	movfw	CO2_ON_MINS
	addlw	00
	bz	FANspoolCHECKMINS10
	goto	FANspoolNOTALLZEROS
FANspoolCHECKMINS10
	movfw	CO2_ON_10MINS
	addlw	00
	bz	FANspoolCHECKMINS100
	goto	FANspoolNOTALLZEROS
FANspoolCHECKMINS100
	movfw	CO2_ON_100MINS
	addlw	00
	bz	GOTOCO2spoolCHECK	;bypass FAN stage
FANspoolNOTALLZEROS
	GOTO	CHANGEFANspool
GOTOCO2spoolCHECK
	bcf 	STATUS,5
	
	BCF	GAS_PORT,GAS_PIN
	bcf	GAS_PORT,FAN_PIN	;Turn off FAN_BIT
	bcf	ACPORT,ACPIN

	bsf	STATUS,5

	bcf	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,FANSTAGE
	BSF	CO2_STAGE,SPOOLING

	GOTO	NotMinute		;Give spool a minute

;*** end check *******************************************



CHANGEGASspool

	BSF	STATUS,5

	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,SPOOLING
	BSF	CO2_STAGE,GASSTAGE

	BCF	STATUS,5

	bsf	GAS_PORT,GAS_PIN	
	bcf	GAS_PORT,FAN_PIN	;Turn off FAN_BIT
	bSf	ACPORT,ACPIN

	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	GOTO	NotMinute

CHANGEHOLDINGspool

	BSF	STATUS,5

	BCF	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,SPOOLING
	bcf	CO2_STAGE,FANSTAGE
	BSF	CO2_STAGE,HOLDING

	BCF	STATUS,5

	bCf	GAS_PORT,GAS_PIN
	bCf	GAS_PORT,FAN_PIN
	bSf	ACPORT,ACPIN

	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	GOTO	NotMinute

CHANGEFANspool

	BSF	STATUS,5

	BCF	CO2_STAGE,HOLDING
	BCF	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,SPOOLING
	BSF	CO2_STAGE,FANSTAGE


	BCF	STATUS,5

	bsf	GAS_PORT,FAN_PIN
	BCF	ACPORT,ACPIN
	BCF	GAS_PORT,GAS_PIN

	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC
	
	GOTO	NotMinute




;*---------------------*
;*   CO2 Gas Check     *
;*   -------------     *
;*         on	       *
;*---------------------*

StartCheck

	bsf	STATUS,5
	BTFSS	CO2_STAGE,GASSTAGE		;check CO2 stage
	goto	CO2HoldCheck

DecrementGas

	bsf	STATUS,5		
	movfw	GAS_ON_100MINS_DEC
	bcf 	STATUS,5
	movwf	MINS100

	bsf	STATUS,5		
	movfw	GAS_ON_10MINS_DEC
	bcf 	STATUS,5
	movwf	MINS10

	bsf	STATUS,5		
	movfw	GAS_ON_MINS_DEC
	bcf 	STATUS,5
	movwf	MINS

	bCf	PCLATH,3		;select PROM page 0
	CALL 	DECREMENTMINS
	bSf	PCLATH,3		;select PROM page 1

	bcf 	STATUS,5		;copy MINS100 back
	movfw	MINS100
	bsf	STATUS,5
	movwf	GAS_ON_100MINS_DEC

	bcf 	STATUS,5		;copy MINS10 back
	movfw	MINS10
	bsf	STATUS,5
	movwf	GAS_ON_10MINS_DEC

	bcf 	STATUS,5		;copy MINS back
	movfw	MINS
	bsf	STATUS,5
	movwf	GAS_ON_MINS_DEC

	bcf 	STATUS,5
	BTFSC	CONTROL2,DECREMENT_UPDATE	
	GOTO	ChangeGas

KeepGas

	BCF	STATUS,5

	BSF	ACPORT,ACPIN		;TURN ON AC
	bsf	GAS_PORT,GAS_PIN	;Turn oN gas
	BCF	GAS_PORT,FAN_PIN

	GOTO	NotMinute

ChangeGas

;********** Now check if the hold cycle is 000 ***********

	bsf 	STATUS,5
	movfw	CO2_HOLD_MINS
	addlw	00
	bz	HOLDgasCHECKMINS10
	goto	HOLDgasNOTALLZEROS
HOLDgasCHECKMINS10
	movfw	CO2_HOLD_10MINS
	addlw	00
	bz	HOLDgasCHECKMINS100
	goto	HOLDgasNOTALLZEROS
HOLDgasCHECKMINS100
	movfw	CO2_HOLD_100MINS
	addlw	00
	bz	GOTOFANgasCHECK		;bypass CO2_HOLD stage
HOLDgasNOTALLZEROS
	GOTO	CHANGEHOLDINGgas
GOTOFANgasCHECK

	BSF	STATUS,5

	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,SPOOLING
	bcf	CO2_STAGE,GASSTAGE
	bSf	CO2_STAGE,FANSTAGE

	bcf 	STATUS,5

	bcf	ACPORT,ACPIN
	BCF	GAS_PORT,GAS_PIN
	BSF	GAS_PORT,FAN_PIN

;********** Now check if the fan cycle is 000 ***********

	bsf 	STATUS,5
	movfw	CO2_ON_MINS
	addlw	00
	bz	FANgasCHECKMINS10
	goto	FANgasNOTALLZEROS
FANgasCHECKMINS10
	movfw	CO2_ON_10MINS
	addlw	00
	bz	FANgasCHECKMINS100
	goto	FANgasNOTALLZEROS
FANgasCHECKMINS100
	movfw	CO2_ON_100MINS
	addlw	00
	bz	GOTOCO2gasCHECK	;bypass FAN stage
FANgasNOTALLZEROS
	GOTO	CHANGEFANgas
GOTOCO2gasCHECK
	bcf 	STATUS,5

	bCf	GAS_PORT,FAN_PIN	;Turn off FAN_BIT
	bCf	GAS_PORT,ACPIN
	bCf	GAS_PORT,GAS_PIN

	bsf	STATUS,5

	BCF	CO2_STAGE,HOLDING
	BCF	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,FANSTAGE
	BSF	CO2_STAGE,SPOOLING

	GOTO	NotMinute		;Give spool a minute

;*** end check *******************************************


CHANGEHOLDINGgas
	bcf	STATUS,5

	bcf	GAS_PORT,GAS_PIN	;Turn off gas
	bcf	GAS_PORT,FAN_PIN
	bSf	ACPORT,ACPIN
	
	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	bcf	CO2_STAGE,FANSTAGE
	BCF	CO2_STAGE,SPOOLING
	bcf	CO2_STAGE,GASSTAGE
	BSF	CO2_STAGE,HOLDING	

	bcf 	STATUS,5

	GOTO	NotMinute

CHANGEFANgas
	bcf	STATUS,5
	
	bcf	ACPORT,ACPIN
	bcf	GAS_PORT,GAS_PIN	;Turn off gas
	bSf	GAS_PORT,FAN_PIN	

	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	BCF	CO2_STAGE,SPOOLING
	BCF	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BSF	CO2_STAGE,FANSTAGE	

	bcf 	STATUS,5

	GOTO	NotMinute



;*---------------------*
;*   CO2 Hld Check     *
;*   -------------     *
;*         on	       *
;*---------------------*

CO2HoldCheck	
DecrementHold

Holding

	bsf	STATUS,5		
	movfw	CO2_HOLD_100MINS_DEC
	bcf 	STATUS,5
	movwf	MINS100

	bsf	STATUS,5		
	movfw	CO2_HOLD_10MINS_DEC
	bcf 	STATUS,5
	movwf	MINS10

	bsf	STATUS,5		
	movfw	CO2_HOLD_MINS_DEC
	bcf 	STATUS,5
	movwf	MINS

	bCf	PCLATH,3		;select PROM page 0
	CALL 	DECREMENTMINS
	bSf	PCLATH,3		;select PROM page 1

	bcf 	STATUS,5		;copy MINS100 back
	movfw	MINS100
	bsf	STATUS,5
	movwf	CO2_HOLD_100MINS_DEC

	bcf 	STATUS,5		;copy MINS10 back
	movfw	MINS10
	bsf	STATUS,5
	movwf	CO2_HOLD_10MINS_DEC

	bcf 	STATUS,5		;copy MINS back
	movfw	MINS
	bsf	STATUS,5
	movwf	CO2_HOLD_MINS_DEC

	bcf 	STATUS,5
	BTFSC	CONTROL2,DECREMENT_UPDATE	
	GOTO	ChangeHold
	GOTO	NotMinute

	bsf	ACPORT,ACPIN		;keep AC Pin on

ChangeHold

;********** Now check if the fan cycle is 000 ***********

	bsf 	STATUS,5
	movfw	CO2_ON_MINS
	addlw	00
	bz	FANholdCHECKMINS10
	goto	FANholdNOTALLZEROS
FANholdCHECKMINS10
	movfw	CO2_ON_10MINS
	addlw	00
	bz	FANholdCHECKMINS100
	goto	FANholdNOTALLZEROS
FANholdCHECKMINS100
	movfw	CO2_ON_100MINS
	addlw	00
	bz	GOTOCO2holdCHECK	;bypass FAN stage
FANholdNOTALLZEROS
	GOTO	CHANGEFANhold
GOTOCO2holdCHECK
	bcf 	STATUS,5

	bcf	GAS_PORT,FAN_PIN	;Turn off FAN_BIT
	bcf	GAS_PORT,GAS_PIN
	bCf	ACPORT,ACPIN

	bsf	STATUS,5

	bcf	CO2_STAGE,GASSTAGE
	bcf	CO2_STAGE,FANSTAGE
	bcf	CO2_STAGE,HOLDING
	BSF	CO2_STAGE,SPOOLING

	GOTO	NotMinute		;Give spool a minute

;*** end check *******************************************

CHANGEFANhold
	bcf	STATUS,5

	bcf	ACPORT,ACPIN
	bSf	GAS_PORT,FAN_PIN	;Turn oN FAN_BIT
	bcf	GAS_PORT,GAS_PIN
				
	bsf	STATUS,5

	movfw	GAS_ON_MINS		 		
	movwf	GAS_ON_MINS_DEC
	movfw	GAS_ON_10MINS		
	movwf	GAS_ON_10MINS_DEC
	movfw	GAS_ON_100MINS
	movwf	GAS_ON_100MINS_DEC

	movfw	CO2_ON_MINS		 		
	movwf	CO2_ON_MINS_DEC
	movfw	CO2_ON_10MINS		
	movwf	CO2_ON_10MINS_DEC
	movfw	CO2_ON_100MINS
	movwf	CO2_ON_100MINS_DEC

	movfw	CO2_HOLD_MINS		 		
	movwf	CO2_HOLD_MINS_DEC
	movfw	CO2_HOLD_10MINS		
	movwf	CO2_HOLD_10MINS_DEC
	movfw	CO2_HOLD_100MINS
	movwf	CO2_HOLD_100MINS_DEC

	bcf	CO2_STAGE,SPOOLING
	bcf	CO2_STAGE,HOLDING
	bcf	CO2_STAGE,GASSTAGE
	BSF	CO2_STAGE,FANSTAGE	

	bcf 	STATUS,5
	
	






















NotMinute

;*** Move temporary registers back to SECS - TEMPHRS10 ***
	bcf 	STATUS,5

	movfw	TEMPSECS
	movwf	SECS
	movfw	TEMPSECS10
	movwf	SECS10
	movfw	TEMPMINS
	movwf	MINS
	movfw	TEMPMINS10
	movwf	MINS10
	movfw	TEMPMINS100
	movwf	MINS100
	movfw	TEMPHRS
	movwf	HRS
	movfw	TEMPHRS10
	movwf	HRS10



;****************************
;*  After the second check  *
;****************************
 
AFTERSECOND

	;do other stuff
	goto 	MAIN
	;****	
	
	END

;*************************************************************


