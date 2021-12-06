# 1. Run with this:
<#
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ravensorb/b7a9fefaaa851d4d65da526ca83be2a6/raw/boxstarter-webserver-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
#>

New-Item -Path "$env:userprofile\AppData\Local\ChocoCache" -ItemType directory -Force | Out-Null
New-Item -Path "c:\temp" -ItemType directory -Force | Out-Null
#$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
$common = "--cacheLocation='c:\temp'"

cinst IIS-WebServerRole IIS-NetFxExtensibility45 IIS-HttpCompressionDynamic IIS-WindowsAuthentication IIS-ASPNET45 IIS-IIS6ManagementCompatibility -source windowsfeatures $common

# C:\windows\system32\inetsrv\appcmd.exe unlock config -section:windowsAuthentication
# C:\windows\system32\inetsrv\appcmd.exe unlock config -section:anonymousAuthentication

# Note: There are ususally VS Solution-specific config file in .vs\config\applicationhost.config too
# & "C:\Program Files\IIS Express\appcmd.exe" unlock config -section:windowsAuthentication
# & "C:\Program Files\IIS Express\appcmd.exe" unlock config -section:anonymousAuthentication

