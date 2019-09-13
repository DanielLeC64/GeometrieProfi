;****hauptprogramm koerper**********
 £ba $1414
 £on "haupt2,p,w",s
 £la romram=$1407
 £la ramrom=$140d
 £la button=$c2fa
 £la winout1=$c2fb
 £la winout2=$c313
 £la oldscreen=$c439
 £la input=$c45c
 £la textout=$c4c4
 £la dirwin=$c3b1
 £la wechsel2=$1276
 £la farbschatten=$1365
 £la clrdisp=$13e1
 £la string1=$c493
 £la string2=$c4aa
 £la string3=$c4b6
 £la strfli=$b7b5
 £la fliout=$aabc
 £la plot=$fff0
 £la flistr=$bddd
 £la facmem=$bbd4
 £la memfac=$bba2
 £la memarg=$ba8c
 £la facarg=$bc0c
 £la argfac=$bbfc
 £la bytefac=$b3a2
 £la integer=$bccc
 £la negfac=$bfb4
 £la wurzel=$bf71
 £la multipl=$ba2b
 £la minus=$b853
 £la plus=$b86a
 £la memmult=$ba28
 £la memdiv=$bb0f
 £la memplus=$b867
 £la memmin=$b850
 £la memhoch=$bf78
 £la arghoch=$bf7b
 £la log=$b9ea
 £la vergleich=$bc5b
 £la pruefen=$bc2b
 
;---------------------------------------
loop1:
          cpx #$0e
          bne loop2
          jsr wechsel2
          jmp loop1
loop2:
          txa  
          pha  
          jsr $e544
          jsr neu
          jsr oldscreen
          jsr farbschatten
          ldx #$00
          jsr textout
          pla  
          tax  
          cpx #$01
          beq wuerfel
          cpx #$02
          beq quader
          cpx #$03
          beq prisma
          cpx #$04
          beq pyramide
          cpx #$05
          beq kreiszyl
          cpx #$06
          beq hohlzyl
          cpx #$07
          beq kreiskeg
          cpx #$08
          beq kegelstu
          cpx #$09
          beq pyramstu
          cpx #$0a
          beq kugel
          cpx #$0b
          beq kugelabs
          cpx #$0c
          beq kugelaus
          bne kugelsch
 
wuerfel:
          ldx #$14
          jsr textout
          ldx #$00
          jmp wuerf1
 
quader:
          ldx #$16
          jsr textout
          ldx #$81
          jmp quader1
prisma:
          ldx #$15
          jsr textout
          ldx #$00
          jmp prisma1
pyramide:
          ldx #$17
          jsr textout
          ldx #$00
          jmp pyramid1
kreiszyl:
          ldx #$18
          jsr textout
          ldx #$00
          jmp krzyl1
hohlzyl:
          ldx #$1d
          jsr textout
          ldx #$00
          jmp hozyl1
kreiskeg:
          ldx #$19
          jsr textout
          ldx #$00
          jmp krkeg1
kegelstu:
          ldx #$1a
          jsr textout
          ldx #$00
          jmp kestu1
pyramstu:
          ldx #$1b
          jsr textout
          ldx #$00
          jmp pyramstu
kugel:
          ldx #$1c
          jsr textout
          ldx #$00
          jmp kugel
kugelabs:
          ldx #$1e
          jsr textout
          ldx #$00
          jmp kugelabs
kugelaus:
          ldx #$1f
          jsr textout
          ldx #$00
          jmp kugelaus
kugelsch:
          ldx #$20
          jsr textout
          ldx #$00
          jmp kugelsch
;---------------------------------
; klickroutine                   -
;---------------------------------
 
klick:
          lda #$ff
          sta button
klick1:
          lda button
          bne klick1
          lda $d001
          cmp #$37
          bcc klick
          cmp #$46
          bcc klick2
          lda $d010
          and #$01
          bne klick4
          lda $d000
          cmp #$bb
          bcc klick5
          bcs klick6
klick2:
          lda $d010
          and #$01
          bne klick3
          lda $d000
          cmp #$25
          bcc klick
          cmp #$73
          bcc klickfla
          cmp #$84
          bcc klick
          cmp #$d4
          bcc klickwec
          cmp #$e3
          bcc klick
          bcs klickneu
klick3:
          lda $d000
          cmp #$03
          bcc klickneu
          cmp #$15
          bcc klick
          cmp #$43
          bcc klicksta
          bcs klick
klick4:
          lda $d000
          cmp #$4b
          bcs klick
          bcc klick6
klick5:
          ldx #$04
          lda $d001
          cmp #$e6
          bcc klick
          cmp #$f5
          bcs klick
          lda $d000
          cmp #$24
          bcc klick
          cmp #$ab
          bcs klick
          bcc win8
klickfla:
          ldx #$00
          rts  
klickwec:
          ldx #$01
          rts  
klickneu:
          ldx #$02
          rts  
klicksta:
          ldx #$03
          rts  
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
          rts  
zukli:
          jmp klick
klick6:
          ldx #$04
          lda $d001
          cmp #$57
          bcc zukli
          cmp #$65
          bcc win1
          cmp #$6f
          bcc zukli
          cmp #$7d
          bcc win2
          cmp #$86
          bcc zukli
          cmp #$95
          bcc win3
          cmp #$9f
          bcc zukli
          cmp #$ad
          bcc win4
          cmp #$b6
          bcc zukli
          cmp #$c5
          bcc win5
          cmp #$cf
          bcc zukli
          cmp #$dd
          bcc win6
          cmp #$e6
          bcc zukli
          cmp #$f5
          bcc win7
          bcs zukli
vorinput:
          stx string1+1
          stx string2+1
          stx string3+1
          sty string1+2
          sty string2+2
          sty string3+2
          stx $22
          sty $23
          rts  
