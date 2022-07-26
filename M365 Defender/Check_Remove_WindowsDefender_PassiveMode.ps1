<#
This script is to verify and change (if exist) the regkey to remove the Windows Defender from Passive Mode.
#>

# Logfile creation
$filename = "WindowsDefenderPassiveModeRemovalLog- "+ (Get-Date -Format "MM-dd-yyyy")
$logfilepath = "C:\Windows\Temp\"+$filename+".log"
if(Test-Path $logfilepath)
{
    Remove-Item $logfilepath
}
New-Item -Path $logfilepath  -ItemType file | Out-Null
Add-Content -Path $logfilepath -Value "Logfile to monitor change for Windows Defender PassiveMode removal."
Add-Content -Path $logfilepath -Value (Get-MpComputerStatus | select AMRunningMode)

# Change regkeys to remove Microsoft Defender from Passive Mode (verify + log actions)
try
    {
    $PM = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\" -Name PassiveMode
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\" -Name PassiveMode -Confirm:$false
    Add-Content -Path $logfilepath -Value "PassiveMode was $($PM), the regkey has been removed."
    }
    catch
    {
    Add-Content -Path $logfilepath -Value "PassiveMode regkey does not exist in this system."
    }


# Change regkeys to remove DisableAntiSpyware settings for Microsoft Defender (verify + log actions)
try
    {
    $AS = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware
    if ($AS -ne 0)
        {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 0
        Add-Content -Path $logfilepath -Value "DisableAntiSpyware Value was $($AS) and is changed to 0."
        }
        else
        {
        Add-Content -Path $logfilepath -Value "DisableAntiSpyware regkey is $($AS) and was not changed."
        }

    }
    catch
    {
        Add-Content -Path $logfilepath -Value "DisableAntiSpyware regkey does not exist."
    }
