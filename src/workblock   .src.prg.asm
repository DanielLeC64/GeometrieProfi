;***************************************
;*                                     *
;*       Alle IRQ Routinen fuer        *
;*         Geometrie V1.0              *
;*     (Multiplex,Maus+Joystick)       *
;***************************************
 
 £ba $c000
 £la zeiger=$07f9
 £la koox=$d002
 £la kooy=$d003
 £la farbe=$d028
 £la anaus=$d015
 £la pos=$d012
 £la request=$d019
 £la y=$6d
 £la x=$2c
 
;******sprites initialisieren*****
          lda #$80
          sta zeiger
          lda #$85
          sta zeiger+1
          lda #$8a
          sta zeiger+2
          lda #$8f
          sta zeiger+3
          lda #$94
          sta zeiger+4
          lda #$0b
          sta farbe
          sta farbe+1
          sta farbe+2
          sta farbe+3
          sta farbe+4
          lda #y
          sta kooy
          sta kooy+2
          sta kooy+4
          sta kooy+6
          sta kooy+8
          lda #x
          sta koox
          lda #x+$18
          sta koox+2
          lda #x+2*$18
          sta koox+4
          lda #x+3*$18
          sta koox+6
          lda #x+4*$18
          sta koox+8
          lda #$ff
          sta anaus
 
;********interrupt initialisieren******
 
          sei  
          lda #<anfang
          sta $0314
          lda #>anfang
          sta $0315
 
          lda #$7f;   zeitbegrenzten irq
          sta $dc0d;  verhindern        
 
          lda #$01;   raster-irq        
          sta $d01a;  zulassen          
 
          lda #$6a;   raster-irq bei    
          sta pos;    position 6e       
 
          lda $d011;  bit 8 von pos     
          and #$7f;   loeschen          
          sta $d011
          jmp mausinit; maus+joy initial
 
;********interruptroutine*********
 
 
anfang:
          lda #$80
          sta zeiger
          lda #$85
          sta zeiger+1
          lda #$8a
          sta zeiger+2
          lda #$8f
          sta zeiger+3
          lda #$94
          sta zeiger+4
          lda #y
          sta kooy;     neue y-koordinat
          sta kooy+2;   festlegen       
          sta kooy+4
          sta kooy+6
          sta kooy+8
          lda #y+$12+2; auf position 12 
loop10:
          cmp pos;      warten          
          bne loop10
          ldx #$03
ausgl1:
          dex  
          bne ausgl1
          lda #y+$12+3
          beq ausgl2
          bit $ff
          bit $ff
ausgl2:
          sta kooy;     neue y-koordinat
          sta kooy+2;   festlegen       
          sta kooy+4
          sta kooy+6
          sta kooy+8
          inc zeiger
          inc zeiger+1
          inc zeiger+2
          inc zeiger+3
          inc zeiger+4
          lda #y+2*$14+1
loop20:
          cmp pos
          bne loop20
          ldx #$03
ausgl3:
          dex  
          bne ausgl3
          lda #y+2*$14+2
          cmp pos
          beq ausgl4
          bit $ff
          bit $ff
ausgl4:
          sta kooy
          sta kooy+2
          sta kooy+4
          sta kooy+6
          sta kooy+8
          inc zeiger
          inc zeiger+1
          inc zeiger+2
          inc zeiger+3
          inc zeiger+4
          lda #y+3*$14+1
ausgl5:
          cmp pos
          bne ausgl5
          ldx #$07
ausgl6:
          dex  
          bne ausgl6
          lda #y+3*$14+3
          cmp pos
          beq loop30
loop30:
          sta kooy
          sta kooy+2
          sta kooy+4
          sta kooy+6
          sta kooy+8
          inc zeiger
          inc zeiger+1
          inc zeiger+2
          inc zeiger+3
          inc zeiger+4
          lda #y+4*$14+3
loop40:
          cmp pos
          bne loop40
          ldx #$04
ausgl7:
          dex  
          bne ausgl7
          lda #y+4*$14+4
          cmp pos
          beq ausgl8
          nop  
          bit $ff
ausgl8:
          sta kooy
          sta kooy+2
          sta kooy+4
          sta kooy+6
          sta kooy+8
          inc zeiger
          inc zeiger+1
          inc zeiger+2
          inc zeiger+3
          inc zeiger+4
 
          lda request;  request-register
          sta request;  freigeben       
 
          jmp mirq;    sprung zu maus  
 