;----------------------------------
; unterroutinen
;----------------------------------
input1:
          cpx #$0b
          beq ninp8
          cpx #$04
          beq ninp1
          cpx #$05
          beq ninp2
          cpx #$06
          beq ninp3
          cpx #$07
          beq ninp4
          cpx #$08
          beq ninp5
          cpx #$09
          beq ninp6
          cpx #$0a
          beq ninp7
          rts  
ninp8:
          jsr inp8
          rts  
ninp1:
          jsr inp1
          rts  
ninp2:
          jsr inp2
          rts  
ninp3:
          jsr inp3
          rts  
ninp4:
          jsr inp4
          rts  
ninp5:
          jsr inp5
          rts  
ninp6:
          jsr inp6
          rts  
ninp7:
          jsr inp7
          rts  
inp8:
          ldx #<str8
          ldy #>str8
          jsr vorinput
          ldx #$9e
          ldy #$07
          jsr clrfield
          jsr input
          beq inp81
          jsr strfli
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          lda #%00000001
          ora status
          sta status
          rts  
inp81:
          lda #%11111110
          and status
          sta status
          rts  
inp1:
          ldx #<str1
          ldy #>str1
          jsr vorinput
          ldx #$e2
          ldy #$04
          jsr clrfield
          jsr input
          beq inp11
          jsr strfli
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #%00000010
          ora status
          sta status
          rts  
inp11:
          lda #%11111101
          and status
          sta status
          rts  
inp2:
          ldx #<str2
          ldy #>str2
          jsr vorinput
          ldx #$5a
          ldy #$05
          jsr clrfield
          jsr input
          beq inp21
          jsr strfli
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #%00000100
          ora status
          sta status
          rts  
inp21:
          lda #%11111011
          and status
          sta status
          rts  
inp3:
          ldx #<str3
          ldy #>str3
          jsr vorinput
          ldx #$d2
          ldy #$05
          jsr clrfield
          jsr input
          beq inp31
          jsr strfli
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #%00001000
          ora status
          sta status
          rts  
inp31:
          lda #%11110111
          and status
          sta status
          rts  
inp4:
          ldx #<str4
          ldy #>str4
          jsr vorinput
          ldx #$4a
          ldy #$06
          jsr clrfield
          jsr input
          beq inp41
          jsr strfli
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #%00010000
          ora status
          sta status
          rts  
inp41:
          lda #%11101111
          and status
          sta status
          rts  
inp5:
          ldx #<str5
          ldy #>str5
          jsr vorinput
          ldx #$c2
          ldy #$06
          jsr clrfield
          jsr input
          beq inp51
          jsr strfli
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #%00100000
          ora status
          sta status
          rts  
inp51:
          lda #%11011111
          and status
          sta status
          rts  
inp6:
          ldx #<str6
          ldy #>str6
          jsr vorinput
          ldx #$3a
          ldy #$07
          jsr clrfield
          jsr input
          beq inp61
          jsr strfli
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          lda #%01000000
          ora status
          sta status
          rts  
inp61:
          lda #%10111111
          and status
          sta status
          rts  
inp7:
          ldx #<str7
          ldy #>str7
          jsr vorinput
          ldx #$b2
          ldy #$07
          jsr clrfield
          jsr input
          beq inp71
          jsr strfli
          ldx #<fac7
          ldy #>fac7
          jsr facmem
          lda #%10000000
          ora status
          sta status
          rts  
inp71:
          lda #%01111111
          and status
          sta status
          rts  
 
clrfield:
          sty clrf1+3
          dex  
          stx clrf1+2
          ldx #$0c
          lda #$20
clrf1:
          dex  
          sta $1010,x
          bne clrf1
          ldx clrf1+2
          inx  
          rts  
neu:
          lda #$00
          ldx #$81
neu1:
          dex  
          sta status,x
          bne neu1
          ldx #$0c
          lda #$20
neu2:
          dex  
          sta $079d,x
          sta $04e1,x
          sta $0559,x
          sta $05d1,x
          sta $0649,x
          sta $06c1,x
          sta $0739,x
          sta $07b1,x
          bne neu2
          rts  
ergeb1:
          clc  
          jsr plot
          jsr flistr
          lda $5e
          beq ergeb2
          lda #$20
          jsr $ffd2
          ldx #$00
ergeb4:
          lda $0101,x
          beq ergeb3
          cmp #$45
          beq ergeb5
          cpx #$07
          bcs ergeb61
back:
          jsr $ffd2;(bsout)              
          inx  
          jmp ergeb4
ergeb5:
          jsr $ffd2
          inx  
          ldy #$03
ergeb51:
          lda $0101,x
          jsr $ffd2
          inx  
          dey  
          bne ergeb51
          rts  
ergeb61:
          inx  
          lda $0101,x
          cmp #$45
          beq ergeb62
          jmp ergeb61
ergeb62:
          jsr $ffd2
          inx  
          ldy #$03
          jmp ergeb51
ergeb2:
          lda #$00
          tay  
          iny  
          jsr $ab1e
ergeb3:
          rts  
 
status:
 £by %00000000
str8:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac8:
 £by 0,0,0,0,0
str1:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac1:
 £by 0,0,0,0,0
str2:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac2:
 £by 0,0,0,0,0
str3:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac3:
 £by 0,0,0,0,0
str4:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac4:
 £by 0,0,0,0,0
str5:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac5:
 £by 0,0,0,0,0
str6:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac6:
 £by 0,0,0,0,0
str7:
 £by 0,0,0,0,0,0,0,0,0,0,0
fac7:
 £by 0,0,0,0,0
 
;------------------------------
;  koerperroutinen            -
;------------------------------
 
wuerf1:
          jsr romram
          dex  
          lda $d000,x
          sta $2000+64*6,x
          lda $d100,x
          sta $2000+64*11,x
          lda $d200,x
          sta $2000+64*16,x
          cpx #$00
          bne wuerf1+3
          ldx #$41
wuerf2:
          dex  
          lda $d300,x
          sta $2000+64*22,x
          cpx #$00
          bne wuerf2
          jsr ramrom
          jsr wuerf3
