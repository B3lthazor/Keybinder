;@Ahk2Exe-SetMainIcon favicon.ico
#NoEnv
#SingleInstance force
#Warn
#IfWinActive ahk_exe gta_sa.exe 
#Hotstring EndChars `n
SetWorkingDir, %A_MyDocuments%\LSPD-Hotkey\

IfNotExist, %A_MyDocuments%\LSPD-Hotkey\
{
FileCreateDir, %A_MyDocuments%\LSPD-Hotkey\
}



;			///  Changelog  /// 


IniRead, Changelog , Settings.ini, Changelog, Changelog
If (Changelog="ERROR") OR (Changelog="0")
{
Changelogshow()
return
}

Changelogshow()
	{	
		
	global Changelog := 1

	IniWrite, %Changelog%, Settings.ini, Changelog, Changelog
	Gui, show, x200 w50 h30, Changelog

	Gui, Add, Text,, v0.6
	Gui, Add, Text,, ingame Menüs laufen flüssiger bei /ow,/gf,/gps
	Gui, Add, Text,, GPS-Funktion eingefügt
	Gui, Add, Text,, Backend überarbeitet
	Gui, Add, Text,, /DM entfernt, /ATT jetzt auch für mehrere IDs
	Gui, Add, Text,, /GF für Geisterfahrt hinzugefügt
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,,  
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 
;	Gui, Add, Text,, 

	Gui, Add, Button, x100 w140 h20, OK
	Gui, show, AutoSize Center
	return
		
	ButtonOK:
	Gui, Destroy
	Gosub, Continue
	return
	}

Continue:



;			///  Updater  /// 

;Version = 0.6
;IfExist update.bat
;{
;FileDelete update.bat
;FileDelete version.txt
;}
;UrlDownloadToFile https://raw.githubusercontent.com/B3lthazor/Keybinder/main/version.txt, version.txt

;FileReadLine, NewestVersion, version.txt, 1,
;if (Version < NewestVersion)
;{
;	MsgBox, 4,, Es ist eine neue Version verfügbar, v%NewestVersion%. Update starten?
;	IfMsgBox, Yes
;	{
;		IniWrite, 0, Settings.ini, Changelog, Changelog
;		UrlDownloadToFile https://github.com/B3lthazor/Keybinder/raw/main/LSPD.exe, %A_ScriptDir%\%A_ScriptName%.new
;		UpdateBat=
;			(
;				Ping 127.0.0.1
;				Del "%A_ScriptDir%\%A_ScriptName%"
;				Rename "%A_ScriptDir%\%A_ScriptName%.new" "%A_ScriptName%"
;				cd "%A_ScriptFullPath%"
;				"%A_ScriptName%"
;			)
;		FileAppend, %UpdateBat%, update.bat
;		MsgBox, Update bereit, zum Starten auf OK klicken
;		Run, update.bat,, hide
;		ExitApp
;	}
;}
;FileDelete version.txt


;			///  Timer  ///

Settimer, 1000ms, 1000

;			///  Variablen ///
sec := 0
min := 0
bind := []
key := []
CountKey := []
CountStart := []
CountEnde := []
CountTime := []
Bindtemp := ""
Keytemp := ""
afkon := 1






; 			///  Keybinds-Laden  ///
Loop 12
  {
  	IniRead, Keytemp , Settings.ini, binds, Hotkey%A_Index%
	key[A_Index] := Keytemp
	
	if(key[A_Index] != "" && key[A_Index] != "ERROR")
	{
	Hotkey, % key[A_Index] , EigenerHotkey%A_Index%
	}
	
  	IniRead, Bindtemp , Settings.ini, binds, bind%A_Index%
	bind[A_Index] := Bindtemp
	if(bind[A_Index] = "ERROR" OR bind[A_Index] = "")
	{
	bind[A_Index] := "Füge hier einen Befehl ein"
	}
  }

