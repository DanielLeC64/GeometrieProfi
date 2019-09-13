;***************************************
;*       Hauptprogramm                 *
;***************************************
 £ba $1000
 £on "haupt1,p,w",s
 £la irqinit=$c000
 £la button=$c2fa
 £la winout1=$c2fb
 £la winout2=$c313
 £la oldscreen=$c439
 £la input=$c45c
 £la textout=$c4c4
 £la dirwin=$c3b1
 £la hauptkoerper=$1414
 £la hauptflaechen=$1000
 
;*******************************
 £md grwin.
          lda #$00
          sta number;grundwindows aus-  
          ldx number;geben              
loop:
          jsr winout2
          ldx number
          inc number
          cpx #$0d
          bne loop
 £de  
;*******************************
 
          lda #$0b;  farben setzen      
          sta $d020
          lda #$0c
          sta $d021
          lda #$13
          sta $d018; neuer Zeichensatz  
          lda #$05;  schriftfarbe setzen
          jsr $e716
          jsr $e544; bildschirm loeschen
          lda #$0e
          jsr $e716; kleinbuchstaben    
          lda #$08
          jsr $e716; shift+commodore spe
          lda #$47;  c1 einsetzen       
          sta $0318; stop+restore sperre
 
 £ma grwin.
          jsr clrdisp
          jsr irqinit; irq initialisiere
          ldx #$02
          jsr textout
          ldx #$03
          jsr textout
          ldx #$04
          jsr textout
          ldy #$a0
          sty $0428+12
          sty $0428+24
          sty $0428+30
          sty $0428+38
          sty $0450+12
          sty $0450+24
          sty $0450+30
          sty $0450+38
          lda #$a0
          ldx #$0b
schatten1:
          sta $0478+1,x
          dex  
          bne schatten1
          ldx #$0b
schatten2:
          sta $0478+13,x
          dex  
          bne schatten2
          ldx #$05
schatten3:
          sta $0478+25,x
          dex  
          bne schatten3
          ldx #$07
schatten4:
          sta $0478+31,x
          dex  
          bne schatten4
          ldx #$04
          stx selb1+2
          ldx #$ef
          stx selb1+1
          ldx #$05
          stx selb2+2
          ldx #$03
          stx selb2+1
          ldx #$14
          ldy #$a0
selb1:
          sty $04ef
selb2:
          sty $0503
          clc  
          lda #$28
          adc selb1+1
          sta selb1+1
          lda #$00
          adc selb1+2
          sta selb1+2
          clc  
          lda #$28
          adc selb2+1
          sta selb2+1
          lda #$00
          adc selb2+2
          sta selb2+2
          dex  
          bne selb1
          jsr farbsch
          ldx #$0d
          jsr winout1
          ldx #$1a
          lda #$20
loop2:
          dex  
          sta $0597,x
          sta $05bf,x
          sta $05e7,x
          sta $060f,x
          sta $0637,x
          sta $065f,x
          bne loop2
          ldx #$0c
          stx $d903+4*40
          stx $d903+8*40
          stx $d903+9*40
          ldx #$01
          stx $d903+3*40
          stx $d903+6*40
          stx $d903+5*40
          stx $d903+7*40
          stx $d903+10*40
          ldx #$0e
          jsr winout2
          ldx #$0f
          jsr winout2
          ldx #$0a
schatten5:
          lda #$a0
          sta $0639,x
          sta $0645,x
          lda #$0b
          sta $da39,x
          sta $da45,x
          dex  
          bne schatten5
          sta $da44
          sta $da1c
          sta $d9f4
          sta $da27
          sta $d9ff
          lda #$a0
          sta $0644
          sta $061c
          sta $05f4
          sta $0627
          sta $05ff
          ldx #$05
          jsr textout
          ldx #$06
          jsr textout
          lda #$0b
          ldy #$a0
          sta $d9b2
          sty $05b2
          sta $d9b2+40
          sty $05b2+40
          sta $d9b2+2*40
          sty $05b2+2*40
          sta $d9b2+3*40
          sty $05b2+3*40
          sta $d9b2+4*40
          sty $05b2+4*40
          sta $d9b2+5*40
          sty $05b2+5*40
          sta $d9b2+6*40
          sty $05b2+6*40
          ldx #$1b
loop3:
          lda #$0b
          sta $daaf,x
          lda #$a0
          sta $06af,x
          dex  
          bne loop3
;******windowklick***********
klick1:
          lda button
          bne klick1
          lda #$ff
          sta button
          lda $d001
          cmp #$9e
          bpl klick1
          cmp #$8d
          bcc klick1
          lda $d010
          and #%00000001
          beq loop4
          lda $d000
          cmp #$0c
          bpl klick1
          jmp koerper
loop4:
          lda $d000
          cmp #$63
          bcc klick1
          cmp #$b4
          bcs loop5
          jmp flaechen
loop5:
          cmp #$c4
          bcc klick1
          jmp koerper
wechsel1:
          jsr $e544
          ldx #$10
          jsr winout2
          ldx #$26
schatten6:
          lda #$a0
          sta $0798,x
          lda #$0b
          sta $db98,x
          dex  
          bne schatten6
          lda #$04
          sta selb5+2
          lda #$d8
          sta selb6+2
          lda #$4e
          sta selb5+1
          sta selb6+1
          ldx #$16
schatten7:
          lda #$a0
selb5:
          sta $044e
          lda #$0b