mloopw:
          jsr klick
          cpx #$00
          beq wflaechen
          cpx #$01
          beq wwechsel
          cpx #$02
          beq wneu
          cpx #$03
          beq wstart
          cpx #$0b
          beq wuerf4
          cpx #$09
          bcc wuerf4
          jmp mloopw
wuerf4:
          jsr input1
          jmp mloopw
wuerf3:
          ldx #$56
          stx $079a
          ldx #$01
          stx $04c8+21
          ldx #$05
          stx $0540+21
          ldx #$41
          stx $05b8+21
          stx $0630+21
          stx $06a8+21
          ldx #$0f
          stx $05b8+22
          dex  
          dex  
          stx $0630+22
          ldx #$07
          stx $06a8+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          rts  
wflaechen:
          jmp $1000
wwechsel:
          jmp $1333
wneu:
          jsr neu
          jmp mloopw
;--------------------------------
;--------------------------------
wstart:
wrecha:
          lda status
          and #$02
          cmp #$02
          beq loop3
          lda status
          and #$04
          cmp #$04
          bne wrechaao
          ldy #$03
          jsr bytefac
          jsr wurzel
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
loop3:
          jmp wreche
 
wrechaao:
          lda status
          and #$08
          cmp #$08
          bne wrechaam
          ldy #$06
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp wreche
wrechaam:
          lda status
          and #$10
          cmp #$10
          bne wrechaag
          ldy #$04
          jsr bytefac
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp wreche
wrechaag:
          lda status
          and #$20
          cmp #$20
          bne wrechav
          lda #<fac5
          ldy #>fac5
          jsr memfac
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp wreche
wrechav:
          lda status
          and #$01
          cmp #$01
          bne loop4
          ldy #$03
          jsr bytefac
          lda #$bc
          ldy #$b9
          jsr memdiv
          lda #<fac8
          ldy #>fac8
          jsr memarg
          jsr arghoch
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp wreche
loop4:
          jmp mloopw
wreche:
          lda status
          and #$04
          cmp #$04
          beq wrechao
          ldy #$03
          jsr bytefac
          jsr wurzel
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1;string ausgeben    
          lda status
          ora #$04
          sta status
wrechao:
          lda status
          and #$08
          cmp #$08
          beq wrecham
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$06
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
wrecham:
          lda status
          and #$10
          cmp #$10
          beq wrechag
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$04
          jsr bytefac
          lda #<fac4
          ldy #>fac4
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
wrechag:
          lda status
          and #$20
          cmp #$20
          beq wrechv
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
wrechv:
          lda status
          and #$01
          cmp #$01
          beq wready
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
wready:
          jmp mloopw
quader1:
          jsr romram
          dex  
          lda $d340,x
          sta $2000+64*2,x
          cpx #$00
          bne quader1+3
          ldx #$c1
quader2:
          dex  
          lda $d3c0,x
          sta $2000+64*6,x
          lda $d480,x
          sta $2000+64*11,x
          lda $d540,x
          sta $2000+64*16,x
          lda $d600,x
          sta $2000+64*21,x
          cpx #$00
          bne quader2
          jsr ramrom
          jsr quader3
mloopqu:
          jsr klick
          cpx #$00
          beq quflaechen
          cpx #$01
          beq quwechsel
          cpx #$02
          beq quneu
          cpx #$03
          beq qustart
          jmp quader4
quader4:
          jsr input1
          jmp mloopqu
quader3:
          ldx #$56
          stx $079a
          ldx #$01
          stx $04dd
          ldx #$02
          stx $0555
          ldx #$03
          stx $05cd
          ldx #$05
          stx $0645
          ldx #$41
          stx $06bd
          stx $0735
          stx $07ad
          ldx #$0f
          stx $06be
          dex  
          dex  
          stx $0736
          ldx #$07
          stx $07ae
          ldx #$3d
          stx $079c
          stx $04e0
          stx $0558
          stx $05d0
          stx $0648
          stx $06c0
          stx $0738
          stx $07b0
          rts  
quflaechen:
          jmp $1000
quwechsel:
          jmp $1333
quneu:
          jsr neu
          jmp mloopqu
;--------------------------------
;--------------------------------
qustart:
qurecha:
          lda status
          and #$0e
          cmp #$0e
          beq loop5; geg a+b+c          
          lda status
          and #$06
          cmp #$06
          beq loop7; geg a+b            
          lda status
          and #$0a
          cmp #$0a
          beq loop9; geg a+c            
          lda status
          and #$0c
          cmp #$0c
          beq qurechav; geg b+c                   
          lda status
          and #$82
          cmp #$82
          beq loop12; geg ag+a          
          lda status
          and #$84
          cmp #$84
          beq loop13; geg ag+b                    
          lda status
          and #$e0
          cmp #$c0
          beq loop15; geg am+ag         
          cmp #$a0
          beq loop16; geg ao+ag         
          cmp #$60
          beq loop17; geg ao+am         
          jmp mloopqu
loop5:
          jmp qureche
loop7:
          jmp qurechc
loop9:
          jmp qurechb
loop12:
          jmp qurechbaga
loop13:
          jmp qurechaagb
loop15:
          jmp qurech1ao
loop16:
          jmp qurech1am
loop17:
          jmp qurech1ag
qurechav:
          lda status
          and #$0d
          cmp #$0d
          bne qurechaao
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq qurechav+35
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp qureche
qurechaao:
          lda status
          and #$2c
          cmp #$2c
          bne qurechaam
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr pruefen
          beq qurechaam-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp qureche
qurechaam:
          lda status
          and #$4c
          cmp #$4c
          bne qurechae
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr pruefen
          beq qurechae-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp qureche
qurechae:
          lda status
          and #$1c
          cmp #$1c
          bne loop6
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac1
          ldy #>fac1
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac1
          ldy #>fac1
          jsr memplus
          jsr pruefen
          bmi loop6
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp qureche
loop6:
          jmp mloopqu