Loop 2
{
	IniRead, CountTemp, Settings.ini, CountDown, CountHotkey%A_Index%
	CountKey[A_Index] := CountTemp
	
	if(CountKey[A_Index] != "" && CountKey[A_Index] != "ERROR")
	{
	Hotkey, % CountKey[A_Index], Countdown%A_Index%
	}
	
	
	IniRead, CountTemp, Settings.ini, CountDown, CountDownStart%A_Index%
	CountStart[A_Index] := CountTemp
	
	if(CountStart[A_Index] = "ERROR" OR CountStart[A_Index] = "")
	{
	CountStart[A_Index] := "Start-Message"
	}
	
	
	IniRead, CountTemp, Settings.ini, CountDown, CountDownEnde%A_Index%
	CountEnde[A_Index] := CountTemp
	
	if(CountEnde[A_Index] = "ERROR" OR CountEnde[A_Index] = "")
	{
	CountEnde[A_Index] := "End-Message"
	}
	
	
	IniRead, CountTemp, Settings.ini, CountDown, CountTimer%A_Index%
	CountTime[A_Index] := CountTemp

	if(CountTime[A_Index] = "ERROR" OR CountTime[A_Index] = "")
	{
	CountTime[A_Index] := "Dauer in Sek"
	}
	
}

IniRead, Pfeilhoch, Settings.ini, Optionen, Pfeil1
if (Pfeilhoch="ERROR")
Pfeilhoch := "Up"
IniRead, Pfeilrunter, Settings.ini, Optionen, Pfeil2
if (Pfeilrunter="ERROR")
Pfeilrunter := "Down"
IniRead, Pfeilrechts, Settings.ini, Optionen, Pfeil3
if (Pfeilrechts="ERROR")
Pfeilrechts := "Right"
IniRead, Pfeillinks, Settings.ini, Optionen, Pfeil4
if (Pfeillinks="ERROR")
Pfeillinks := "Left"

IniRead, afkon, settings.ini, AFK, AFK
if(afkon="ERROR")
IniWrite, 1, settings.ini, AFK, AFK

IniRead, Fraktion, Settings.ini, Optionen, Fraktion
if(Fraktion = "ERROR" OR Fraktion = "")
{
InputBox, Fraktion , Fraktion, In welcher Fraktion bist du?,, 250, 130
IniWrite, %Fraktion%, Settings.ini, Optionen, Fraktion
}
 
 
;			///  GUI  /// 

IfNotExist, keybinder.jpg
UrlDownloadToFile https://i.imgur.com/yzPHtr5.png, keybinder.png

Gui, show, w850 h500, LSPD Keybinder
Gui, add, Picture, x175 y10 w500 h-1, keybinder.png

Gui, Add, Tab3, x25 y190 w800 h305, Keybinds|CountDown|Funktionen|Optionen

Gui, add, Hotkey, x50 y230 w110 vHotkey1, % key[1]
Gui, Add, Edit, x170 y230 w220 h20 vbind1, % bind[1]
Gui, add, Hotkey, x50 y270 w110 vHotkey2, % key[2]
Gui, Add, Edit, x170 y270 w220 h20 vbind2, % bind[2]
Gui, add, Hotkey, x50 y310 w110 vHotkey3, % key[3]
Gui, Add, Edit, x170 y310 w220 h20 vbind3, % bind[3]
Gui, add, Hotkey, x50 y350 w110 vHotkey4, % key[4]
Gui, Add, Edit, x170 y350 w220 h20 vbind4, % bind[4]
Gui, add, Hotkey, x50 y390 w110 vHotkey5, % key[5]
Gui, Add, Edit, x170 y390 w220 h20 vbind5, % bind[5]
Gui, add, Hotkey, x50 y430 w110 vHotkey6, % key[6]
Gui, Add, Edit, x170 y430 w220 h20 vbind6, % bind[6]

