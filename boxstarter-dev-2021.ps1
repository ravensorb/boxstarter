# 1. Run with this:
<#
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ravensorb/b7a9fefaaa851d4d65da526ca83be2a6/raw/boxstarter-dev-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
#>

New-Item -Path "$env:userprofile\AppData\Local\ChocoCache" -ItemType directory -Force | Out-Null
New-Item -Path "c:\temp" -ItemType directory -Force | Out-Null
#$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
$common = "--cacheLocation='c:\temp'"

cinst powershell-core $common
cinst powershellhere-elevated $common

cinst python2 $common # Required by some NPM/Node packages (eg node-sass)
cinst python3 $common 
cinst pip $common --allow-empty-checksums

# SSMS installer includes azure data studio
# cinst azure-data-studio $common

cinst msbuild-structured-log-viewer $common
cinst nodejs $common
cinst nuget.commandline $common
# cinst NugetPackageExplorer $common # Use Store version

# SQL Server - do this early to avoid issues with newer versions of VC++ 2015 redist
# cinst sql-server-2019  $common
# cinst sql-server-2019-cumulative-update $common
cinst sql-server-management-studio $common

# tools
cinst azure-functions-core-tools-3 $common
cinst becyicongrabber $common
cinst cake-bakery.portable $common
cinst cascadiacodepl $common
cinst 7zip $common
cinst firacode $common
#cinst firefox $common
cinst git $common
cinst nodejs $common
cinst nuget.commandline $common
cinst tortoisegit $common
cinst yarn $common
cinst tailblazer $common --ignore-checksums
cinst azure-cli $common
cinst becyicongrabber $common

# VS Code
cinst vscode-insiders $common
#choco pin add -n=visualstudiocode
cinst vscode-settingssync $common
cinst vscode-icons $common
cinst vscode-gitignore $common
cinst vscode-ansible $common
cinst vscode-python $common
cinst vscode-pylance $common
cinst vscode-yaml $common
cinst vscode-vsonline $common
cinst vscode-intellicode $common
cinst vscode-prettier $common
cinst vscode-powershell $common
cinst vscode-markdown-all-in-one $common
cinst azureaccount-vscode $common

cinst cascadia-code-nerd-font $common

# Visual Studio 2019
cinst visualstudio2022enterprise $common
#choco pin add -n=visualstudio
cinst visualstudio2022-workload-visualstudioextension $common
cinst visualstudio2022-workload-manageddesktop $common
cinst visualstudio2022-workload-netweb $common # ASP.NET and web development
cinst visualstudio2022-workload-netcoretools $common # .NET Core cross-platform development
cinst visualstudio2022-workload-node $common #Node.js development
cinst visualstudio2022-workload-azure $common
cinst visualstudio2022-workload-python $common
cinst visualstudio2022-workload-manageddesktop $common
cinst visualstudio2022-workload-manageddesktopbuildtools $common

# Install after other packages, so integration will work
cinst beyondcompare $common
cinst beyondcompare-integration $common
#cinst vagrant $common # Not sure why, but Boxstarter gets in a loop thinking this fails with 3010 (which should be fine)
cinst vswhere $common

# cinst dotUltimate $common --params "'/NoCpp /NoTeamCityAddin /NoRider'"

cinst nvm $common

# This will conflict with earlier font packages, so make sure it happens after a reboot
cinst FiraCode $common # font

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

Write-BoxstarterMessage "NuGet package provider"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force

Write-BoxstarterMessage "Enable Developer Mode"
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force

    # Add registry value to enable Developer Mode
    New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1

    # Assume if we had to create that then we need to reboot.
    $Boxstarter.RebootOk = $true
    Invoke-Reboot
}

#PowerShell help
Update-Help -ErrorAction SilentlyContinue