qurechb:
          lda status
          and #$0b
          cmp #$0b
          bne qurechbao
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq qurechbao-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp qureche
qurechbao:
          lda status
          and #$2a
          cmp #$2a
          bne qurechbam
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr pruefen
          beq qurechbam-25
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp qureche
qurechbam:
          lda status
          and #$4a
          cmp #$4a
          bne qurechbe
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr pruefen
          beq qurechbe-25
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp qureche
qurechbe:
          lda status
          and #$1a
          cmp #$1a
          bne loop10
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac2
          ldy #>fac2
          jsr memplus
          jsr pruefen
          bmi loop10
          jsr wurzel
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp qureche
loop10:
          jmp mloopqu
qurechc:
          lda status
          and #$80
          cmp #$80
          beq qurechcv
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac7
          ldy #>fac7
          jsr facmem
          ldy #$19
          ldx #$17
          jsr ergeb1
          lda status
          ora #$80
          sta status
qurechcv:
          lda status
          and #$07
          cmp #$07
          bne qurechcam
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          jsr pruefen
          beq qurechcam-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp qureche
qurechcam:
          lda status
          and #$46
          cmp #$46
          bne next20
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          jsr pruefen
          beq next20-14
          lda #<fac6
          ldy #>fac6
          jsr memdiv
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jmp next21
next20:
          jmp qurechcao
testing:
 £br $643,$00
next21:
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp qureche
qurechcao:
          lda status
          and #$26
          cmp #$26
          bne qurechce
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          jsr pruefen
          beq qurechce-25
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp qureche
qurechce:
          lda status
          and #$16
          cmp #$16
          bne loop11
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr pruefen
          bmi loop11
          jsr wurzel
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp qureche
loop11:
          jmp mloopqu
qurechbaga:
          lda status
          and #$04
          cmp #$04
          beq loop14
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr pruefen
          beq loop14-25
          lda #<fac7
          ldy #>fac7
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp qustart
loop14:
          jmp mloopqu
qurechaagb:
          lda status
          and #$02
          cmp #$02
          beq loop14
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr pruefen
          beq qurech1ao-25
          lda #<fac7
          ldy #>fac7
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp qustart
qurech1ao:
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #<fac7
          ldy #>fac7
          jsr memplus
          lda #<fac7
          ldy #>fac7
          jsr memplus
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
          jmp mloopqu
qurech1am:
          lda #<fac7
          ldy #>fac7
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmin
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          lda #<fac7
          ldy #>fac7
          jsr memfac
          lda #<fac6
          ldy #>fac6
          jsr memmin
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
          jmp mloopqu
qurech1ag:
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmin
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac7
          ldy #>fac7
          jsr facmem
          ldy #$19
          ldx #$17
          jsr ergeb1
          lda status
          ora #$80
          sta status
          jmp mloopqu
qureche:
          lda status
          and #$10
          cmp #$10
          beq qurechao
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac4
          ldy #>fac4
          jsr memplus
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac4
          ldy #>fac4
          jsr memplus
          jsr wurzel
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1;string ausgeben    
          lda status
          ora #$10
          sta status
qurechao:
          lda status
          and #$20
          cmp #$20
          beq qurecham
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac5
          ldy #>fac5
          jsr memplus
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac5
          ldy #>fac5
          jsr memplus
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac5
          ldy #>fac5
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
qurecham:
          lda status
          and #$40
          cmp #$40
          beq qurechag
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac6
          ldy #>fac6
          jsr memplus
          jsr facarg
          ldy #$02
          jsr bytefac
          lda $61
          jsr multipl
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
qurechag:
          lda status
          and #$80
          cmp #$80
          beq qurechv
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac7
          ldy #>fac7
          jsr facmem
          ldy #$19
          ldx #$17
          jsr ergeb1
          lda status
          ora #$80
          sta status
qurechv:
          lda status
          and #$01
          cmp #$01
          beq quready
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac7
          ldy #>fac7
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
quready:
          jmp mloopqu
prisma1:
          jsr romram
          dex  
          lda $d6c0,x
          sta $2000+64*5,x
          lda $d7c0,x
          sta $2000+64*9,x
          lda $d8c0,x
          sta $2000+64*13,x
          cpx #$00
          bne prisma1+3
          ldx #$c1
prisma2:
          dex  
          lda $d9c0,x
          sta $2000+64*17,x
          cpx #$00
          bne prisma2
          jsr ramrom
          jsr prisma3
mlooppris:
          jsr klick
          cpx #$00
          beq prflaechen
          cpx #$01
          beq prwechsel
          cpx #$02
          beq prneu
          cpx #$03
          beq prstart
          cpx #$0b
          beq prisma4
          cpx #$0a
          bcc prisma4
          jmp mlooppris
prisma4:
          jsr input1
          jmp mlooppris
prisma3:
          ldx #$56
          stx $079a
          ldx #$08
          stx $04c8+21
          ldx #$53
          stx $0540+21
          ldx #$41
          stx $05b8+21
          stx $0630+21
          stx $06a8+21
          ldx #$0e
          stx $0720+21
          ldx #$0f
          stx $05b8+22
          dex  
          dex  
          stx $0630+22
          ldx #$07
          stx $06a8+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          rts  
prflaechen:
          jmp $1000
prwechsel:
          jmp $1333
prneu:
          jsr neu
          jmp mlooppris
