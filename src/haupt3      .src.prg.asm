;****hauptprogramm koerper**********
 £ba $4041
 £on "haupt3,p,w",s
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
 £la klick=$14e7
 £la input1=$15cd
 £la neu=$179c
 £la status=$1819
 £la fac8=$1825
 £la fac1=$1835
 £la fac2=$1845
 £la fac3=$1855
 £la fac4=$1865
 £la fac5=$1875
 £la fac6=$1885
 £la fac7=$1895
 £la ergeb1=$17c6
 £la romram=$1407
 £la ramrom=$140d
 
;---------------------------------------
pyramstu1:
          jsr romram
          dex  
          lda $ed40,x
          sta $2000+64*6,x
          lda $ee80,x
          sta $2000+64*11,x
          lda $efc0,x
          sta $2000+64*16,x
          cpx #$00
          bne pyramstu1+3
          ldx #$41
pyramstu2:
          dex  
          lda $ed00,x
          sta $2000+64*4,x
          lda $ee40,x
          sta $2000+64*10,x
          lda $ef80,x
          sta $2000+64*15,x
          cpx #$00
          bne pyramstu2
          jsr ramrom
          jsr pyramstu3
mlooppyst:
          jsr klick
          cpx #$00
          beq pystflaechen
          cpx #$01
          beq pystwechsel
          cpx #$02
          beq pystneu
          cpx #$03
          beq pyststart
          cpx #$0b
          beq pyramstu4
          cpx #$0b
          bcc pyramstu4
          jmp mlooppyst
pyramstu4:
          jsr input1
          jmp mlooppyst
pyramstu3:
          ldx #$56
          stx $079a
          ldx #$08
          stx $04c8+21
          ldx #$41
          stx $0540+21
          stx $05b8+21
          stx $0630+21
          stx $06a8+21
          stx $0720+21
          ldx #$0e
          stx $0798+21
          ldx #$0f
          stx $0540+22
          dex  
          dex  
          stx $05b8+22
          ldx #$07
          stx $0630+22
          ldx #$04
          stx $06a8+22
          ldx #$31
          stx $0720+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          stx $0798+24
          rts  
pystflaechen:
          jmp $1000
pystwechsel:
          jmp $1333
pystneu:
          jsr neu
          jmp mlooppyst
;--------------------------------
;--------------------------------
pyststart:
          lda status
          and #$30
          cmp #$30
          beq pysttest
pystback:
          lda status
          and #$0c
          cmp #$0c
          beq pysttest2
pystback2:
          lda status
          and #$48
          cmp #$48
          beq pysttest3
pystback3:
          lda status
          and #$30
          cmp #$30
          beq pystrechv; geg ag+ad      
          lda status
          and #$3c
          cmp #$2c
          beq loop1; geg ao+am+ad       
          cmp #$1c
          beq loop2; geg ao+am+ag       
          lda status
          and #$c8
          cmp #$88
          beq loop4; geg am+n           
          cmp #$c0
          beq loop5; geg a1+n           
          cmp #$48
          beq loop6; geg am+a1          
          jmp mlooppyst
pysttest:
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr vergleich
          bmi pysttest-3
          jmp pystback
pysttest2:
          lda #<fac2
          ldy #>fac2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi pysttest-3
          jmp pystback2
pysttest3:
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac6
          ldy #>fac6
          jsr vergleich
          bmi pysttest-3
          jmp pystback3
loop1:
          jmp pystrechag
loop2:
          jmp pystrechad
loop4:
          jmp pystrecha1
loop5:
          jsr pystrecham2
          jmp pystback3
loop6:
          jsr pystrechn
          jmp pystback3
pystrechv:
          lda status
          and #$02
          cmp #$02
          bne pystrechh; nicht geg h    
          lda status
          and #$01
          cmp #$01
          beq pystrechh-3; geg v        
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmult
          jsr wurzel
          lda #<fac4
          ldy #>fac4
          jsr memplus
          lda #<fac5
          ldy #>fac5
          jsr memplus
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac1
          ldy #>fac1
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
          jmp pystrechao
