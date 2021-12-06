# boxstarter
A set of boxstarter scripts to help with getting systems up and running quickly

**Setting up chocolatey and boxstarter**
```
Set-ExecutionPolicy RemoteSigned -Force; if (-not (Test-Path $PROFILE)) { $directory = [IO.Path]::GetDirectoryName($PROFILE); if (-not (Test-Path $directory)) { Write-Host "Creating Profile Directory $directtory"; New-Item -ItemType Directory $directory | Out-Null }; "# Profile" > $PROFILE }; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); choco feature enable -n=allowGlobalConfirmation; choco feature enable -n=useRememberedArgumentsForUpgrades; cinst boxstarter; . $profile
```

---
## [boxstarter-bare-w10.ps1](boxstarter-bare-w10.ps1)
This script setups of a standard Window 10 Client Desktop

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-bare-w10.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---

## [boxstarter-bare-w11.ps1](boxstarter-bare-w11.ps1)
This script setups of a standard Window 11 Client Desktop

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-bare-w11.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---

## [boxstarter-dev-2021.ps1](boxstarter-dev-2021.ps1)
This script adds ontop of the appropriate bare script and adds Visual Studio and VS Code development tools

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-dev-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---

## [boxstarter-docker-2021.ps1](boxstarter-docker-2021.ps1)
This script enables docker on the computer

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-docker-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---

## [boxstarter-hyperv-2021.ps1](boxstarter-hyperv-2021.ps1)
This script enables Hyper-V

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-hyperv-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---

## [boxstarter-webserver-2021.ps1](boxstarter-webserver-2021.ps1)
This script enables IIS

**Running script**
```
Import-Module 'c:\ProgramData\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1'; Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/ravensorb/boxstarter/main/boxstarter-webserver-2021.ps1 -Credential (Get-Credential -Message "Local Login" -UserName $env:USERNAME)
```

---
