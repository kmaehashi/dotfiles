' UAC Elevator (sudo for Windows)
' @author Kenichi Maehashi

' Usage: cscript //Nologo elevate.vbs command [args...]

Option Explicit

Main

Function Main()
	Dim sh, args, execArgs(), i
	Set sh = CreateObject("Shell.Application")
	Set args = WScript.Arguments

	ReDim execArgs(args.Count - 2)
	For i = 0 To args.Count - 2
		execArgs(i) = args(i + 1)
	Next

	sh.ShellExecute args(0), Join(execArgs, " "), "", "runas"
End Function
