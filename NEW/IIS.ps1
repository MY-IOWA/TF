# 1. Install IIS Web Server (if not already installed)
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# 2. Fetch system and hardware info
$computer = Get-ComputerInfo
$cpu = Get-CimInstance Win32_Processor
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

# 3. Pre-calculate values to ensure clean HTML embedding
$computerName = $computer.CsName
$osName       = $computer.OsName
$osVersion    = $computer.OsVersion
$architecture = $computer.OsArchitecture
$cpuModel     = $cpu.Name
$totalMemory  = [Math]::Round($computer.CsTotalPhysicalMemory / 1GB, 2)
$freeSpace    = [Math]::Round($disk.FreeSpace / 1GB, 2)
$totalSpace   = [Math]::Round($disk.Size / 1GB, 2)

# 4. Format the system details into a clean HTML webpage
$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>System Details</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 40px; background-color: #f5f7fa; color: #333; }
        h2 { color: #0078d4; }
        table { border-collapse: collapse; width: 60%; background: white; box-shadow: 0 4px 6px rgba(0,0,0,0.1); border-radius: 4px; overflow: hidden; }
        th, td { padding: 12px 15px; text-align: left; }
        th { background-color: #0078d4; color: white; text-transform: uppercase; font-size: 14px; }
        tr:nth-child(even) { background-color: #f8f9fa; }
        tr:hover { background-color: #f1f3f5; }
        td:first-child { font-weight: bold; color: #555; width: 35%; }
    </style>
</head>
<body>
    <h2>Azure Windows VM - System Details</h2>
    <table>
        <tr><th>System Property</th><th>Value</th></tr>
        <tr><td>Computer Name</td><td>$computerName</td></tr>
        <tr><td>Operating System</td><td>$osName</td></tr>
        <tr><td>OS Version</td><td>$osVersion</td></tr>
        <tr><td>Architecture</td><td>$architecture</td></tr>
        <tr><td>CPU Model</td><td>$cpuModel</td></tr>
        <tr><td>Total Memory</td><td>$totalMemory GB</td></tr>
        <tr><td>C: Drive Free Space</td><td>$freeSpace GB / $totalSpace GB</td></tr>
    </table>
</body>
</html>
"@

# 5. Overwrite the default IIS landing page
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html -Force

# 6. Ensure the web service is running and listening on port 80
Restart-Service w3svc
