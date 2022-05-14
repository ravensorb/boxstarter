param(
   [string] $scriptUrl,
   [bool] $enableAuth = $false
)
# 1. Install Chocolatey
<#
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ravensorb/boxstarter/main/install-boxstarter.ps1'))
#>
Set-ExecutionPolicy RemoteSigned -Force

# Create empty profile (so profile-integration scripts have something to append to)
if (-not (Test-Path $PROFILE)) { $directory = [IO.Path]::GetDirectoryName($PROFILE); if (-not (Test-Path $directory)) { Write-Host "Creating Profile Directory $directtory"; New-Item -ItemType Directory $directory | Out-Null }; "# Profile" > $PROFILE }

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation
choco feature enable -n=useRememberedArgumentsForUpgrades

# Copy chocolatey.license.xml to C:\ProgramData\chocolatey\license
cinst boxstarter

if (-Not ([string]::IsNullOrEmpty($scriptUrl))) {
  Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; 
  
  if ($enableAuth) {
    Install-BoxstarterPackage -PackageName $scriptUrl -Credential (Get-Credential -Message "Local Admin Login" -UserName $env:USERNAME)
  } else {
    Install-BoxstarterPackage -PackageName $scriptUrl
  }
}