selb6:
          sta $d84e
          lda #$28
          clc  
          adc selb5+1
          sta selb5+1
          lda #$00
          adc selb5+2
          sta selb5+2
          lda #$28
          clc  
          adc selb6+1
          sta selb6+1
          lda #$00
          adc selb6+2
          sta selb6+2
          dex  
          bne schatten7
          ldx #$11
          stx $fe
          ldx #$01
          stx $fc
          stx $fb
          ldx #$03
          stx $fd
          jsr dirwin
loop6:
          inc $fb
          inc $fb
          inc $fb
          inc $fd
          inc $fd
          inc $fd
          jsr dirwin
          ldx $fd
          cpx #$15
          bne loop6
          ldx #$12
          stx $fc
          ldx #$24
          stx $fe
          ldx #$01
          stx $fb
          ldx #$03
          stx $fd
          jsr dirwin
loop7:
          inc $fb
          inc $fb
          inc $fb
          inc $fd
          inc $fd
          inc $fd
          jsr dirwin
          ldx $fd
          cpx #$15
          bne loop7
          rts  
wechsel2:
          lda #$ff
          sta button
klick2:
          lda button
          bne klick2
          lda #$ff
          sta button
          lda $d010
          and #%00000001
          bne loop8
          lda $d000
          cmp #$24
          bcc klick2
          cmp #$a2
          bcc links
          cmp #$ac
          bcc klick2
          jmp rechts
loop8:
          lda $d000
          cmp #$3a
          bpl klick2
rechts:
          ldx #$00
          lda $d001
          cmp #$3f
          bcc klick2
          cmp #$4c
          bcc win8
          cmp #$57
          bcc klick2
          cmp #$64
          bcc win9
          cmp #$6f
          bcc klick2
          cmp #$7c
          bcc win10
          cmp #$87
          bcc klick2
          cmp #$94
          bcc win11
          cmp #$9f
          bcc klick2
          cmp #$ac
          bcc win12
          cmp #$b7
          bcc klick2
          cmp #$c4
          bcc win13
          cmp #$cf
          bcc klick2
          cmp #$dc
          bcc win14
          bcs klick2
links:
          ldx #$00
          lda $d001
          cmp #$3f
not:
          bcc klick2
          cmp #$4c
          bcc win1
          cmp #$57
          bcc not
          cmp #$64
          bcc win2
          cmp #$6f
          bcc not
          cmp #$7c
          bcc win3
          cmp #$87
          bcc not
          cmp #$94
          bcc win4
          cmp #$9f
          bcc not
          cmp #$ac
          bcc win5
          cmp #$b7
          bcc not
          cmp #$c4
          bcc win6
          cmp #$cf
          bcc not
          cmp #$dc
          bcc win7
          jmp klick2
win14:
          inx  
win13:
          inx  
win12:
          inx  
win11:
          inx  
win10:
          inx  
win9:
          inx  
win8:
          inx  
win7:
          inx  
win6:
          inx  
win5:
          inx  
win4:
          inx  
win3:
          inx  
win2:
          inx  
win1:
          inx  
          rts  
;---------------------------------------
koerper:
          jsr clrdisp
          nop ;     entpacken!!!!  
          nop ;     entfaellt!!!!       
          nop  
          jsr wechsel1
          ldx #$07
loop9:
          jsr textout
          inx  
          cpx #$14
          bne loop9
          jsr wechsel2
          jmp hauptkoerper
;---------------------------------------
flaechen:
          jsr clrdisp
          nop ;     entpacken!!!!  
          nop ;     entfaellt!!!!       
          nop  
          jsr wechsel1
          ldx #$07;     textnummern!!!!!
loop10:
          jsr textout;  anpassem!!!!!!! 
          inx  
          cpx #$14
          bne loop10
          jsr wechsel2
          jmp hauptflaechen
;---------------------------------------
farbsch:
          lda #$0b
          sta $d834
          sta $d840
          sta $d846
          sta $d84e
          sta $d85c
          sta $d868
          sta $d86e
          sta $d876
          tax  
farbs1:
          sta $d879,x
          dex  
          bne farbs1
          tax  
farbs2:
          sta $d885,x
          dex  
          bne farbs2
          ldx #$05
farbs3:
          sta $d891,x
          dex  
          bne farbs3
          ldx #$07
farbs4:
          sta $d897,x
          dex  
          bne farbs4
          ldx #$d8
          stx selb3+2
          ldx #$ef
          stx selb3+1
          ldx #$d9
          stx selb4+2
          ldx #$03
          stx selb4+1
          ldx #$14
          ldy #$0b
selb3:
          sty $d8ef
selb4:
          sty $d903
          clc  
          lda #$28
          adc selb3+1
          sta selb3+1
          lda #$00
          adc selb3+2
          sta selb3+2
          clc  
          lda #$28
          adc selb4+1
          sta selb4+1
          lda #$00
          adc selb4+2
          sta selb4+2
          dex  
          bne selb3
          rts  
;-------------------------------
clrdisp:
          lda #$00
          tax  
clrdisp1:
          dex  
          sta $2000,x
          sta $2100,x
          sta $2200,x
          sta $2300,x
          sta $2400,x
          sta $2500,x
          cpx #$00
          bne clrdisp1
          ldx #$41
clrdisp2:
          dex  
          sta $2600,x
          cpx #$00
          bne clrdisp2
          rts  
number:
 £by $00
 
   