Gui, add, Hotkey, x450 y230 w110 vHotkey7, % key[7]
Gui, Add, Edit, x570 y230 w220 h20 vbind7, % bind[7]
Gui, add, Hotkey, x450 y270 w110 vHotkey8, % key[8]
Gui, Add, Edit, x570 y270 w220 h20 vbind8, % bind[8]
Gui, add, Hotkey, x450 y310 w110 vHotkey9, % key[9]
Gui, Add, Edit, x570 y310 w220 h20 vbind9, % bind[9]
Gui, add, Hotkey, x450 y350 w110 vHotkey10, % key[10]
Gui, Add, Edit, x570 y350 w220 h20 vbind10, % bind[10]
Gui, add, Hotkey, x450 y390 w110 vHotkey11, % key[11]
Gui, Add, Edit, x570 y390 w220 h20 vbind11, % bind[11]
Gui, add, Hotkey, x450 y430 w110 vHotkey12, % key[12]
Gui, Add, Edit, x570 y430 w220 h20 vbind12, % bind[12]

Gui, Add, Button, x350 y470 w140 h20 gSave, Speichern


; 			/// CountDownGUI ///
Gui, Tab, 2
Gui, add, Text, x50 y230, Hotkey
Gui, add, Hotkey, x50 y250 w110 vCountHotkey1, % CountKey[1]
Gui, add, Text, x170 y230, Dauer
Gui, add, Edit, x170 y250 w110 vCountTimer1, % CountTime[1]
Gui, add, Text, x50 y280, Start-Message
Gui, Add, Edit, x50 y300 w220 h20 vCountDownStart1, % CountStart[1]
Gui, add, Text, x50 y335, End-Message
Gui, Add, Edit, x50 y355 w220 h20 vCountDownEnde1, % CountEnde[1]

Gui, add, Text, x450 y230, Hotkey
Gui, add, Hotkey, x450 y250 w110 vCountHotkey2, % CountKey[2]
Gui, add, Text, x570 y230, Dauer
Gui, add, Edit, x570 y250 w110 vCountTimer2, % CountTime[2]
Gui, add, Text, x450 y280, Start-Message
Gui, Add, Edit, x450 y300 w220 h20 vCountDownStart2, % CountStart[2]
Gui, add, Text, x450 y335, End-Message
Gui, Add, Edit, x450 y355 w220 h20 vCountDownEnde2, % CountEnde[2]


Gui, Add, Button, x350 y470 w140 h20 gSave, Speichern

; 			/// FunktionenGUI ///
Gui, Tab, 3
Gui, Font, s10 Bold
Gui, add, Text, x50 y230, /ww
Gui, add, Text, x50 y270, /fl
Gui, add, Text, x50 y310, /att
Gui, add, Text, x50 y350, /c
Gui, add, Text, x50 y390, /fb
Gui, add, Text, x50 y430, /kit

Gui, add, Text, x450 y230, /afk
Gui, add, Text, x450 y310, /gf
Gui, add, Text, x450 y350, /gps
Gui, add, Text, x450 y390, /uc


Gui, Font, s10 normal
Gui, add, Text, x125 y230 w250, Waffen runter!
Gui, add, Text, x125 y270 w250, Flucht-Wanteds; Chat-Aufforderung für ID
Gui, add, Text, x125 y310 w250, Attack-Wanteds; Chat-Aufforderung für ID
Gui, add, Text, x125 y350 w250, Clear Wanteds; 1.Chat-Eingabe für ID, 2. Chat-Eingabe für Grund
Gui, add, Text, x125 y390 w250, Fluchtbeihilfe-Wanteds ; Chat-Aufforderung für ID
Gui, add, Text, x125 y430 w250, Reparatur-Kit verwenden

Gui, add, Text, x525 y230 w250, AFK-Timer de/aktivieren
Gui, add, Text, x525 y250 w250, Gibt eine AFK Warnung aus, wenn man 9,5 min auf dem Desktop ist
Gui, add, Text, x525 y310 w250, Vergibt 6 Punkte für Geisterfahrt
Gui, add, Text, x525 y350 w250, Markiert Ziele [FIB,WT,...]
Gui, add, Text, x525 y390 w250, /undercover



