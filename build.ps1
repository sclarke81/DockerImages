$serverVersion = 'ltsc2016'
.\openjdk\build.ps1 -ServerVersion $serverVersion
.\jira\build.ps1 -ServerVersion $serverVersion