;--------------------------------
;--------------------------------
prstart:
prrechv:
          lda status
          and #$22
          cmp #$22
          bne prrechao; nicht geg ag+h 
          lda status
          and #$01
          cmp #$01
          beq prrechao; geg v weiter    
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
prrechao:
          lda status
          and #$30
          cmp #$30
          bne prrecham1; nicht geg ag+am
          lda status
          and #$08
          cmp #$08
          beq prrecham1; geg ao weiter  
          lda #<fac5
          ldy #>fac5
          jsr memfac
          jsr facarg
          lda $61
          jsr plus
          lda #<fac4
          ldy #>fac4
          jsr memplus
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
prrecham1:
          lda status
          and #$10
          cmp #$10
          beq prrechag1; geg am weiter  
          lda status
          and #$44
          cmp #$44
          bne prrecham2; nicht geg s+n  
          lda #<fac6
          ldy #>fac6
          jsr memfac
          jsr integer; kommastellen weg 
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp prstart
prrecham2:
          lda status
          and #$28
          cmp #$28
          bne prrechag1; nicht geg ao+ag
          lda #<fac5
          ldy #>fac5
          jsr memfac
          jsr facarg
          lda $61
          jsr plus
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
prrechag1:
          lda status
          and #$20
          cmp #$20
          beq prrechh; geg ag weiter    
          lda status
          and #$03
          cmp #$03
          bne prrechag2; nicht geg v+h            
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr pruefen
          beq prrechag2-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
          jmp prstart
prrechag2:
          lda status
          and #$18
          cmp #$18
          bne prrechh; nicht geg ao+am  
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmin
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
          jmp prstart
prrechh:
          lda status
          and #$02
          cmp #$02
          beq prrechs; geg h weiter     
          lda status
          and #$21
          cmp #$21
          bne prrechs; nicht geg v+ag             
          lda #<fac5
          ldy #>fac5
          jsr memfac
          jsr pruefen
          beq prrechs-22
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
prrechs:
          lda status
          and #$04
          cmp #$04
          beq prrechn; geg s weiter     
          lda status
          and #$50
          cmp #$50
          bne prrechn; nicht geg am+n             
          lda #<fac6
          ldy #>fac6
          jsr memfac
          jsr integer; kommastellen weg 
          jsr pruefen
          beq prrechn-22
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
prrechn:
          lda status
          and #$40
          cmp #$40
          beq prready; geg n ready      
          lda status
          and #$14
          cmp #$14
          bne prready; nicht geg am+s   
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr pruefen
          beq prready-22
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
prready:
          jmp mlooppris
pyramid1:
          jsr romram
          dex  
          lda $db00,x
          sta $2000+64*6,x
          lda $dc40,x
          sta $2000+64*11,x
          lda $dd40,x
          sta $2000+64*16,x
          cpx #$00
          bne pyramid1+3
          ldx #$81
pyramid2:
          dex  
          lda $de40,x
          sta $2000+64*22,x
          lda $da80,x
          sta $2000+64*3,x
          cpx #$00
          bne pyramid2
          ldx #$41
pyramid21:
          dex  
          lda $dc00,x
          sta $2000+64*10,x
          lda $dec0,x
          sta $2000+64*24,x
          cpx #$00
          bne pyramid21
          jsr ramrom
          jsr pyramid3
mlooppyram:
          jsr klick
          cpx #$00
          beq pyflaechen
          cpx #$01
          beq pywechsel
          cpx #$02
          beq pyneu
          cpx #$03
          beq pystart
          cpx #$0b
          beq pyramid4
          cpx #$0a
          bcc pyramid4
          jmp mlooppyram
pyramid4:
          jsr input1
          jmp mlooppyram
pyramid3:
          ldx #$56
          stx $079a
          ldx #$08
          stx $04c8+21
          ldx #$13
          stx $0540+22
          ldx #$0e
          stx $0720+21
          ldx #$41
          stx $0540+21
          stx $05b8+21
          stx $0630+21
          stx $06a8+21
          ldx #$0f
          stx $05b8+22
          dex  
          dex  
          stx $0630+22
          ldx #$07
          stx $06a8+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          rts  
pyflaechen:
          jmp $1000
pywechsel:
          jmp $1333
pyneu:
          jsr neu
          jmp mlooppyram
;--------------------------------
;--------------------------------
pystart:
pyrechv:
          lda status
          and #$22
          cmp #$22
          bne pyrechao; nicht geg ag+h  
          lda status
          and #$01
          cmp #$01
          beq pyrechao; geg v weiter    
          ldy #$03
          jsr bytefac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
pyrechao:
          lda status
          and #$30
          cmp #$30
          bne pyrecham1; nicht geg ag+am
          lda status
          and #$08
          cmp #$08
          beq pyrecham1; geg ao weiter  
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac4
          ldy #>fac4
          jsr memplus
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
pyrecham1:
          lda status
          and #$10
          cmp #$10
          beq pyrechag1; geg am weiter  
          lda status
          and #$44
          cmp #$44
          bne pyrecham2; nicht geg s+n  
          lda #<fac6
          ldy #>fac6
          jsr memfac
          jsr integer; kommastellen weg 
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp pystart
pyrecham2:
          lda status
          and #$28
          cmp #$28
          bne pyrechag1; nicht geg ao+ag
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
pyrechag1:
          lda status
          and #$20
          cmp #$20
          beq pyrechh; geg ag weiter    
          lda status
          and #$03
          cmp #$03
          bne pyrechag2; nicht geg v+h  
          ldy #$03
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          jsr pruefen
          beq pyrechag2-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
          jmp pystart
pyrechag2:
          lda status
          and #$18
          cmp #$18
          bne pyrechh; nicht geg ao+am  
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
          jmp pystart
pyrechh:
          lda status
          and #$02
          cmp #$02
          beq pyrechas; geg h weiter    
          lda status
          and #$21
          cmp #$21
          bne pyrechas; nicht geg v+ag  
          ldy #$03
          jsr bytefac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          jsr pruefen
          beq pyrechas-22
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
pyrechas:
          lda status
          and #$04
          cmp #$04
          beq pyrechn; geg as weiter    
          lda status
          and #$50
          cmp #$50
          bne pyrechn; nicht geg am+n   
          lda #<fac6
          ldy #>fac6
          jsr memfac
          jsr integer; kommastellen weg 
          jsr pruefen
          beq pyrechn-22
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
pyrechn:
          lda status
          and #$40
          cmp #$40
          beq pyready; geg n ready      
          lda status
          and #$14
          cmp #$14
          bne pyready; nicht geg am+s   
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr pruefen
          beq pyready-22
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
pyready:
          jmp mlooppyram
