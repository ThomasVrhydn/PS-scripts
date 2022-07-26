## Only working on windows server 2016
## Check if defender AV isn't disabled via registery
try{
$val = Get-ItemProperty -Path "hklm:SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction Continue
} Catch{}

if($val.DisableAntiSpyware -eq "1")
{
 set-itemproperty -Path "hklm:SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -value 0
 write-error 'Windows Defender DisableAntispyware removed: OK'
}Else { write-error 'Windows Defender DisableAntispyware not found: OK'}

## Set passive mode

##HKLM\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection
##dword: ForceDefenderPassiveMode = 1

Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection" -Name "ForceDefenderPassiveMode" -Value 1
write-error 'Windows Defender in passive mode active: OK'

$imageName = (Get-ItemPropertyValue -Path:'HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend' -Name:ImagePath) -replace '"', ''
$currentVersion = Get-FileVersion -File:$imageName
if ($currentVersion -lt '4.10.14393.2515') {
 Write-Error 'Windows Defender platform update requirement not met. Please apply the latest cumulative update (LCU) for Windows first. Minimum required is https://support.microsoft.com/en-us/help/4457127' -ErrorAction:Stop
}


$srv=Get-WindowsFeature *Windows-Defender*
if($srv.Installed -eq $true){


}Else{

## CHECK OS version

$OS = get-wmiobject -Class win32_operatingsystem | select-object version
$OS.version 

if($OS.version -eq '10.0.17763'){

## Install Windows defender feature
Install-WindowsFeature -Name Windows-Defender-GUI -NoRestart

} Elsif($OS.version -eq '10.0.14393') {


## Install Windows defender feature
Install-WindowsFeature -Name Windows-Defender -NoRestart
Install-WindowsFeature -Name Windows-Defender-GUI -NoRestart

}
}

## Enable Defender AV back to normal state
cd "C:\Program Files\Windows Defender"
mpcmdrun.exe -wdenable
mpcmdrun.exe -signatureupdate
write-error 'Enable windows defender AV: OK'