;***************************************
;*    Maus+Joysticktreiber fuer IRQ    *
;***************************************
 
 £la potx=$d419;register x              
 £la poty=$d41a;register y              
 £la spritex=$d000;position x           
 £la spritey=$d001;position y           
 £la cia1=$dc00;Basisadresse CIA1       
 £la msb=$d010;ueberlaufregister        
sprite:
 £by $f8,$00,$00,$f0,$00,$00,$f0,$00,$00
 £by $d8,$00,$00,$8c,$00,$00,$06,$00,$00
 £by $03,$00,$00,$01,$80
 
;*********sprite kopieren**************
mausinit:
          ldx #$00
lese1:
          lda sprite,x
          sta $0340,x
          inx  
          cpx #$17
          bne lese1
          lda #$00
lese2:
          sta $0340,x
          inx  
          cpx #$41
          bne lese2
          sei  
          lda #$b0
          sta spritex
          sta spritey
          lda #$ff
          sta $d015;  Sprite 0 ein      
          lda #$01
          sta $d027;  Farbe setzten     
          lda #$0d
          sta $07f8;  Spriteblock       
          cli  
          rts  
;********irq-routine**********
mirq:
          lda #$ff
          cmp pos
          bne mirq
          lda potx
          ldy count1
          jsr posrech
          sty count1
          clc  
          adc spritex
          sta spritex
          txa  
          adc #$00
          and #$01
          eor msb
          sta msb
          lda poty
          ldy count2
          jsr posrech
          sty count2
          sec  
          eor #$ff
          adc spritey
          sta spritey
          jmp jirq;     sprung zu joyst.
;*******unterroutinen*********
 
posrech:
          sta newpos
          sty oldpos
          ldx #$00
          sec  
          sbc oldpos
          and #$7f
          cmp #$40
          bcs loop7
          lsr  
          ldy newpos
          rts  
loop7:
          ora #$c0
          cmp #$ff
          bne loop8
          lda #$00
          rts  
loop8:
          sec  
          ror  
          ldx #$ff
          ldy newpos
          rts  
newpos:
 £by $00
oldpos:
 £by $00
count1:
 £by $00
count2:
 £by $00
 
;******Joystickroutine*******
jirq:
          lda #$e0;   Tastaturabfrage   
          sta cia1+2; sperren           
          lda cia1
          sta help
          lda cia1+1; Knopfabfrage fuer 
          and #$10;   Maus hier!!!      
          bne next
          sta button
next:
          lda #$ff;   Tastaturabfrage   
          sta cia1+2; wieder freigeben  
          lda #$01
          and help
          beq nord
s:
          lda #$02
          and help
          beq sued
o:
          lda #$08
          and help
          beq ost
w:
          lda #$04
          and help
          beq west
b:
          lda #$10
          and help
          beq lknopf
          jmp $ea31;    alte irq-routine
help:
 £by $00
lknopf:
          jmp knopf
 
;*******Unterroutinen*************
nord:
          dec spritey
          dec spritey
          jmp s
sued:
          inc spritey
          inc spritey
          jmp o
ost:
          lda #%00000001
          eor msb;   NSB gesetzt???     
          beq loop1; ja,dann loop1      
          lda spritex
          cmp #$fe;  schon 255???       
          bcc loop2; nein,dann loop2    
          lda #$01
          sta msb
loop2:
          inc spritex
          inc spritex
          jmp w
loop1:
          lda spritex
          cmp #$5f;  schon Position $60 
          bcc loop3; nein,dann loop3    
          ldy #$00
          sty msb
          ldy #$05
          sty spritex
loop3:
          inc spritex
          inc spritex
          jmp w
west:
          lda #%00000001
          eor msb;   msb gesetzt???     
          beq loop4; ja,dann loop4      
          lda spritex
          cmp #$09;  schon pos. 09      
          bcs loop5; nein,dann loop5    
          lda #$01
          sta msb
          lda #$5f
          sta spritex
loop5:
          dec spritex
          dec spritex
          jmp b
loop4:
          lda spritex
          cmp #$02;  schon position 00  
          bcs loop6; nein,dann loop6    
          ldx #$00
          stx msb
          dex  
          stx spritex
loop6:
          dec spritex
          dec spritex
          jmp b
knopf:
          sta button
          jmp $ea31;    alte irq-routine
button:
 £by $ff
 
 
;***************************************
;*   Winout - by D.Schulte 03.09.1993  *
;* Routine zum Windowaufruf mit Nummer *
;*    Windowkoordinaten in Tabellen    *
;*   Laenge ohne Tab.=$0018=24 Bytes   *
;***************************************
 
 £la y1=$fb
 £la x1=$fc
 £la y2=$fd
 £la x2=$fe
 
