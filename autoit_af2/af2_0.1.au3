HotKeySet("{f7}","myExit")
WinActivate("AF2 Чемпионы")
$tianut = true;

While($tianut)
   $p = PixelSearch(825,198,841,228,0x2B2520)
   if not(@error) Then
	  MouseDown('right')
	  Sleep(800)
	  MouseUp('right')
   Else
	  Send("t")
	  Sleep(4000)
   EndIf
WEnd

Func myExit()
   MsgBox(0, "Tutorial", "End bot!")
   Exit
EndFunc