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
;$pcolor = 0xff3b26  ; красный
$pcolor = 0xFFFF1E ; зеленый
;$x1 = 2405
;$y1 = 285
;balans poplovok
$x1 = 2412
$y1 = 280
; panel крайняя правая точка шкалы удочки
$px1 = 2690
$py1 = 259
$py2 = $py1
$px2 = $px1
Global $downConst = 50
Global $slpConst =  100
Global $downCof = 0.5
Global $slpCof = 0.5

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
		 ;najivkaGoroh()
		 najivkaKujnechik()
		 ;перезакидывание
		 ;MouseClick('left',2558,419,1,10)
		 Send('t')
		 ;панель попловок
		 PixelSearch($px1,$py1,$px2,$py2,0x2A2420,2)
		 PixelSearch($x1,$y1,$x1 + 10,$y1 + 10,$pcolor, 100)
		 if (@error) Then
			SetError(0);
			Sleep(5000)
		 EndIf
		 mylog('заброшено')
		 ;Opt('SendKeyDownDelay',200);
		 $popl = true
		 while ($popl)
			;mylog('цикл ожидание поклевки')
			Sleep(500)
			$poplovok = PixelSearch($x1,$y1,$x1 + 10,$y1 + 10, $pcolor, 100)
			if (@error) Then
			   SetError(0);
			   $fish  = true;
			   $podsekat = true
			   $opt = 1
			   $slp = 1
			   $opt2 = 1
			   $slp2 = 1
			   While($fish)
				  $panel_p = PixelSearch($px1,$py1,$px2,$py2,0x2A2420,2)
				  if (@error AND not($podsekat)) Then
					 SetError(0)
					 Opt('SendKeyDownDelay',5);
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
					 Send("{SPACE}")
					 Sleep(1000)
					 $podsekat = false
					 MouseClick('left',2584,643,5)
				  Else
					 mylog('тащим')
					 ; ручное управление
					 if (not($tianut)) Then
						ExitLoop
					 EndIf
					 $h = Fric(259,'{h}',$opt,$slp);
					 $opt = $h[0];
					 $slp = $h[1];
					 $g = Fric(277,'{g}',$opt2,$slp2);
					 $opt2 = $g[0];
					 $slp2 = $g[1]
					 Opt('SendKeyDownDelay',5);
				  EndIf
			   WEnd
			EndIf
		 WEnd
	  ;EndIf
   WEnd
WEnd

Func Fric($uy1,$key,$opt,$slp)
; панель полоска удочки гдето по середине
   $ux1 = 2590
   ;$uy1 = 259
   $uy2 = $uy1
   $ux2 = $ux1
   $tmp = $opt * $opt * $opt * $downCof + $downConst
   $stmp = $slp * $slp * $slp * $slpCof + $slpConst
   if ($stmp < 0) Then
	  $stmp = 0
   EndIf
   Opt('SendKeyDownDelay',$tmp)
   if ($opt > 2000) Then
	  $opt = 2000
   EndIf

   Send($key)
   $uda = PixelSearch($ux1,$uy1,$ux2,$uy2,0x2B2520)
   if not(@error) Then
	  $opt = $opt + 1
	  $slp = $slp - 1
   Else
	  SetError(0)
	  $opt = $opt - 1
	  $slp = $slp + 1
   EndIf


   ;Opt('SendKeyDownDelay',$opt+80);

   mylog($key&'-down-'&$tmp)
   mylog($key&'-sleep-'&$stmp )
   Sleep($stmp)
   Local $arr = [$opt, $slp]
   return $arr;
EndFunc

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
	  For $i = 60 to 1 Step -1
		 ; складывать рыбу в другой садок
		 MouseClick('left',2547,393,1,10)
		 Sleep(300)
	  Next
	  $sadok2 = false
	   ; закрыть окно с другим садком
	  MouseClick('left',2938,742,1,10)
	  MouseMove(2562,463,5)
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

Func najivkaKujnechik()
   $naj = PixelSearch(2718,758,2772,809,0x4F2D13 ,2)
   if not(@error) Then
	  Return
   Else
	  SetError(0);
	  mylog('замена наживки горох')
	  MouseClick('left',2718,758,1,10)
	  Sleep(300)
	  $goroh = PixelSearch(2660,446,2685,718,0x3D2C16 ,10)
	  if not(@error) Then
		 MouseClick('left',$goroh[0],$goroh[1],1,10)
	  Else
		 MsgBox(0, "нет наживки", "нет наживки")
	  EndIf
   EndIf
EndFunc
Func najivkaGoroh()
   $naj = PixelSearch(2718,758,2772,809,0x28680B ,30)
   if not(@error) Then
	  Return
   Else
	  SetError(0);
	  mylog('замена наживки горох')
	  MouseClick('left',2718,758,1,10)
	  Sleep(300)
	  $goroh = PixelSearch(2660,446,2685,718,0x387017 ,10)
	  if not(@error) Then
		 MouseClick('left',$goroh[0],$goroh[1],1,10)
	  Else
		 MsgBox(0, "нет нWDаживки", "нет наживки")
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