;******Hauproutine********
winout1:
          lda zeile1,x
          sta y1
          lda spalte1,x
          sta x1
          lda zeile2,x
          sta y2
          lda spalte2,x
          sta x2
          jsr start
          rts  
winout2:
          lda zeile1,x
          sta y1
          lda spalte1,x
          sta x1
          lda zeile2,x
          sta y2
          lda spalte2,x
          sta x2
          jsr start2
          rts  
 
;*******Tabellen***********
zeile1:
 £by $05,$00,$00,$00,$00
 £by $16,$04,$07,$0a,$0d
 £by $10,$13,$16,$09,$0b
 £by $0b,$00,$00,$00,$00
 £by $00,$00,$00,$00,$00
 
spalte1:
 £by $01,$01,$0d,$19,$1f
 £by $01,$14,$14,$14,$14
 £by $14,$14,$14,$06,$09
 £by $15,$00,$00,$00,$00
 £by $00,$00,$00,$00,$00
 
zeile2:
 £by $15,$02,$02,$02,$02
 £by $18,$06,$09,$0c,$0f
 £by $12,$15,$18,$10,$0d
 £by $0d,$16,$00,$00,$00
 £by $00,$00,$00,$00,$00
 
spalte2:
 £by $12,$0b,$17,$1d,$25
 £by $12,$26,$26,$26,$26
 £by $26,$26,$26,$21,$13
 £by $1e,$25,$00,$00,$00
 £by $00,$00,$00,$00,$00
 
 
 
;**************************************
;*   Routine zum Setzen von Windows   *
;*   Start variabel,Screen variabel   *
;*  Rout.WINDOWSET by D.S. 02.09.93   *
;*   Laenge:$00cd bytes = 205 bytes   *
;* Bildschirmrueckholroutine:£ba+00e8 *
;**************************************
 
 £la kantew=$5b;   waagerechte kante    
 £la kantes=$5c;   senkrechte kante     
 £la eckol=$5d;    ecke oben links      
 £la eckor=$5e;    ecke oben rechts     
 £la eckul=$5f;    ecke unten links     
 £la eckur=$60;    ecke unten rechts    
 £la screen=$cc00; bildschirm zwei      
 £la tram=$0400;   normaler textbilds.  
 
;*****Bildschirm retten**********
start:
          ldx #$00
copy:
          lda tram,x
          sta screen,x
          lda tram+$100,x
          sta screen+$100,x
          lda tram+$200,x
          sta screen+$200,x
          inx  
          bne copy
copy2:
          lda tram+$300,x
          sta screen+$300,x
          inx  
          cpx #$e8
          bne copy2
 
;*****Window zeichnen************
start2:
          ldx y1
          lda zeilen1,x
          ldy zeilen2,x
          sta $c2
          sty $c1
          lda #eckol
          ldy x1
eck1:
          sta ($c1),y
          lda #kantew
          iny  
sprung1:
          sta ($c1),y
          iny  
          cpy x2
          bne sprung1
          lda #eckor
eck2:
          sta ($c1),y
          ldx y1
sprung2:
          inx  
          lda #40
          clc  
          adc $c1
          sta $c1
          lda #$00
          adc $c2
          sta $c2
          cpx y2
          beq sprung3
          lda #kantes
          ldy x1
kante1:
          sta ($c1),y
          ldy x2
kante2:
          sta ($c1),y
          jmp sprung2
sprung3:
          lda #eckul
          ldy x1
eck3:
          sta ($c1),y
          lda #kantew
          iny  
sprung4:
          sta ($c1),y
          iny  
          cpy x2
          bne sprung4
          lda #eckur
eck4:
          sta ($c1),y
          rts  
zeilen1:
 £by 04,04,04,04,04,04,04,05,05,05,05
 £by 05,05,06,06,06,06,06,06,06,07,07
 £by 07,07,07
zeilen2:
 £by $00,$28,$50,$78,$a0,$c8,$f0,$18
 £by $40,$68,$90,$b8,$e0,$08,$30,$58
 £by $80,$a8,$d0,$f8,$20,$48,$70,$98
 £by $c0
 
;*******Bildschirm zurueck*********
oldscreen:
          ldx #$00
copy3:
          lda screen,x
          sta tram,x
          lda screen+$100,x
          sta tram+$100,x
          lda screen+$200,x
          sta tram+$200,x
          inx  
          bne copy3
copy4:
          lda screen+$300,x
          sta tram+$300,x
          inx  
          cpx #$e8
          bne copy4
          rts  
 
 
 