pystrechh:
          lda status
          and #$01
          cmp #$01
          bne pystrechh-3; nicht geg v  
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memmult
          jsr wurzel
          lda #<fac4
          ldy #>fac4
          jsr memplus
          lda #<fac5
          ldy #>fac5
          jsr memplus
          jsr pruefen
          beq pystrechao-22
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
pystrechao:
          lda status
          and #$08
          cmp #$08
          bne pystrecham1; nicht geg am 
          lda status
          and #$04
          cmp #$04
          beq pystrecha1; geg ao        
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memplus
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
pystrecha1:
          lda status
          and #$80
          cmp #$80
          bne loop3; nicht geg n        
          lda #<fac7
          ldy #>fac7
          jsr memfac
          jsr pruefen
          beq loop3-25
          jsr integer
          lda #<fac3
          ldy #>fac3
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
          jmp mlooppyst
loop3:
          jsr pystrechn
          jmp mlooppyst
pystrecham1:
          lda status
          and #$04
          cmp #$04
          bne pystrecham12; nicht geg ao
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac3
          ldy #>fac3
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
          jmp pystrecha1
pystrecham12:
          lda status
          and #$c0
          cmp #$c0
          bne pystrecham12-3
          jsr pystrecham2
          jmp pystrechao
pystrecham2:
          lda #<fac7
          ldy #>fac7
          jsr memfac
          jsr integer
          lda #<fac6
          ldy #>fac6
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
          rts  
pystrechag:
          lda #<fac5
          ldy #>fac5
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          lda #<fac3
          ldy #>fac3
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
          jmp pystrechv
pystrechad:
          lda #<fac4
          ldy #>fac4
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac3
          ldy #>fac3
          jsr memfac
          lda #<fac5
          ldy #>fac5
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
          jmp pystrechv
pystrechn:
          lda status
          and #$48
          cmp #$48
          bne pystrechn+50
          lda #<fac6
          ldy #>fac6
          jsr memfac
          jsr pruefen
          beq pystrechn+28
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          ldx #<fac7
          ldy #>fac7
          jsr facmem
          ldy #$19
          ldx #$17
          jsr ergeb1
          lda status
          ora #$80
          sta status
          rts  
kugel1:
          jsr romram
          dex  
          lda $f180,x
          sta $2000+64*5,x
          lda $f280,x
          sta $2000+64*9,x
          lda $f380,x
          sta $2000+64*13,x
          cpx #$00
          bne kugel1+3
          ldx #$c1
kugel2:
          dex  
          lda $f0c0,x
          sta $2000+64*1,x
          lda $f480,x
          sta $2000+64*17,x
          cpx #$00
          bne kugel2
          ldx #$81
kugel21:
          dex  
          lda $f540,x
          sta $2000+64*22,x
          cpx #$00
          bne kugel21
          jsr ramrom
          jsr kugel3
mloopk:
          jsr klick
          cpx #$00
          beq kflaechen
          cpx #$01
          beq kwechsel
          cpx #$02
          beq kneu
          cpx #$03
          beq kstart
          cpx #$0b
          beq kugel4
          cpx #$06
          bcc kugel4
          jmp mloopk
kugel4:
          jsr input1
          jmp mloopk
kugel3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$41
          stx $0540+21
          ldx #$0f
          stx $0540+22
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          rts  
kflaechen:
          jmp $1000
kwechsel:
          jmp $1333
kneu:
          jsr neu
          jmp mloopk
;--------------------------------
;--------------------------------
kstart:
krecha:
          lda status
          and #$02
          cmp #$02
          beq krechv; geg r             
          lda status
          and #$01
          cmp #$01
          beq loop10; geg v             
          lda status
          and #$04
          cmp #$04
          beq loop11; geg ao            
          jmp mloopk
loop10:
          jmp krechr1
loop11:
          jmp krechr2
krechv:
          lda status
          and #$01
          cmp #$01
          beq krechao; geg v            
          lda #<fac1
          ldy #>fac1
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #$ea
          ldy #$e2
          jsr memmult
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
krechao:
          lda status
          and #$04
          cmp #$04
          beq kready; geg ao            
          ldy #$04
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$19
          ldx #$08
          jsr ergeb1
          lda status
          ora #$04
          sta status
kready:
          jmp mloopk
krechr1:
          lda status
          and #$01
          cmp #$01
          bne krechr2; nicht geg v      
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$04
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #$bc
          ldy #$b9
          jsr memdiv
          lda #<fac1
          ldy #>fac1
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
          jmp krechao