krzyl1:
          jsr romram
          dex  
          lda $df00,x
          sta $2000+64*0,x
          lda $e0c0,x
          sta $2000+64*8,x
          lda $e1c0,x
          sta $2000+64*12,x
          lda $e300,x
          sta $2000+64*18,x
          cpx #$00
          bne krzyl1+3
          ldx #$c1
krzyl2:
          dex  
          lda $e000,x
          sta $2000+64*4,x
          lda $e400,x
          sta $2000+64*22,x
          cpx #$00
          bne krzyl2
          ldx #$41
krzyl22:
          dex  
          lda $e2c0,x
          sta $2000+64*16,x
          cpx #$00
          bne krzyl22
          jsr ramrom
          jsr krzyl3
mloopkrzy:
          jsr klick
          cpx #$00
          beq krzyflaechen
          cpx #$01
          beq krzywechsel
          cpx #$02
          beq krzyneu
          cpx #$03
          beq krzystart
          cpx #$0b
          beq krzyl4
          cpx #$08
          bcc krzyl4
          jmp mloopkrzy
krzyl4:
          jsr input1
          jmp mloopkrzy
krzyl3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$08
          stx $0540+21
          ldx #$41
          stx $05b8+21
          stx $0630+21
          ldx #$0f
          stx $05b8+22
          dex  
          dex  
          stx $0630+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          rts  
krzyflaechen:
          jmp $1000
krzywechsel:
          jmp $1333
krzyneu:
          jsr neu
          jmp mloopkrzy
;--------------------------------
;--------------------------------
krzystart:
krzyrecha:
          lda status
          and #$06
          cmp #$06
          beq loop21; geg r+h           
          cmp #$02
          beq krzyrechh1; geg r         
          cmp #$04
          beq loop22; geg h             
          lda status
          and #$18
          cmp #$18
          beq loop24; geg ao+am         
          jmp mloopkrzy
loop21:
          jmp krzyrechv
loop22:
          jmp krzyrechr1
loop24:
          jmp krzyrechr3
krzyrechh1:
          lda status
          and #$01
          cmp #$01
          bne krzyrechh2; nicht geg v   
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq krzyrechh2-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp krzystart
krzyrechh2:
          lda status
          and #$10
          cmp #$10
          bne krzyrechh3; nicht geg am  
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq krzyrechh3-25
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp krzystart
krzyrechh3:
          lda status
          and #$08
          cmp #$08
          bne loop23; nicht geg ao      
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq loop23-25
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          jsr negfac
          lda #<fac1
          ldy #>fac1
          jsr memplus
          jsr negfac
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp krzystart
loop23:
          jmp mloopkrzy
krzyrechr1:
          lda status
          and #$01
          cmp #$01
          bne krzyrechr2; nicht geg v   
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          jsr pruefen
          beq krzyrechr2-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          jsr pruefen
          bmi loop23
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krzystart
krzyrechr2:
          lda status
          and #$10
          cmp #$10
          bne krzyrechr3; nicht geg am  
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          jsr pruefen
          beq krzyrechr3-25
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krzystart
krzyrechr3:
          lda status
          and #$18
          cmp #$18
          bne krzyout; nicht geg ao+am  
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          jsr pruefen
          bmi krzyout
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krzystart
krzyout:
          jmp mloopkrzy
krzyrechv:
          lda status
          and #$01
          cmp #$01
          beq krzyrechao; geg v         
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
krzyrechao:
          lda status
          and #$08
          cmp #$08
          beq krzyrecham; geg ao        
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$e5
          ldy #$e2
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
krzyrecham:
          lda status
          and #$10
          cmp #$10
          beq krzyready; geg am         
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
krzyready:
          jmp mloopkrzy
hozyl1:
          jsr romram
          dex  
          lda $f600,x
          sta $2000+64*5,x
          lda $f700,x
          sta $2000+64*9,x
          lda $f800,x
          sta $2000+64*13,x
          cpx #$00
          bne hozyl1+3
          ldx #$c1
hozyl2:
          dex  
          lda $f900,x
          sta $2000+64*17,x
          cpx #$00
          bne hozyl2
          ldx #$41
hozyl22:
          dex  
          lda $f5c0,x
          sta $2000+64,x
          cpx #$00
          bne hozyl22
          jsr ramrom
          jsr hozyl3
mloophozy:
          jsr klick
          cpx #$00
          beq hozyflaechen
          cpx #$01
          beq hozywechsel
          cpx #$02
          beq hozyneu
          cpx #$03
          beq hozystart
          cpx #$0b
          beq hozyl4
          cpx #$0a
          bcc hozyl4
          jmp mloophozy
hozyl4:
          jsr input1
          jmp mloophozy
hozyl3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          stx $0540+21
          ldx #$01
          stx $05b8+21
          ldx #$08
          stx $0630+21
          ldx #$41
          stx $06a8+21
          stx $0720+21
          ldx #$0f
          stx $06a8+22
          dex  
          dex  
          stx $0720+22
          ldx #$31
          stx $04c8+22
          inx  
          stx $0540+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          rts  
hozyflaechen:
          jmp $1000
hozywechsel:
          jmp $1333
hozyneu:
          jsr neu
          jmp mloophozy
;--------------------------------
;--------------------------------
hozystart:
          lda status
          and #$06
          cmp #$06
          beq hozytest1
hozyback1:
          lda status
          and #$0c
          cmp #$0c
          beq hozytest2
          lda status
          and #$16
          cmp #$16
          beq loop25; geg r1+r2+h       
          cmp #$06
          beq hozyrechh1; geg r1+r2     
          lda status
          and #$0e
          cmp #$0c
          beq loop26; geg a+r2          
          cmp #$0a
          beq loop28; geg a+r1          
          jmp mloophozy
hozytest1:
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr vergleich
          bmi hozytest1-3
          jmp hozyback1
