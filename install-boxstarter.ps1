param(
   [string] $scriptUrl,
   [string] $gitUserName,
   [string] $gitToken,
   [switch] $enableAuth
)
# 1. Install Boxstarter and execute a specific package
<#
iex "& { $(iwr 'https://raw.githubusercontent.com/ravensorb/boxstarter/main/install-boxstarter.ps1') } -scriptUrl <URL TO RAW SCRIPT> -enableAuth -gitUserName <GIT USER> -gitToken <GIT TOKEN>"

if you are having issues with caching use the following (it avoids using the Invoke-WebRequest cache)
iex "& { $(iwr 'https://raw.githubusercontent.com/ravensorb/boxstarter/main/install-boxstarter.ps1' -Headers @{"Cache-Control"="no-cache"} ) } -scriptUrl <URL TO RAW SCRIPT> -enableAuth -gitUserName <GIT USER> -gitToken <GIT TOKEN>"
#>
# 2. or if you want to use the default bootstrapper use the following script (Note: it does not support accessing private github urls)
<#
. { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force; install-boxstarterpackage -PackgeName <URL TO RAW SCRIPT>
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
    Write-Host "Downloading and executing script: $scriptUrl" -ForegroundColor Green
    Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; 
    
    if (-Not ([string]::IsNullOrEmpty($gitToken))) {        
        $tempScript = "$([System.Environment]::GetEnvironmentVariable('TEMP','Machine'))\boxstarter-install-script.ps1"
        if (Test-Path $tempScript) { Remove-Item $tempScript -Force -ErrorAction SilentlyContinue }

        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScript -Headers @{"Authorization"="Basic $([Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $gitUserName, $gitToken))))"}
        
        $scriptUrl = $tempScript
    }
  
    if ($enableAuth.IsPresent) {
        Install-BoxstarterPackage -PackageName $scriptUrl -Credential (Get-Credential -Message "Local Admin Login" -UserName $env:USERNAME)
    } else {
        Install-BoxstarterPackage -PackageName $scriptUrl
    }
}