krechr2:
          lda status
          and #$04
          cmp #$04
          bne kready; nicht geg ao      
          ldy #$04
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac2
          ldy #>fac2
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
          jmp krechv
kabsch1:
          jsr romram
          dex  
          lda $fa80,x
          sta $2000+64*5,x
          lda $fb80,x
          sta $2000+64*9,x
          cpx #$00
          bne kabsch1+3
          ldx #$c1
kabsch2:
          dex  
          lda $f9c0,x
          sta $2000+64*1,x
          lda $fe00,x
          sta $2000+64*21,x
          cpx #$00
          bne kabsch2
          ldx #$81
kabsch21:
          dex  
          lda $fc80,x
          sta $2000+64*14,x
          lda $b680,x
          sta $2000+64*16,x
          lda $fd80,x
          sta $2000+64*18,x
          cpx #$00
          bne kabsch21
          jsr ramrom
          jsr kabsch3
mloopkab:
          jsr klick
          cpx #$00
          beq kabflaechen
          cpx #$01
          beq kabwechsel
          cpx #$02
          beq kabneu
          cpx #$03
          beq kabstart
          cpx #$0b
          beq kabsch4
          cpx #$09
          bcc kabsch4
          jmp mloopkab
kabsch4:
          jsr input1
          jmp mloopkab
kabsch3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$52
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
kabflaechen:
          jmp $1000
kabwechsel:
          jmp $1333
kabneu:
          jsr neu
          jmp mloopkab
;--------------------------------
;--------------------------------
kabstart:
kabrecha:
          lda status
          and #$06
          cmp #$06
          beq kabtest1
kabback1:
          lda status
          and #$0a
          cmp #$0a
          beq kabtest2
kabback2:
          lda status
          and #$0a
          cmp #$0a
          beq kabrechv; geg r+h         
          cmp #$08
          beq loop20; geg h             
          cmp #$02
          beq loop21; geg r             
          jmp mloopkab
kabtest1:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr vergleich
          bmi kabtest1-3
          jmp kabback1
kabtest2:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi kabtest1-3
          jmp kabback2
loop20:
          jmp kabrechr1
loop21:
          jmp kabrechh
kabrechv:
          lda status
          and #$01
          cmp #$01
          beq kabrechao; geg v            
          ldy #$03
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memdiv
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr negfac
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
kabrechao:
          lda status
          and #$10
          cmp #$10
          beq kabrecham; geg ao         
          ldy #$04
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #$a8
          ldy #$ae
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
kabrecham:
          lda status
          and #$20
          cmp #$20
          beq kabrechrr; geg am          
          ldy #$02
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac3
          ldy #>fac3
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
kabrechrr:
          lda status
          and #$04
          cmp #$04
          beq kabready; geg rr          
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
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
kabready:
          jmp mloopkab
kabrechh:
          lda status
          and #$20
          cmp #$20
          bne kabready; nicht geg am    
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq kabrechr1-25
          lda #<fac5
          ldy #>fac5
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
          jmp kabstart
kabrechr1:
          lda status
          and #$04
          cmp #$04
          bne kabrechr2; nicht geg rr   
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
          jsr pruefen
          beq kabrechr2-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          lda #<fac3
          ldy #>fac3
          jsr memplus
          lda #$11
          ldy #$bf
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp kabstart
kabrechr2:
          lda status
          and #$01
          cmp #$01
          bne kabrechr3; nicht geg v    
          lda #<fac3
          ldy #>fac3
          jsr memfac
          jsr pruefen
          beq kabrechr3-25
          jsr facarg
          lda $61
          jsr multipl
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memplus
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp kabstart
kabrechr3:
          lda status
          and #$10
          cmp #$10
          bne kabrechr4; nicht geg ao    
          ldy #$04
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kabrechr4-25
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$04
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memplus
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp kabstart
kabrechr4:
          lda status
          and #$20
          cmp #$20
          bne kabend; nicht geg am      
          ldy #$02
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kabend-25
          lda #$a8
          ldy #$ae
          jsr memmult
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
          jmp kabstart
kabend:
          jmp mloopkab
