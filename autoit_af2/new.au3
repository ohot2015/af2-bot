HotKeySet("{f7}","myExit")
HotKeySet("{f5}","stopStart")
HotKeySet("{f3}", 'activW')
Func activW()
   WinActivate("AF2 „емпионы")
EndFunc
Sleep(1000)
WinActivate("AF2 „емпионы")
Sleep(1000)
$kofColor = 2
;попловок
$pcolor = 0x86141C ;
$x1 = 593
$y1 = 415
$x2 = 1094
$y2 = 794
Global $arr[2]
Global $color = 0x000000
; панель лева€ крайн€€ зелена€ точка
$px1 = 453
$py1 = 350
$begin = true;
while(1)
   While($begin)
	  ConsoleWrite('цикл заброса' & @CRLF)
	  Send('t')
	  Sleep(500)
	  ; заброс
	  if (Zabros()) Then
		 while (1)
			ConsoleWrite('цикл ожидание поклевки' & @CRLF)
			Sleep(500)
		    if (Bite()) Then
			   Send("{SPACE}")
			   ConsoleWrite('подсекаю' & @CRLF)
			   if (FishOut()) Then
				  ConsoleWrite('поймал' & @CRLF)
				  Sleep(1000)
				  Send("{SPACE}")
				  ConsoleWrite('забрал рыбу' & @CRLF)
				  Sleep(500)
				  ExitLoop
			   EndIf
			EndIf
		 WEnd
	  EndIf
   WEnd
WEnd
Func FishOut()
   While (1)
	  ;Position:	898, 763
           ;Cursor ID:	0
      ;Color:	0x84DE8C
	  ;зеленый цвет на панели  если он есть значит правильно подсекли
	  Sleep(700)
	  PixelSearch($px1,$py1,$px1+1,$py1+1,'0x34AD1E',2)
	  if (not(@error)) Then
		  MouseClick('left', 946, 504,5)
		 ConsoleWrite('т€ну'& @CRLF)
		 Opt('SendKeyDownDelay', 1500)
		 $key = '{g}'
		 Send($key)
		 Sleep(500)
		 Opt('SendKeyDownDelay', 'default')
	  Else
		 ConsoleWrite('поймал'& @CRLF)
		 Sleep(2000)
		 ExitLoop
	  EndIf
	  SetError(0);
   WEnd
   return true
EndFunc
Func Zabros ()
   Sleep(5000)
   While (1)
	  $arr = PixelSearch($x1,$y1,$x2,$y2, $pcolor, $kofColor)
	  if (@error) Then
		 Sleep(1000)
		 PixelSearch(546,477,546,477,'0x000000', 5)
		 if (not(@error)) Then
			Send("t")
		 EndIf

		 ConsoleWrite($x1&$y1&$x1 + 10&$y1 + 10&$pcolor& @CRLF)
		 ConsoleWrite('забрасываю'& @CRLF)
	     Sleep(500)
	  Else
		 $color = PixelGetColor($arr[0],$arr[1])
		 ConsoleWrite('заброшено'& @CRLF)
		 ExitLoop
	  EndIf
	  SetError(0)
   WEnd
   return true
EndFunc

Func Bite()
   While (1)
	  ConsoleWrite($arr[0] &' ' & $arr[1]& @CRLF)
	  ConsoleWrite($color & ' - '&Hex($color) & @CRLF)
	  PixelSearch($arr[0], $arr[1], $arr[0] + 10,$arr[1]+ 10, $color , 2)
	  if (@error) Then
		 ConsoleWrite('клюнуло'& @CRLF)
	     Sleep(500)
		 SetError(0);
		 ExitLoop
	  Else
		 Sleep(500)
		 ConsoleWrite('не клюет'& ' - '& @error & @CRLF)
	  EndIf
   WEnd
   return true
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
