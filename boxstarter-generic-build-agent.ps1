New-Item -Path "$env:userprofile\AppData\Local\ChocoCache" -ItemType directory -Force | Out-Null
New-Item -Path "c:\temp" -ItemType directory -Force | Out-Null
#$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
$common = "--cacheLocation='c:\temp'"

$common = "--cacheLocation=`"$env:userprofile\AppData\Local\ChocoCache`""
choco install bginfo-startup -pre -packageParameters '/RunImmediately'  $common

choco install NetFx3 -source windowsfeatures

choco install dotnetcore-runtime $common
choco install dotnetcore-sdk --version=2.1.302  $common
choco install dotnetcore-sdk --version=2.1.403  $common
choco install git $common
choco install yarn $common

# .NET Framework
choco install dotnet4.5 $common
choco install dotnet4.6 $common
choco install dotnet4.6.1 $common
choco install dotnet4.6.2 $common
choco install dotnet4.7 $common
choco install dotnet4.7.1 $common
choco install dotnet4.7.2 $common
choco install dotnetcore-sdk $common
choco install netfx-4.5.1-devpack $common
choco install netfx-4.5.2-devpack $common
choco install netfx-4.6.1-devpack $common
choco install netfx-4.7-devpack $common
choco install netfx-4.7.1-devpack $common
choco install netfx-4.7.2-devpack $common

# Visual Studio
choco install visualstudio2017buildtools --params "'--add Microsoft.Net.Component.4.5.TargetingPack'" $common
choco pin add -n=visualstudio2017buildtools $common
choco install visualstudio2017-workload-manageddesktop $common
choco pin add -n="visualstudio2017-workload-manageddesktop" $common
choco install visualstudio2017-workload-netcoretools $common
choco pin add -n="visualstudio2017-workload-netcoretools" $common
choco install visualstudio2017-workload-netweb $common
choco pin add -n="visualstudio2017-workload-netweb" $common
choco install visualstudio2017-workload-node $common
choco pin add -n="visualstudio2017-workload-node" $common

# Stop MSBuild processes from hanging around
[Environment]::SetEnvironmentVariable("MSBUILDDISABLENODEREUSE", "1", "Machine") 