kaus1:
          jsr romram
          dex  
          lda $b780,x
          sta $2000+64*9,x
          lda $b880,x
          sta $2000+64*14,x
          cpx #$00
          bne kaus1
          ldx #$c1
kaus2:
          dex  
          lda $fec0,x
          sta $2000+64*1,x
          lda $ba00,x
          sta $2000+64*21,x
          cpx #$00
          bne kaus2
          ldx #$81
kaus21:
          dex  
          lda $ff80,x
          sta $2000+64*5,x
          lda $b700,x
          sta $2000+64*7,x
          lda $b980,x
          sta $2000+64*18,x
          cpx #$00
          bne kaus21
          jsr ramrom
          jsr kaus3
mloopkaus:
          jsr klick
          cpx #$00
          beq kausflaechen
          cpx #$01
          beq kauswechsel
          cpx #$02
          beq kausneu
          cpx #$03
          beq kausstart
          cpx #$0b
          beq kaus4
          cpx #$09
          bcc kaus4
          jmp mloopkaus
kaus4:
          jsr input1
          jmp mloopkaus
kaus3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$52
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
kausflaechen:
          jmp $1000
kauswechsel:
          jmp $1333
kausneu:
          jsr neu
          jmp mloopkaus
;--------------------------------
;--------------------------------
kausstart:
kausrecha:
          lda status
          and #$06
          cmp #$06
          beq kaustest1
kausback1:
          lda status
          and #$0a
          cmp #$0a
          beq kaustest2
kausback2:
          lda status
          and #$0a
          cmp #$0a
          beq kausrechv; geg r+h         
          cmp #$02
          beq loop30; geg r             
          cmp #$08
          beq loop31; geg h             
          lda status
          and #$04
          cmp #$04
          beq loop32; geg rr            
          jmp mloopkaus
kaustest1:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr vergleich
          bmi kaustest1-3
          jmp kausback1
kaustest2:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi kaustest1-3
          jmp kausback2
loop30:
          jmp kausrechh
loop31:
          jmp kausrechr1
loop32:
          jmp kausrechr3
kausrechv:
          lda status
          and #$01
          cmp #$01
          beq kausrechao; geg v            
          ldy #$03
          jsr bytefac
          lda #$e5
          ldy #$e2
          jsr memdiv
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac3
          ldy #>fac3
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
kausrechao:
          lda status
          and #$10
          cmp #$10
          beq kausrechrr; geg ao        
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr wurzel
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memplus
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #$a8
          ldy #$ae
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
kausrechrr:
          lda status
          and #$04
          cmp #$04
          beq kausrecham; geg rr        
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memplus
          jsr negfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
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
kausrecham:
          lda status
          and #$20
          cmp #$20
          beq kausready; geg am         
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
kausready:
          jmp mloopkaus
          jmp kausrecham
kausrechh:
          lda status
          and #$01
          cmp #$01
          bne kausrechrr1; nicht geg v  
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq kausrechrr1-25
          lda #<fac1
          ldy #>fac1
          jsr memmult
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
          jmp kausstart
kausrechrr1:
          lda status
          and #$20
          cmp #$20
          bne kausready+3;nicht geg am  
          lda status
          and #$04
          cmp #$04
          beq kausready+3; geg rr       
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq kausrechr1-25
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
          jmp mloopkaus
kausrechr1:
          lda status
          and #$01
          cmp #$01
          bne kausrechr2; nicht geg v   
          ldy #$03
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$e5
          ldy #$e2
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kausrechr2-25
          lda #<fac1
          ldy #>fac1
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
          jmp kausstart
kausrechr2:
          lda status
          and #$04
          cmp #$04
          bne kausrechr1-3; nicht geg rr
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          jsr pruefen
          beq kausrechr3-25
          lda #<fac1
          ldy #>fac1
          jsr memdiv
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          lda #$11
          ldy #$bf
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memplus
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$19
          ldx #$05
          jsr ergeb1
          lda status
          ora #$02
          sta status
          jmp kausstart
kausrechr3:
          lda status
          and #$20
          cmp #$20
          bne kausend; nicht geg am      
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr pruefen
          beq kausend-25
          lda #$a8
          ldy #$ae
          jsr memmult
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
kausend:
          jmp mloopkaus