; 			/// Optionen ///
Gui, Tab, 4

Gui, add, Text, x50 y230, Einstellung für Navigation in Menüs
Gui, add, Text, x50 y250, Falls ingame Einstellung abgeändert wurde, bitte anpassen
Gui, add, Text,x50 y300, Hoch
Gui, add, Text,x50 y340, Runter
Gui, add, Text,x50 y380, Rechts
Gui, add, Text,x50 y420, Links

Gui, add, Hotkey, x125 y300 w110 vPfeilhoch, %Pfeilhoch%
Gui, add, Hotkey, x125 y340 w110 vPfeilrunter, %Pfeilrunter%
Gui, add, Hotkey, x125 y380 w110 vPfeilrechts, %Pfeilrechts%
Gui, add, Hotkey, x125 y420 w110 vPfeillinks, %Pfeillinks%

Gui, add, Text,x450 y230, Fraktion
Gui, Add, Edit, x510 y230 w220 h20 vFraktion, %Fraktion%

Gui, Add, Button, x350 y470 w140 h20 gSave, Speichern

return



;			///  Save  /// 
  
Save: 
Gui, Submit, NoHide
Loop 12
{
	Keytemp := Hotkey%A_Index%
	IniWrite, %Keytemp%, Settings.ini, binds, Hotkey%A_Index%
	
	Bindtemp := bind%A_Index%
	IniWrite, %Bindtemp%, Settings.ini, binds, bind%A_Index%
}

IniWrite, %Pfeilhoch%, Settings.ini, Optionen, Pfeil1
IniWrite, %Pfeilrunter%, Settings.ini, Optionen, Pfeil2
IniWrite, %Pfeilrechts%, Settings.ini, Optionen, Pfeil3
IniWrite, %Pfeillinks%, Settings.ini, Optionen, Pfeil4
IniWrite, %Fraktion%, Settings.ini, Optionen, Fraktion

IniWrite, %CountHotkey1%, Settings.ini, CountDown, CountHotkey1
IniWrite, %CountHotkey2%, Settings.ini, CountDown, CountHotkey2
IniWrite, %CountDownStart1%, Settings.ini, CountDown, CountDownStart1
IniWrite, %CountDownStart2%, Settings.ini, CountDown, CountDownStart2
IniWrite, %CountDownEnde1%, Settings.ini, CountDown, CountDownEnde1
IniWrite, %CountDownEnde2%, Settings.ini, CountDown, CountDownEnde2
IniWrite, %CountTimer1%, Settings.ini, CountDown, CountTimer1
IniWrite, %CountTimer2%, Settings.ini, CountDown, CountTimer2


Sleep 1000
return

;			///  GUI Close  ///

GUIclose:
ExitApp
return



;			///  AHK de/aktivieren  /// 

~t::							;AHK deaktivert bei offenem Chatfenster
Suspend On
Hotkey, Enter, On
Hotkey, Escape, On
Hotkey, t, Off
return

~NumpadEnter::
~Enter::
Suspend Permit
Suspend Off
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return

~Escape::
Suspend Permit
Suspend Off
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return



;			///  Timer  /// 

1000ms:							;Timer 1Sekunde

if(afkon = 1)
{
afk()
}
return



;			///  Funktionen  /// 

