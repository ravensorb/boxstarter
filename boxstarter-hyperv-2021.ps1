# 1. Run with this:
<#
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ravensorb/b7a9fefaaa851d4d65da526ca83be2a6/raw/boxstarter-hyperv-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
#>

New-Item -Path "$env:userprofile\AppData\Local\ChocoCache" -ItemType directory -Force | Out-Null
New-Item -Path "c:\temp" -ItemType directory -Force | Out-Null
#$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
#$common = "--cacheLocation='c:\temp'"

# Windows features
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3, Microsoft-Hyper-V-All

Install-WindowsUpdate -AcceptEula -GetUpdatesFromMS
Enable-UAC