ksch1:
          jsr romram
          dex  
          lda $bb80,x
          sta $2000+64*5,x
          lda $bc80,x
          sta $2000+64*9,x
          lda $bd80,x
          sta $2000+64*13,x
          cpx #$00
          bne ksch1
          ldx #$c1
ksch2:
          dex  
          lda $bac0,x
          sta $2000+64*1,x
          lda $be80,x
          sta $2000+64*17,x
          cpx #$00
          bne ksch2
          ldx #$41
ksch21:
          dex  
          lda $bf40,x
          sta $2000+64*21,x
          lda $bf80,x
          sta $2000+64*22,x
          lda $bfc0,x
          sta $2000+64*24,x
          cpx #$00
          bne ksch21
          jsr ramrom
          jsr ksch3
mloopksch:
          jsr klick
          cpx #$00
          beq kschflaechen
          cpx #$01
          beq kschwechsel
          cpx #$02
          beq kschneu
          cpx #$03
          beq kschstart
          cpx #$0b
          beq ksch4
          cpx #$0a
          bcc ksch4
          jmp mloopksch
ksch4:
          jsr input1
          jmp mloopksch
ksch3:
          ldx #$56
          stx $079a
          ldx #$12
          stx $04c8+21
          ldx #$52
          stx $0540+21
          stx $05b8+21
          ldx #$31
          stx $0540+22
          inx  
          stx $05b8+22
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
          ldx #$3d
          stx $0798+4
          stx $04c8+24
          stx $0540+24
          stx $05b8+24
          stx $0630+24
          stx $06a8+24
          stx $0720+24
          rts  
kschflaechen:
          jmp $1000
kschwechsel:
          jmp $1333
kschneu:
          jsr neu
          jmp mloopksch
;--------------------------------
;--------------------------------
kschstart:
kschrecha:
          lda status
          and #$06
          cmp #$06
          beq kschtest1
kschback1:
          lda status
          and #$0a
          cmp #$0a
          beq kschtest2
kschback2:
          lda status
          and #$12
          cmp #$12
          beq kschtest3
kschback3:
          lda status
          and #$1e
          cmp #$1e
          beq loop39;geg r+h+rr1+rr2    
          cmp #$1c
          beq loop40; geg rr1+rr2+h     
          cmp #$0e
          beq loop41; geg rr1+rr2+r     
          lda status
          and #$1c
          cmp #$18
          beq loop42; geg rr2+h         
          cmp #$14
          beq loop43; geg rr1+h          
          lda status
          and #$12
          cmp #$12
          beq loop44; geg r+h           
          lda status
          and #$52
          cmp #$50
          beq loop45; geg h+am          
          cmp #$42
          beq loop46; geg r+am          
          jmp mloopksch
kschtest1:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac2
          ldy #>fac2
          jsr vergleich
          bmi kschtest1-3
          jmp kschback1
kschtest2:
          lda #<fac1
          ldy #>fac1
          jsr memfac
          lda #<fac3
          ldy #>fac3
          jsr vergleich
          bmi kschtest1-3
          jmp kschback2
kschtest3:
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr vergleich
          bmi kschtest1-3
          jmp kschback3
loop39:
          jmp kschrechao
loop40:
          jmp kschrechr1
loop41:
          jmp kschrechh1
loop42:
          jmp kschrechrr11
loop43:
          jmp kschrechrr21
loop44:
          jmp kschrecham
loop45:
          jmp kschrechr21
loop46:
          jmp kschrechh21
kschrechao:
          lda status
          and #$20
          cmp #$20
          beq kschrechv; geg ao         
          lda #<fac2
          ldy #>fac2
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          ldx #<fac5
          ldy #>fac5
          jsr facmem
          lda #<fac3
          ldy #>fac3
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
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
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
          jmp kschrechv
kschzusatz:
          jmp kschrecham
kschrechv:
          lda status
          and #$01
          cmp #$01
          beq kschzusatz; geg v         
          ldy #$03
          jsr bytefac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac8
          ldy #>fac8
          jsr memplus
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac8
          ldy #>fac8
          jsr memplus
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$06
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memdiv
          ldx #<fac8
          ldy #>fac8
          jsr facmem
          ldy #$05
          ldx #$17
          jsr ergeb1
          lda status
          ora #$01
          sta status
