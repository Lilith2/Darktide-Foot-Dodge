#include <File.au3>

; Configuration for key press durations (in milliseconds)
Global $CtrlKeyHoldTime = 100 ; Duration to hold CTRL key
Global $PreCtrlDelay = 50     ; Delay before pressing CTRL
Global $PostReleaseDelay = 10 ; Delay after releasing keys to ensure processing

; Target window title (replace with your game's window title)
Global $WindowTitle = "Warhammer 40,000: Darktide" ; e.g., "World of Warcraft", "ELDEN RING"

; Set hotkeys for foot pedal
HotKeySet("{PGUP}", "dodgeLeft")
HotKeySet("{PGDN}", "dodgeRight")
HotKeySet("{HOME}", "dodgeBack")
HotKeySet("{0}", "exitScript") ; Exit hotkey
HotKeySet("{ESC}", "forceRelease") ; Emergency key release

; Function to check if the target window exists
Func CheckWindow()
    If Not WinExists($WindowTitle) Then
        _FileWriteLog(@ScriptDir & "\script.log", "Error: Window '" & $WindowTitle & "' not found")
        Return False
    EndIf
    Return True
EndFunc

; Function to dodge left (A + CTRL)
Func dodgeLeft()
    If Not CheckWindow() Then Return
    
    ; Press A
    ControlSend($WindowTitle, "", "", "{a down}")
    Sleep($PreCtrlDelay)
    
    ; Press CTRL while A is down
    ControlSend($WindowTitle, "", "", "{LCTRL down}")
    Sleep($CtrlKeyHoldTime)
    
    ; Release keys
    ControlSend($WindowTitle, "", "", "{LCTRL up}")
    Sleep($PostReleaseDelay)
    ControlSend($WindowTitle, "", "", "{a up}")
    Sleep($PostReleaseDelay)
    
    _FileWriteLog(@ScriptDir & "\script.log", "Dodge left executed")
EndFunc

; Function to dodge right (D + CTRL)
Func dodgeRight()
    If Not CheckWindow() Then Return
    
    ; Press D
    ControlSend($WindowTitle, "", "", "{d down}")
    Sleep($PreCtrlDelay)
    
    ; Press CTRL while D is down
    ControlSend($WindowTitle, "", "", "{LCTRL down}")
    Sleep($CtrlKeyHoldTime)
    
    ; Release keys
    ControlSend($WindowTitle, "", "", "{LCTRL up}")
    Sleep($PostReleaseDelay)
    ControlSend($WindowTitle, "", "", "{d up}")
    Sleep($PostReleaseDelay)
    
    _FileWriteLog(@ScriptDir & "\script.log", "Dodge right executed")
EndFunc

; Function to dodge back (S + CTRL)
Func dodgeBack()
    If Not CheckWindow() Then Return
    
    ; Press S
    ControlSend($WindowTitle, "", "", "{s down}")
    Sleep($PreCtrlDelay)
    
    ; Press CTRL while S is down
    ControlSend($WindowTitle, "", "", "{LCTRL down}")
    Sleep($CtrlKeyHoldTime)
    
    ; Release keys
    ControlSend($WindowTitle, "", "", "{LCTRL up}")
    Sleep($PostReleaseDelay)
    ControlSend($WindowTitle, "", "", "{s up}")
    Sleep($PostReleaseDelay)
    
    _FileWriteLog(@ScriptDir & "\script.log", "Dodge back executed")
EndFunc

; Emergency key release function
Func forceRelease()
    If Not CheckWindow() Then Return
    
    ; Release all keys
    ControlSend($WindowTitle, "", "", "{a up}")
    ControlSend($WindowTitle, "", "", "{d up}")
    ControlSend($WindowTitle, "", "", "{s up}")
    ControlSend($WindowTitle, "", "", "{LCTRL up}")
    Sleep($PostReleaseDelay)
    
    ; Send ESC to the game to allow menu interaction
    ControlSend($WindowTitle, "", "", "{ESC}")
    Sleep($PostReleaseDelay)
    
    _FileWriteLog(@ScriptDir & "\script.log", "Force release executed and ESC sent to game")
EndFunc

; Function to exit the script
Func exitScript()
    If CheckWindow() Then
        ControlSend($WindowTitle, "", "", "{a up}")
        ControlSend($WindowTitle, "", "", "{d up}")
        ControlSend($WindowTitle, "", "", "{s up}")
        ControlSend($WindowTitle, "", "", "{LCTRL up}")
        Sleep($PostReleaseDelay)
    EndIf
    
    _FileWriteLog(@ScriptDir & "\script.log", "Script terminated")
    Exit
EndFunc

; Notify that the script is running
MsgBox(0, "Script", "Script is running for window '" & $WindowTitle & "'. Press ESC to release keys, Zero to exit.")

; Simple main loop
While 1
    Sleep(100)
WEnd