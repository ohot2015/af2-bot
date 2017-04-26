HotKeySet("{f7}","myExit")
HotKeySet("{f5}","stopStart")
HotKeySet("{f3}", 'activW')
Func activW()
   WinActivate("AF2 Чемпионы")
EndFunc
WinActivate("AF2 Чемпионы")
Global $tianut = true;
Global $sadok2 = true;
Global $popl = true
Global $eholot_N =false

;попловок
$x1 = 2410
$y1 = 283
; panel крайняя правая точка шкалы удочки
$px1 = 2690
$py1 = 259
$py2 = $py1
$px2 = $px1


mylog("Start bot!")
Sleep(3000)
while(1)
   While($tianut)
		 mylog('цикл заброса')
		 if ($sadok2) Then
			sadokFull()
		 EndIf
		; radiation()
		; myHp()
		; najivkaGoroh()
		 ;перезакидывание
		 ;MouseClick('left',2558,419,1,10)
		 Send('t')
		 Sleep(8000)
		 mylog('заброшено')
		 ;Opt('SendKeyDownDelay',200);
		 $popl = true
		 while ($popl)
			;mylog('цикл ожидание поклевки')
			Sleep(500)
			$poplovok = PixelSearch($x1,$y1,$x1 + 10,$y1 + 10, 0xFFFF1E, 100)
			if (@error) Then
			   SetError(0);
			   $fish  = true;
			   $podsekat = true
			   Sleep(300)
			   $opt = 50
			   $slp = 350
			   $opt2 = 50
			   $slp2 = 350
			   While($fish)
				  $panel_p = PixelSearch($px1,$py1,$px2,$py2,0x2A2420,2)
				  if (@error AND not($podsekat)) Then
					 SetError(0)
					 mylog('рыба поймана или проебана')
					 $fish = false
					 Sleep(3000)
					 Send("{SPACE}")
					 Sleep(500)
					 Send("j")
					 $popl = false
					 Opt('SendKeyDownDelay','default');
				  ElseIf ($podsekat) Then
					 mylog('подсекает')
					 Sleep(500)
					 Send("{SPACE}")
					 Sleep(1000)
					 $podsekat = false
				  Else
					 mylog('тащим')
					 ; ручное управление
					 if (not($tianut)) Then
						ExitLoop
					 EndIf
					 ; панель полоска удочки гдето по середине
					 $ux1 = 2521
					 $uy1 = 259
					 $uy2 = $uy1
					 $ux2 = $ux1;

					 $uda = PixelSearch($ux1,$uy1,$ux2,$uy2,0x2B2520)
					 if not(@error) Then
						mylog(PixelGetColor($uda[0],$uda[1]))
						$opt = $opt + 3
						$slp = $slp - 10
					 Else
						SetError(0)
						$opt = $opt - 3
						$slp = $slp + 10
					 EndIf
					 Send('{h}')
					 mylog('down-'&$opt)
					 mylog('sleep-'&$slp)
					 Sleep($slp)
					 Send('{g}')
					 Opt('SendKeyDownDelay',$opt);


				  EndIf
			   WEnd
			EndIf
		 WEnd
	  ;EndIf
   WEnd
WEnd

Func mylog($txt)
   $file = FileOpen("mylog.txt", 1)
   ; Check if file opened for writing OK
   If $file = -1 Then
	   MsgBox(0, "Error", "Unable to open file.")
	   Exit
   EndIf
   FileWriteLine($file, @HOUR&':'&@MIN&':'&@SEC& ' - '&$txt & @CRLF)
   FileClose($file)
EndFunc

Func sadokFull()
   $sadok = PixelSearch(2448,259,2448,259,0xC11616 ,5)
   if (@error) Then
	  Return
   Else
	  mylog('садок')
	  ; открыть садок
	  MouseClick('left',2926,492,1,10)
	  Sleep(500)
	  For $i = 30 to 1 Step -1
		 ; складывать рыбу в другой садок
		 MouseClick('left',2547,393,1,10)
		 Sleep(300)
	  Next
	  $sadok2 = false
	   ; закрыть окно с другим садком
	  MouseClick('left',2938,742,1,10)
	  Sleep(1000)
   EndIf
EndFunc

Func stopStart()
   if $tianut == true Then
	  $tianut = False
	  MsgBox(0, "", "stop bot")
   Else
	  $tianut = true
	  MsgBox(0, "", "start bot")
   EndIf
EndFunc


Func najivkaGoroh()
   $naj = PixelSearch(2718,758,2772,809,0x28680B ,30)
   if not(@error) Then
	  Return
   Else
	  mylog('замена наживки горох')
	  MouseClick('left',2718,758,1,10)
	  Sleep(300)
	  $goroh = PixelSearch(2660,446,2685,718,0x387017 ,10)
	  if not(@error) Then
		 MouseClick('left',$goroh[0],$goroh[1],1,10)
	  Else
		 MsgBox(0, "нет наживки", "нет наживки")
	  EndIf
   EndIf
EndFunc

Func myHp()
   $hpLine = PixelSearch(2216,236,2675,236,0x000000 ,50)
   if not(@error) Then
	  Return
   Else
	  mylog('пополнение хп')
	  ;MouseClick('left',2554,793,1,10)
	  ;Sleep(2300)
   EndIf
EndFunc

Func radiation()
   $radLine = PixelSearch(2216,236,2675,236,0x000000 ,50)
   if not(@error) Then
	  Return
   Else
	  mylog('таблетки от радиации')
	 ;MouseClick('left',2604,793,1,10)
	  ;Sleep(2300)
   EndIf
EndFunc

Func myExit()
   mylog('End bot!')
   MsgBox(0, "Tutorial", "End bot!")
   Exit
EndFunc

; 0xD2FF14


;0xFAFF22
;632,579
;648,592