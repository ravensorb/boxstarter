# 1. Install Chocolatey
<#
Set-ExecutionPolicy RemoteSigned -Force

# Create empty profile (so profile-integration scripts have something to append to)
if (-not (Test-Path $PROFILE)) { $directory = [IO.Path]::GetDirectoryName($PROFILE); if (-not (Test-Path $directory)) { Write-Host "Creating Profile Directory $directtory"; New-Item -ItemType Directory $directory | Out-Null }; "# Profile" > $PROFILE }

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation
choco feature enable -n=useRememberedArgumentsForUpgrades

# Copy chocolatey.license.xml to C:\ProgramData\chocolatey\license

choco install boxstarter

#>
# 2. Run with this:
<#
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ravensorb/b7a9fefaaa851d4d65da526ca83be2a6/raw/boxstarter-bare-w11.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
#>

<#
Or all in two lines

Set-ExecutionPolicy RemoteSigned -Force; if (-not (Test-Path $PROFILE)) { $directory = [IO.Path]::GetDirectoryName($PROFILE); if (-not (Test-Path $directory)) { Write-Host "Creating Profile Directory $directtory"; New-Item -ItemType Directory $directory | Out-Null }; "# Profile" > $PROFILE }; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); choco feature enable -n=allowGlobalConfirmation; choco feature enable -n=useRememberedArgumentsForUpgrades; choco install boxstarter; . $profile
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ravensorb/b7a9fefaaa851d4d65da526ca83be2a6/raw/boxstarter-bare-w11.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
#>

# https://github.com/mwrock/boxstarter/issues/241#issuecomment-336028348
New-Item -Path "$env:userprofile\AppData\Local\ChocoCache" -ItemType directory -Force | Out-Null
New-Item -Path "c:\temp" -ItemType directory -Force | Out-Null
#$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
$common = "-y --cacheLocation='c:\temp'"

# NuGet package provider. Do this early as reboots are required

if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Host "Install-PackageProvider"
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers -Confirm:$False
    
    # Exit equivalent
    Invoke-Reboot
}

# Install initial version of PowerShellGet
if (-not (Get-InstalledModule -Name PowerShellGet -ErrorAction SilentlyContinue)) {
    Write-Host "Install-Module PowerShellGet"
    Install-Module -Name "PowerShellGet" -AllowClobber -Force -Scope AllUsers

    # Exit equivalent
    Invoke-Reboot
}

# https://github.com/felixrieseberg/windows-development-environment/blob/master/boxstarter
# https://timdeschryver.dev/blog/how-i-have-set-up-my-new-windows-development-environment-in-2022#install-software-with-winget
# Write-Host "Set-PSRepository"
# Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -Force

## No SMB1 - https://blogs.technet.microsoft.com/filecab/2016/09/16/stop-using-smb1/
Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol

## Terminal
choco install microsoft-windows-terminal
choco install oh-my-posh

## Editors
choco install vscode-insiders -y
choco pin add -n=vscode-insiders
# choco pin add -n="vscode-insiders.install"

## Git
choco install git.install -y --params "'/NoShellIntegration /WindowsTerminalProfile /Symlinks /DefaultBranchName:main /Editor:VisualStudioCodeInsiders'"

# Restart PowerShell / CMDer before moving on - or run
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Windows features
choco install TelnetClient -source windowsfeatures

# Remove unwanted Store apps
Get-AppxPackage Facebook.Facebook | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage TuneIn.TuneInRadio | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MinecraftUWP | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage KeeperSecurityInc.Keeper | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage 2FE3CB00.PicsArt-PhotoStudio | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage 9E2F88E3.Twitter | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *Twitter | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *MarchofEmpires | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name king.com.* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.3DBuilder | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *Bing* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Office.Word | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Office.PowerPoint | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Office.Excel | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name DellInc.PartnerPromo | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Office.OneNote | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.SkypeApp | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.YourPhone | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *XBox* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MixedReality.Portal | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Microsoft3DViewer | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name SpotifyAB.SpotifyMusic | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MSPaint | Remove-AppxPackage -ErrorAction SilentlyContinue # Paint3D

Write-Host "Temp: $($env:temp)"

## PowerShell
choco install powershell-core $common
choco install powershellhere-elevated $common

## Browsers
# choco install microsoft-edge-insider-dev --pre  $common
# choco install microsoft-edge $common
# choco pin add -n=edge

## Common
choco install 7zip $common
# choco install paint.net $common
choco install pingplotter $common
choco install sysinternals $common

choco install rocolatey $common

choco install git $common
# choco install tortoisegit $common
choco install windirstat $common
# choco install PDFXchangeEditor $common --params '"/NoDesktopShortcuts /NoUpdater"'

## Office
# choco install office365business $common --params='/exclude:"Access Groove Lync"'
# choco install microsoft-teams.install $common
# choco pin add -n="microsoft-teams.install" $common

refreshenv

if (Test-PendingReboot) { Invoke-Reboot }

# Hardware Specific
if ((get-wmiobject Win32_ComputerSystem).manufacturer -like "*Dell*") {
    choco install dellcommandupdate-uwp $common
}

if ((get-wmiobject Win32_ComputerSystem).manufacturer -like "*Lenovo*") {
    choco install lenovo-thinkvantage-system-update $common
}

# Install-Module posh-git -AllowPrerelease -Force

## Clean up
Update-ExecutionPolicy RemoteSigned
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableExpandToOpenFolder

## PowerShell help
Update-Help -ErrorAction SilentlyContinue

Enable-RemoteDesktop

## Windows Update
Install-WindowsUpdate -GetUpdatesFromMS

if (Test-PendingReboot) { Invoke-Reboot }

Enable-UAC