Eingabe()
{
	Input Eingabe, V I M T15,{enter}									;Keystroke wird in Eingabe gespeichert
	if (ErrorLevel = "Timeout" OR IDWa="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}	
	SendInput {end}+{home}{Del}{esc} 									;Löscht ChatZeile
	return Eingabe
}

afk() 							;AFK-Timer
{
	global min
	global sec
	if (WinExist("ahk_exe gta_sa.exe")) 
	{
		if (WinActive("ahk_exe gta_sa.exe")) 
		{
			min := 0
			sec := 0
		} 
		else 
		{
			if (sec == 60) 
			{
				min++
				sec := 0
			}
			if (min = 9) && (sec = 45)
			{
				TrayTip, LSPD Keybinder, % "LoG AFK Warnung!", 5, 1
			}
		}
		sec++
	}
	return
}

afkon()
{
	Suspend Permit
	global afkon
	if(afkon = 1)
	{
		afkon := 0
		SendInput /AFK-Timer_deaktiviert
	}
	else if(afkon = 0)
	{
		afkon := 1
		SendInput /AFK-Timer_aktiviert
	}
	IniWrite, %afkon%, settings.ini, AFK, AFK
}


;checkpoint()
;{
;	Suspend Permit
;	sleep 350
;	Send t
;	Sleep 100
;	SendInput GPS-Ziel:{Space}
;	Input GPSZiel, V I M T15,{enter}	
;	if (ErrorLevel = "Timeout" OR GPSZiel="")
;	{
;		SendInput {end}+{home}{Del}{esc}
;		SendInput {enter}
;		return
;	}
;	sleep 750
;	Send {ESC}
;	sleep 1000
;	send {enter}
;	sleep 500
;	PixelGetColor, MarkerFarbe, 1873, 81
;	if(MarkerFarbe = "0xF14BA3")
;	{
;		Send {ESC}
;
;		Sleep 1000
;		return
;	}
;	switch GPSZiel
;	{
;		case "FIB":
;		{
;			send {Click 1850 600}
;			send {enter}
;			sleep 500
;			send {ESC}
;			sleep 250
;			send {ESC}
;		}
;		case "WT":
;		{
;			Send {UP}
;			sleep 250
;			Click 1850 400 2			;Pilot Anfänger
;			sleep 250
;			Click 1335 435 
;			sleep 100
;			Click 1335 435 3
;		}
;	}
;	return
;}



;Gurt()
;{
;	Suspend Permit
;	PixelGetColor, MotorFarbe, 658, 1062							;Farbe des Motorsymbols abfragen
;	if(MotorFarbe = "0x1919BC" OR  MotorFarbe = "0x2AD468")			;Wenn bereits im Fahrzeug wird Funktion beendet
;	{
;		return
;	}
;	
;	while(MotorFarbe != "0x1919BC" AND MotorFarbe != "0x2AD468")		;Warte bis Motorsymbol angezeigt wird
;	{	
;		PixelGetColor, MotorFarbe, 658, 1062
;		sleep 1000
;		if(A_Index = 8)												;Nach 10 Durchläufen/1Sekunde abbrechen
;		{
;			return
;		}
;	}
;	Sleep 2000 														;Zeit für Durchrutschen
;	SendInput Z
;	PixelGetColor, KeyFarbe, 945, 827
;	while(KeyFarbe != "0xFFFFFF")									;Sleep bis FahrzeugMenü offen ist
;	{
;		Sleep 100
;		PixelGetColor, KeyFarbe, 945, 827
;		if(A_Index = 10)											;Nach 10 Durchläufen/1Sekunde abbrechen
;		{
;			return
;		}
;	}
;	Click, 820 850
;	return
;}
;0x1919BC Motor aus
;0x2AD468 Motor an


;OnlineWanted() //nur GTA5
;{
;	Suspend Permit
;	global Pfeilrunter
;	Sleep 200
;	Send {Right}
;	PixelGetColor, MenuFarbe, 11, 289
;	while(MenuFarbe != "0xFFFFFF")
;	{
;		sleep 100
;		PixelGetColor, MenuFarbe, 11, 289
;		if(A_Index = 10)											;Nach 10 Durchläufen/1Sekunde abbrechen
;		{
;			return
;		}
;	}
;	Send {%Pfeilrunter%}
;	Send {%Pfeilrunter%}
;	PixelGetColor, MenuFarbe, 42, 473
;	while(MenuFarbe != "0x000000")
;	{
;		sleep 100
;		PixelGetColor, MenuFarbe, 42, 473
;		if(A_Index = 10)											;Nach 10 Durchläufen/1Sekunde abbrechen
;		{
;			return
;		}
;	}
;	Send {enter}
;}


;				///Wanted-Vergabe///

Flucht()
{
	sleep 350
	Send t
	Sleep 100
	SendInput ID des Täters:{Space}
	Input IDWa, V I M T15,{enter}								;Keystroke wird in IDWa gespeichert
	if (ErrorLevel = "Timeout" OR IDWa="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}
	SendInput {end}+{home}{Del}{esc} 
	sleep 350
	SendInput t/wa %IDWa% 3  Flucht
}

Fluchtbeihilfe()
{
	sleep 350
	Send t
	Sleep 100
	SendInput ID des Täters:{Space}	
	Input IDWa, V I M T15,{enter}								;Keystroke wird in IDWa gespeichert
	if (ErrorLevel = "Timeout" OR IDWa="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}								
	SendInput {end}+{home}{Del}{esc} 							;Löscht ChatZeile
	sleep 350
	SendInput t/wa %IDWa% 4  Fluchtbeihilfe
}

Attack()
{
	Sleep 350
	Send t
	Sleep 100
	SendInput IDs der Täter:{Space}
	Input IDWa, V I M T15,{enter}	
	AttWa := StrSplit(IDWa, A_Space)
	if (ErrorLevel = "Timeout" OR IDWa="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}
	SendInput {end}+{home}{Del}{esc} 
	sleep 350
	for index, element in AttWa
	{
		WaTemp := AttWa[A_Index]
		Sleep 350
		SendInput t/wa %WaTemp% 4  Eröffnung einer Kampfsituation {enter}
		sleep 350
	}
}

Clear()
{
	Suspend Permit
	sleep 350
	Send t
	Sleep 100
	SendInput IDs der zu clearenden Wanteds:{Space}
	Input IDCL, V I M T15,{enter}	
	SendInput {end}+{home}{Del}{esc} 							;Löscht Chatzeile
	CLWa := StrSplit(IDCL, A_Space)	
	if (ErrorLevel = "Timeout" OR CLWA="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}
	sleep 350
	SendInput tGrund:{Space}
	Input Grund, V I M,{enter}	
	SendInput {end}+{home}{Del}{esc} 							;Löscht Chatzeile
	sleep 350
	for index, element in ClWa
	{
		ClTemp := ClWa[A_Index]
		SendInput t/clear %ClTemp% %Grund% {enter}
		sleep 350
	}
}

Geisterfahrt()
{
	Suspend Permit
	global Pfeilrunter
	sleep 350
	Send t
	Sleep 100
	SendInput ID des Täters:{Space}	
	Input IDGf, V I M T15,{enter}									;Keystroke wird in IDGf gespeichert
	if (ErrorLevel = "Timeout" OR IDGf="")
	{
		SendInput {end}+{home}{Del}{esc}
		SendInput {enter}
		return
	}								
	SendInput {end}+{home}{Del}{esc} {enter}						;Löscht ChatZeile
	Sleep 200
	Send {Right}
	PixelGetColor, MenuFarbe, 11, 289
	while(MenuFarbe != "0xFFFFFF")
	{
		sleep 100
		PixelGetColor, MenuFarbe, 11, 289
	}
	Send {%Pfeilrunter%}
	Send {%Pfeilrunter%}
	PixelGetColor, MenuFarbe, 42, 473
	while(MenuFarbe != "0x000000")
	{
		sleep 100
		PixelGetColor, MenuFarbe, 42, 473
	}
	Send {enter}
}

;			///  HotKeys  /// 


;~F::
;Gurt()
;return



;			///  HotStrings  /// 


;:?:t/gps::													
;Suspend Permit
;checkpoint()
;return


:?:t/pixel::
Suspend Permit
Sleep 5000
PixelGetColor, PixelTest, 1873, 81
Sleep 5000
SendInput %PixelTest%
return


:?:t/version::
Suspend Permit
sleep 350
SendInput t%version% %newestversion%
return



:?:t/afk::													;AFK-Timer de/aktivieren
afkon()
return
 

;:?:t/ow::													;Öffne Verbrecherliste
;OnlineWanted()
;return


;			///  Chat-Ausgaben  ///


:?:t/ww::										
Suspend Permit
SendInput /s Nehmen Sie sofort die Waffe runter{!}
return

:?:t/uc::										
Suspend Permit
Sleep 350
SendInput t/undercover {enter}
return

:?:t/kit::										
Suspend Permit
SendInput /item 128 1
return

;:?:t/m1::   //Funktion für GTA 5
;Suspend Permit
;sleep 350
;SendInput t
;Sleep 100
;SendInput /m STOP{!} %Fraktion%{!} {enter}
;return

;:?:t/m2::   //Funktion für GTA 5
;Suspend Permit
;sleep 350
;SendInput t
;Sleep 100
;SendInput /m %Fraktion%{!} HALTEN SIE SOFORT AN{!} {enter}
;return

;:?:t/m3::   //Funktion für GTA 5
;Suspend Permit
;sleep 350
;SendInput t
;Sleep 100
;SendInput /m Allgemeine Verkehrskontrolle{!} Fahren Sie rechts ran{!} {enter}
;return


;			///  Wanteds/Punkte  ///


:?:t/fl::													;Flucht Wanteds
Suspend Permit
Flucht()
return

:?:t/fb::													;Fluchtbeihilfe-Wanteds
Suspend Permit
Fluchtbeihilfe()
return

:?:/att::											;Attack-Wanteds 
Suspend Permit
Attack()
return

:?:t/c::													;Mehrere Personen clearen
Suspend Permit
Clear()
return

:?:t/gf::
Suspend Permit
Geisterfahrt()
return

;			///  Auskommentiertes, vielleicht nochmal nützlich  /// 


;:?:t/vk::
;Suspend Permit
;sleep 100
;Suspend On
;SendInput tID:{Space}
;Input IDVK, V I M,{enter}
;SendInput {end}+{home}{Del}{esc}
;Suspend Off
;sleep 100
;SendInput tFahrzeug:{Space}
;Input FahrzeugVK, V I M,{enter}
;SendInput {end}+{home}{Del}{esc}
;Zone := getPlayerZone()
;VKName := getPlayerNameById(IDVK)
;if(FahrzeugVK = "" || FahrzeugVK = "t")
;	SendChat("/d VK | N: " VKName " | P: " Zone)
;else
;	SendChat("/d VK | N: " VKName " | F: " FahrzeugVK " | P: " Zone)
;return

;:?:t/2::
;Suspend Permit
;#Warn All, Off
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;aktPos()
;global mpos
;SendChat("/d " UCode " Code 2 - akt. Pos: " mpos)
;return

;:?:t/3::
;Suspend Permit
;#Warn All, Off
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;aktPos()
;global mpos
;SendChat("/d " UCode " Code 3 - akt. Pos: " mpos)
;return

;:?:t/4::
;Suspend Permit
;#Warn All, Off
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;aktPos()
;global mpos
;SendChat("/d " UCode " Code 4 - akt. Pos: " mpos)
;return

;:?:t/8::
;Suspend Permit
;#Warn All, Off
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;aktPos()
;global mpos
;SendChat("/d " UCode " Code 8 (Brand) - " mpos " - Feuerwehr benötigt")
;return

;:?:t/6::
;Suspend Permit
;#Warn All, Off
;global UCode
;aktPos()
;global mpos
;if(UCode != "")
;	{
;	SendChat("/d " UCode " Code 6 - Pos: " mpos)
;	}
;else
;	SendChat("/d Code 6 - Pos: " mpos)
;return

;:?:t/50::
;Suspend Permit
;sleep 100
;Suspend On
;SendInput tID-Code:{Space}
;Input WaID, V I M,{enter}
;SendInput {end}+{home}{Del}{esc}
;WaName := getPlayerNameById(WaID)
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;Suspend Off
;SendChat("/d " UCode " SU-" WaID " (" WaName ") - Code 50")
;return


;:?:t/51::
;Suspend Permit
;sleep 100
;Suspend On
;SendInput tID-Code:{Space}
;Input WaID, V I M,{enter}
;SendInput {end}+{home}{Del}{esc}
;WaName := getPlayerNameById(WaID)
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;Suspend Off
;SendChat("/d " UCode " SU-" WaID " (" WaName ") - Code 51")
;return

;:?:t/77::
;Suspend Permit
;#Warn All, Off
;global UCode
;if (UCode = "")
;	{
;	Suspend On
;	sleep 100
;	SendInput tUnit-Code:{Space}
;	Input UCode, V I M,{enter}
;	SendInput {end}+{home}{Del}{esc}
;	UCode := "[" UCode "]"
;	global UCode := UCode
;	Suspend Off
;	}
;aktPos()
;global mpos
;SendChat("/d " UCode " Code 77 (Bombe) - " mpos)
;return


;aktPos()
;global mpos
;global UCode
;if(UCode != "")
;	{
;	SendChat("/d " UCode " Verdächtiger bei " mpos ", " Richtung)
;	}
;else
;	SendChat("/d Verdächtiger in " mpos ", " Richtung)
;return


;Numpad3::
;NumpadPgDn::
;if(isPlayerInAnyVehicle() == true)
;	{
;		if Instr(chatAkt, "STOP Los Santos Police Department!")
;		{
;		SendChat("/m LSPD! Halten Sie sofort an!")
;		}
;		else
;		{
;		SendChat("/m STOP Los Santos Police Department!")
;		}
;	}
;else if Instr(chatAkt, "LSPD! Auf den Boden")
;	{
;	SendChat("/s Runter! Sofort! (/hup)")
;	}
;	else if Instr(chatAkt, "Runter! Sofort! (/hup)")
;		{
;		SendChat("/s Auf den Boden, verdammt! Letzte Warnung! (/hup)")
;		}
;		else
;			Sendchat("/s LSPD! Auf den Boden und Hände hinter den Kopf (/hup)")
;return



;			///  Hotkeys  /// 


EigenerHotkey1:
bindtemp := % bind[1]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey2:
bindtemp := % bind[2]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey3:
bindtemp := % bind[3]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey4:
bindtemp := % bind[4]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey5:
bindtemp := % bind[5]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey6:
bindtemp := % bind[6]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey7:
bindtemp := % bind[7]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey8:
bindtemp := % bind[8]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey9:
bindtemp := % bind[9]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey10:
bindtemp := % bind[10]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey11:
bindtemp := % bind[11]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return
EigenerHotkey12:
bindtemp := % bind[12]
SendInput {Raw} t%bindtemp%
SendInput {enter}
return


;			///  Countdowns  /// 

CountDown1:
CountTemp := % CountStart[1]
SendInput {Raw} t%CountTemp%
SendInput {enter}
sleep 250
CountTimeTemp := % CountTime[1]
while(CountTimeTemp > 0)
{
SendInput t   >> %CountTimeTemp% <<{enter}
Sleep 1000
CountTimeTemp := CountTimeTemp-1
}
CountTemp := % CountEnde[1]
SendInput {Raw} t%CountTemp%
SendInput {enter}
return


CountDown2:
SendInput %CountDown2Start%
while(Counttime > 0)
{
SendInput %CountTime%
Sleep CountTime*1000
CountTime := CountTime-1
}
SendInput %CountDown2Ende%
return

#IfWinActive ahk_exe gta_sa.exe