kschrecham:
          lda status
          and #$40
          cmp #$40
          beq kschready; geg am         
          lda status
          and #$12
          cmp #$12
          bne kschready; nicht geg r+h  
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #$a8
          ldy #$ae
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
kschready:
          jmp mloopksch
kschloop:
          jmp kschrechr2
kschrechr1:
          lda status
          and #$20
          cmp #$20
          bne kschloop; nicht geg ao    
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
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
          ldx #<fac1
          ldy #>fac1
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac4
          ldy #>fac4
          jsr memmult
          jsr pruefen
          beq kschrechr2-25
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
          jmp kschstart
kschrechr2:
          lda status
          and #$40
          cmp #$40
          bne kschrechh1-6;nicht geg am 
          ldy #$02
          jsr bytefac
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq kschrechh1-31
          lda #<fac6
          ldy #>fac6
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
          jmp kschstart
          jmp kschrechv
kschloop2:
          jmp kschrechh2
kschrechh1:
          lda status
          and #$20
          cmp #$20
          bne kschloop2; nicht geg ao   
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
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
          jsr memmin
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
          ldx #<fac4
          ldy #>fac4
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          jsr pruefen
          beq kschrechh2-25
          lda #<fac4
          ldy #>fac4
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
          jmp kschstart
kschrechh2:
          lda status
          and #$40
          cmp #$40
          bne kschrechrr11-6;n. geg am  
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #$a8
          ldy #$ae
          jsr memmult
          jsr pruefen
          beq kschrechrr11-31
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
          jmp kschstart
          jmp mloopksch
kschloop3:
          jmp kschrechrr12
kschrechrr11:
          lda status
          and #$01
          cmp #$01
          bne kschloop3; nicht geg v    
          ldy #$06
          jsr bytefac
          lda #<fac8
          ldy #>fac8
          jsr memmult
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac4
          ldy #>fac4
          jsr memmult
          jsr pruefen
          beq kschrechrr12-25
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          lda #<fac4
          ldy #>fac4
          jsr memfac
          jsr facarg
          lda $61
          jsr multipl
          lda #<fac2
          ldy #>fac2
          jsr memplus
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac2
          ldy #>fac2
          jsr memdiv
          jsr pruefen
          bmi kschrechrr12-25
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
          jmp kschstart
kschrechrr12:
          lda status
          and #$22
          cmp #$22
          bne kschend; nicht geg ao+r   
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
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
          jsr memmin
          ldx #<fac2
          ldy #>fac2
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmin
          jsr pruefen
          bmi kschrechrr21-28
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
          jmp kschstart
kschend:
          jmp mloopksch
kschloop4:
          jmp kschrechrr22
kschrechrr21:
          lda status
          and #$01
          cmp #$01
          bne kschloop4; nicht geg v    
          ldy #$06
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
          lda #<fac4
          ldy #>fac4
          jsr memmult
          jsr pruefen
          beq kschrechrr22-25
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$03
          jsr bytefac
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac2
          ldy #>fac2
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          lda #<fac4
          ldy #>fac4
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
          ldy #$03
          jsr bytefac
          lda #<fac3
          ldy #>fac3
          jsr memdiv
          jsr pruefen
          bmi kschrechrr22-25
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
          jmp kschstart
kschrechrr22:
          lda status
          and #$22
          cmp #$22
          bne kschend2; nicht geg ao+r  
          lda #$a8
          ldy #$ae
          jsr memfac
          lda #<fac5
          ldy #>fac5
          jsr memdiv
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
          jsr memmin
          ldx #<fac3
          ldy #>fac3
          jsr facmem
          ldy #$02
          jsr bytefac
          lda #<fac1
          ldy #>fac1
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #<fac3
          ldy #>fac3
          jsr memmin
          jsr pruefen
          bmi kschrechrr22-25
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
          jmp kschstart
kschend2:
          jmp mloopksch
kschrechr21:
          ldy #$02
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac4
          ldy #>fac4
          jsr memmult
          lda #<fac6
          ldy #>fac6
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
          jmp mloopksch
kschrechh21:
          ldy #$02
          jsr bytefac
          lda #$a8
          ldy #$ae
          jsr memmult
          lda #<fac1
          ldy #>fac1
          jsr memmult
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
          jmp mloopksch
 