;***************************************
;* Inputroutine,Anzahl Zeichen im Accu *
;* Bildschirmposition Low+High im X+Y  *
;* Register, Laenge ohne Tastentabelle *
;*            $005f=95 Bytes           *
;*       by D.Schulte 28.06.1993       *
;***************************************
 
 £la get=$ffe4; GETIN-Routine im System 
 £la string=$cb00; String anpassen      
 £la nummer1=$fb; Zwischenspeicher in   
 £la nummer2=$fc; Zeropage              
 £la bildram=$fd; Low+High Byte in Zero 
 
;********initialisieren********
input:
          stx bildram;   low+high-byte  
          sty bildram+1; der position   
          lda #$0b
          sta nummer1; anzahl zeichen   
          ldy #$00;    aktuelle zeichen-
          sty nummer2; nummer auf 0     
          lda #$a0;          cursor     
          sta (bildram),y;   setzen     
          lda #$00
          sta $c6
 
;*******hauptroutine*********
 
loop100:
          jsr get;     zeichen holen    
          beq loop100
          cmp #$0d;   return?            
          beq return; ja,dann return    
          cmp #$14;   delete?            
          beq delete; ja.dann delete    
          cmp #$2e
          bcc loop100
          cmp #$3a
          bcs loop100
          cmp #$2f
          beq loop100
 
;*****Zeichen ausgeben********
 
          ldy nummer2
          cpy nummer1
          beq loop300
          inc nummer2
print1:
          sta (bildram),y;auf bildschirm
string1:
          sta string,y; string speichern
          jmp loop400; naechstes zeichen
loop300:
          lda #$20; space in accu                 
          bne print1
 
;*****zeichen loeschen*******
 
delete:
          lda #$20;  space laden        
          ldy nummer2
          beq print2
          sta (bildram),y
          dec nummer2
          dey  
print2:
          sta (bildram),y
string2:
          sta string,y
          jmp loop400
 
;*******return*************
 
return:
          ldy nummer2; gelesene zeichen 
          lda #$20;          +01        
          sta (bildram),y
string3:
          sta string,y
          tya ;             im accu     
          rts  
 
;*******cursororganisation*********
 
loop400:
          ldy nummer2; cursor neu       
          lda #$a0;    positionieren    
          sta (bildram),y
          jmp loop100
 
;***************************************
;*     Textausgaberoutine TEXTOUT      *
;*  Laenge ohne Tabelle:$001e=30 Byte  *
;*        by D.Schulte 1.07.1993       *
;***************************************
 
 £la bildrram=$fb
 
;*****Parameteruebergabe***********
textout:
          lda ramposl,x
          sta bildrram;   bildschirmpos.
          lda ramposh,x
          sta bildrram+1; speichern     
          lda tabellel,x; textpositionen
          sta lese+1;     aus tabelle   
          lda tabelleh,x; nach lese     
          sta lese+2;     (selbstmod.)  
 
;******Hauptprogramm************
 
          ldy #$00
lese:
          lda $1000,y
          beq ende
          sta (bildrram),y
          iny  
          bne lese
ende:
          rts  
 
;*****Tabelle fuer Zeichenram**********
 
tabellel:
 £by $00,$08,$0f,$17,$1b,$00,$08
 £by $21,$28,$2f,$36,$3f,$4d,$58
 £by $69,$79,$7f,$8c,$9b,$ab,$21
 £by $28,$2f,$36,$3f,$4d,$58,$69
 £by $79,$7f,$8c,$9b,$ab
tabelleh:
 £by $ca,$ca,$ca,$ca,$ca,$ca,$ca
 £by $ca,$ca,$ca,$ca,$ca,$ca,$ca
 £by $ca,$ca,$ca,$ca,$ca,$ca,$ca
 £by $ca,$ca,$ca,$ca,$ca,$ca,$ca
 £by $ca,$ca,$ca,$ca,$ca
ramposl:
 £by $2b,$2b,$37,$42,$48,$eb,$f7
 £by $56,$46,$ce,$bd,$33,$24,$63
 £by $dc,$58,$ab,$cc,$44,$bd,$f7
 £by $f7,$f7,$f6,$f4,$f5,$f2,$f3
 £by $f7,$f4,$f3,$f3,$f4
ramposh:
 £by $04,$04,$04,$04,$04,$05,$05
 £by $04,$05,$04,$05,$06,$07,$04
 £by $04,$05,$06,$05,$06,$06,$04
 £by $04,$04,$04,$04,$04,$04,$04
 £by $04,$04,$04,$04,$04
 
   