hozytest2:
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi hozytest1-3
          jmp hozyback1+9
loop25:
          jmp hozyrechv
loop26:
          jmp hozyrechr1
loop28:
          jmp hozyrechr2
hozyrecha:
          lda status
          and #$08
          cmp #$08
          beq loop29; a schon geg       
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
loop29:
          rts  
hozyrechh1:
          jsr hozyrecha
          lda status
          and #$01
          cmp #$01
          bne hozyrechh2; nicht geg v   
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac4
          ldy #>fac4
          jsr memmin
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq hozyrechh2-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp hozystart
hozyrechh2:
          lda status
          and #$40
          cmp #$40
          bne hozyrechh3; nicht geg am  
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$09
          ldy #$e3
          jsr memmult
          jsr pruefen
          beq hozyrechh3-25
          lda #<fac6
          ldy #>fac6
          jsr memdiv
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp hozystart
hozyrechh3:
          lda status
          and #$20
          cmp #$20
          bne loop27; nicht geg ao      
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$09
          ldy #$e3
          jsr memmult
          jsr pruefen
          beq loop27-25
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memplus
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac4
          ldy #>fac4
          jsr memmin
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp hozystart
loop27:
          jmp mloophozy
hozyrechr1:
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp hozystart
hozyrechr2:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp hozystart
hozyrechv:
          lda status
          and #$01
          cmp #$01
          beq hozyrechao; geg v         
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac8
          ldy #>fac8
          jsr memmin
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
hozyrechao:
          lda status
          and #$20
          cmp #$20
          beq hozyrecham; geg ao        
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          lda #<fac4
          ldy #>fac4
          jsr memplus
          lda #$e5
          ldy #$e2
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #<fac5
          ldy #>fac5
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
hozyrecham:
          lda status
          and #$40
          cmp #$40
          beq hozyready; geg am         
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$e5
          ldy #$e2
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
hozyready:
          jsr hozyrecha
          jmp mloophozy
krkeg1:
          jsr romram
          dex  
          lda $e500,x
          sta $2000+64*6,x
          lda $e640,x
          sta $2000+64*11,x
          lda $e740,x
          sta $2000+64*16,x
          cpx #$00
          bne krkeg1+3
          ldx #$41
krkeg2:
          dex  
          lda $e4c0,x
          sta $2000+64*4,x
          lda $e600,x
          sta $2000+64*10,x
          cpx #$00
          bne krkeg2
          jsr ramrom
          jsr krkeg3
mloopkrke:
          jsr klick
          cpx #$00
          beq krkeflaechen
          cpx #$01
          beq krkewechsel
          cpx #$02
          beq krkeneu
          cpx #$03
          beq krkestart
          cpx #$0b
          beq krkeg4
          cpx #$09
          bcc krkeg4
          jmp mloopkrke
krkeg4:
          jsr input1
          jmp mloopkrke
krkeg3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$13
          stx $0540+21
          ldx #$08
          stx $05b8+21
          ldx #$41
          stx $0630+21
          stx $06a8+21
          ldx #$0f
          stx $0630+22
          dex  
          dex  
          stx $06a8+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          rts  
krkeflaechen:
          jmp $1000
krkewechsel:
          jmp $1333
krkeneu:
          jsr neu
          jmp mloopkrke
;--------------------------------
;--------------------------------
krkestart:
          lda status
          and #$0c
          cmp #$0c
          beq krketest
krkeback:
          lda status
          and #$0a
          cmp #$0a
          beq loop30; geg r+h           
          cmp #$02
          beq krkerechs1; geg r         
          cmp #$08
          beq loop31; geg h             
          lda status
          and #$24
          cmp #$24
          beq loop34; geg am+s          
          lda status
          and #$30
          cmp #$30
          beq loop33; geg ao+am         
          jmp mloopkrke
krketest:
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi krketest-3
          jmp krkeback
loop30:
          jmp krkerechs
loop31:
          jmp krkerechr1
loop33:
          jmp krkerechr4
loop34:
          jmp krkerechr3
krkerechs1:
          lda status
          and #$20
          cmp #$20
          bne krkerechs2; nicht geg am  
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq krkerechs2-25
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp krkerechh2
krkerechs2:
          lda status
          and #$10
          cmp #$10
          bne krkerechh1; nicht geg ao  
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq krkerechh1-25
          jsr negfac
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memplus
          jsr negfac
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp krkerechh2
krkerechh1:
          lda status
          and #$01
          cmp #$01
          bne krkerechh2; nicht geg v   
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq krkerechh2-25
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp krkestart
krkerechh2:
          lda status
          and #$04
          cmp #$04
          bne loop50; nicht geg s       
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memmin
          jsr pruefen
          bmi krkeout1
          jsr wurzel
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp krkerechv
loop50:
          jmp mloopkrke
krkerechr1:
          lda status
          and #$01
          cmp #$01
          bne krkerechr2; nicht geg v   
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq krkeout1-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          jsr pruefen
          bmi krkeout1
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krkerechs
krkeout1:
          jmp mloopkrke
          jmp krkerechr4
krkerechr2:
          lda status
          and #$04
          cmp #$04
          bne krkerechr2-3; nicht geg s 
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac1
          ldy #>fac1
          jsr memmin
          jsr pruefen
          bmi krkeout1
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krkerechv
krkerechr3:
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq krkerechr4-25
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krkerechh2
krkerechr4:
          lda status
          and #$30
          cmp #$30
          bne krkeout2;n.geg ao+am      
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac4
          ldy #>fac4
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          jsr pruefen
          bmi krkeout2
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp krkerechs2
krkeout2:
          jmp mloopkrke
krkerechs:
          lda status
          and #$04
          cmp #$04
          beq krkerechv; geg s          
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac2
          ldy #>fac2
          jsr memplus
          jsr wurzel
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
krkerechv:
          lda status
          and #$01
          cmp #$01
          beq krkerechao; geg v         
          ldy #$03
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
krkerechao:
          lda status
          and #$10
          cmp #$10
          beq krkerecham; geg ao        
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
krkerecham:
          lda status
          and #$20
          cmp #$20
          beq krkeready; geg am         
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
krkeready:
          jmp mloopkrke
