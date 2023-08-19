# Bash Bunny WLAN Key Recovery Remote Upload

This Bash Bunny payload acts as a keyboard which then runs a PowerShell script that retrieves Wi-Fi keys and uploads them to a remote listener.
A server hosting a PowerShell script enables much quicker execution due to much less characters needing to be typed.
This streamlined approach ensures efficient and rapid script transfer and execution.
You can also modify the e.ps1 file to launch any PowerShell script you desire.
Bypasses defender.

# Instructions

1) Modify payload.txt, e.ps1, and server.py with your preferred IPs/hostnames and ports.
2) Make sure e.ps1 is in the same folder as server.py.
3) On your listening server: python3 server.py.
4) Install the payload to your preferred switch position and execute the payload.