kestu1:
          jsr romram
          dex  
          lda $e840,x
          sta $2000+64*2,x
          lda $e940,x
          sta $2000+64*6,x
          lda $ea40,x
          sta $2000+64*10,x
          lda $eb40,x
          sta $2000+64*14,x
          cpx #$00
          bne kestu1+3
          ldx #$81
kestu2:
          dex  
          lda $ec40,x
          sta $2000+64*18,x
          cpx #$00
          bne kestu2
          ldx #$41
kestu22:
          dex  
          lda $ecc0,x
          sta $2000+64*24,x
          cpx #$00
          bne kestu22
          jsr ramrom
          jsr kestu3
mloopkest:
          jsr klick
          cpx #$00
          beq kestflaechen
          cpx #$01
          beq kestwechsel
          cpx #$02
          beq kestneu
          cpx #$03
          beq keststart
          cpx #$0b
          beq kestu4
          cpx #$0a
          bcc kestu4
          jmp mloopkest
kestu4:
          jsr input1
          jmp mloopkest
kestu3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          stx $0540+21
          ldx #$13
          stx $05b8+21
          ldx #$08
          stx $0630+21
          ldx #$41
          stx $06a8+21
          stx $0720+21
          ldx #$0f
          stx $06a8+22
          dex  
          dex  
          stx $0720+22
          ldx #$31
          stx $04c8+22
          inx  
          stx $0540+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          rts  
kestflaechen:
          jmp $1000
kestwechsel:
          jmp $1333
kestneu:
          jsr neu
          jmp mloopkest
;--------------------------------
;--------------------------------
keststart:
          lda status
          and #$06
          cmp #$06
          beq kesttest
kestback:
          lda status
          and #$18
          cmp #$18
          beq kesttest2
kestback2:
          lda status
          and #$1e
          cmp #$1e
          beq loop40; geg r1+r2+s+h     
          cmp #$0e
          beq loop35; geg r1+r2+s       
          cmp #$16
          beq kestrechs1;geg r1+r2+h    
          cmp #$06
          beq loop36; geg r1+r2         
          lda status
          and #$40
          cmp #$40
          beq loop38; geg am            
          jmp mloopkest
kesttest:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr vergleich
          bmi kesttest-3
          jmp kestback
kesttest2:
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac4
          ldy #>fac4
          jsr vergleich
          bmi kesttest-3
          jmp kestback2
loop35:
          jmp kestrechh1
loop36:
          jmp kestrechs2
loop38:
          jmp kestrechr1
loop40:
          jmp kestrechv
kestrechs1:
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmin
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memmin
          jsr wurzel
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp kestrechv
kestrechs2:
          lda status
          and #$40
          cmp #$40
          bne kestrechs3; nicht geg am  
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq loop41-25
          lda #<fac6
          ldy #>fac6
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp kestrechh1
loop41:
          jmp kestrechh2
kestrechs3:
          lda status
          and #$20
          cmp #$20
          bne loop41; nicht geg ao      
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac3
          ldy #>fac3
          jsr memplus
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          jsr pruefen
          beq loop37-25
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$19
          ldx #$0b
          jsr ergeb1
          lda status
          ora #$08
          sta status
          jmp kestrechh1
loop37:
          jmp mloopkest
kestrechh2:
          lda status
          and #$01
          cmp #$01
          bne loop37; nicht geg v       
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac4
          ldy #>fac4
          jsr memplus
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memplus
          lda #$a8
          ldy #$ae
          jsr memmult
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          jsr pruefen
          beq kestrechh1-25
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp kestrechs1
kestrechh1:
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmin
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac4
          ldy #>fac4
          jsr memplus
          jsr pruefen
          bmi kestout2
          jsr wurzel
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$19
          ldx #$0e
          jsr ergeb1
          lda status
          ora #$10
          sta status
          jmp kestrechv
kestout2:
          jmp mloopkest
kestrechr1:
          lda status
          and #$0c
          cmp #$0c
          bne kestrechr2;nicht geg r2+s 
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac6
          ldy #>fac6
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kestrechr2-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp kestrechh1
kestrechr2:
          lda status
          and #$24
          cmp #$24
          bne kestrechr3;nicht geg r2+ao
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmin
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memplus
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          jsr pruefen
          bmi kestout
          jsr wurzel
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp keststart
kestout:
          jmp mloopkest
kestrechr3:
          lda status
          and #$0a
          cmp #$0a
          bne kestrechr4;nicht geg r1+s 
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac6
          ldy #>fac6
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kestrechr4-25
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp kestrechh1
kestrechr4:
          lda status
          and #$22
          cmp #$22
          bne loop39; nicht geg r1+ao   
          lda #<fac6
          ldy #>fac6
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memplus
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          jsr pruefen
          bmi loop39
          jsr wurzel
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
          jmp keststart
loop39:
          jmp mloopkest
kestrechv:
          lda status
          and #$01
          cmp #$01
          beq kestrechao; geg v         
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr pruefen
          beq kestrechao-22
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memplus
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memdiv
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
kestrechao:
          lda status
          and #$20
          cmp #$20
          beq kestrecham; geg ao        
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac5
          ldy #>fac5
          jsr memplus
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac5
          ldy #>fac5
          jsr memplus
          lda #$a8
          ldy #$ae
          jsr memmult
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          ldy #$19
          ldx #$11
          jsr ergeb1
          lda status
          ora #$20
          sta status
kestrecham:
          lda status
          and #$40
          cmp #$40
          beq kestready; geg am         
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memplus
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmult
          ldx #<fac6
          ldy #>fac6
          jsr facmem
          ldy #$19
          ldx #$14
          jsr ergeb1
          lda status
          ora #$40
          sta status
kestready:
          jmp mloopkest