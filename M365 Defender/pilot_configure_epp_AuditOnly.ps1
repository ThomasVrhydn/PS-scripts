#Updated 1/21/2020 by Thorsten Henking
#Update 15/05/2020 by Thomas Verheyden
# Only use for security testing



Set-MpPreference -MAPSReporting Advanced 
Set-MpPreference -SubmitSamplesConsent Always 
Set-MpPreference -DisableBlockAtFirstSeen 0 
Set-MpPreference -DisableIOAVProtection 0 
Set-MpPreference -CloudBlockLevel High
Set-MpPreference -CloudExtendedTimeout 50
Set-MpPreference -DisableRealtimeMonitoring 0
Set-MpPreference -DisableBehaviorMonitoring 0 
Set-MpPreference -DisableScriptScanning 0
Set-MpPreference -DisableRemovableDriveScanning 0
Set-MpPreference -PUAProtection Enabled
Set-MpPreference -DisableArchiveScanning 1
Set-MpPreference -DisableEmailScanning 1
Set-MpPreference -CheckForSignaturesBeforeRunningScan $True

# Extra settings (Thomas Verheyden)
Set-MpPreference -DisableCatchupFullScan 0
Set-MpPreference -SubmitSamplesConsent 3
Set-MpPreference -QuarantinePurgeItemsAfterDelay 90
Set-MpPreference -ScanPurgeItemsAfterDelay 90
Set-MpPreference -ScanScheduleQuickScanTime 24
Set-MpPreference -ScanParameters 2

#Enable controlled folder access

Set-MpPreference -EnableControlledFolderAccess AuditMode

#Enable HIPS Firewall

Set-MpPreference -EnableNetworkProtection Enabled

#Enable exploit protection

Invoke-WebRequest https://demo.wd.microsoft.com/Content/ProcessMitigation.xml -OutFile ProcessMitigation.xml 
Set-ProcessMitigation -PolicyFilePath ProcessMitigation.xml 

#Enable Attack Surface Reduction

Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB933ECF5CB7CC84 -AttackSurfaceReductionRules_Actions AuditMode #Block Office applications from injecting code into other processes
Add-MpPreference -AttackSurfaceReductionRules_Ids 3B576869-A4EC-4529-8536B80A7769E899 -AttackSurfaceReductionRules_Actions AuditMode #Block Office applications from creating executable content
Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EfC-AADCAD5F3C50688A -AttackSurfaceReductionRules_Actions AuditMode #Block Office applications from creating child processes
Add-MpPreference -AttackSurfaceReductionRules_Ids D3E037E1-3EB8-44C8-A91757927947596D -AttackSurfaceReductionRules_Actions AuditMode #Block JavaScript or VBScript from launching downloaded executable content
Add-MpPreference -AttackSurfaceReductionRules_Ids 5BEB7EFE-FD9A-4556-801D275E5FFC04CC -AttackSurfaceReductionRules_Actions AuditMode #Block execution of potentially obfuscated scripts
Add-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E59B1EEEE46550 -AttackSurfaceReductionRules_Actions AuditMode #Block executable content from email client and webmail
Add-MpPreference -AttackSurfaceReductionRules_Ids 92E97FA1-2EDF-4476-BDD69DD0B4DDDC7B -AttackSurfaceReductionRules_Actions AuditMode #Block Win32 API calls from Office macro
Add-MpPreference -AttackSurfaceReductionRules_Ids D1E49AAC-8F56-4280-B9BA993A6D77406C -AttackSurfaceReductionRules_Actions AuditMode #Block process creations originating from PSExec and WMI commands
Add-MpPreference -AttackSurfaceReductionRules_Ids B2B3F03D-6A65-4F7B-A9C71C7EF74A9BA4 -AttackSurfaceReductionRules_Actions AuditMode #Block untrusted and unsigned processes that run from USB
Add-MpPreference -AttackSurfaceReductionRules_Ids C1DB55AB-C21A-4637-BB3FA12568109D35 -AttackSurfaceReductionRules_Actions AuditMode #Use advanced protection against ransomware
Add-MpPreference -AttackSurfaceReductionRules_Ids 01443614-CD74-433A-B99E2ECDC07BFC25 -AttackSurfaceReductionRules_Actions AuditMode #Block executable files from running unless they meet a prevalence, age, or trusted list criteria
Add-MpPreference -AttackSurfaceReductionRules_Ids 9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2 -AttackSurfaceReductionRules_Actions AuditMode #Block credential stealing from the Windows local security authority subsystem (lsass.exe)
Add-MpPreference -AttackSurfaceReductionRules_Ids 26190899-1602-49e8-8b27-eb1d0a1ce869 -AttackSurfaceReductionRules_Actions AuditMode #Block Process creation from Office communication products
Add-MpPreference -AttackSurfaceReductionRules_Ids 7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c -AttackSurfaceReductionRules_Actions AuditMode #Block Adobe reader from creating child processes
Add-MpPreference -AttackSurfaceReductionRules_Ids e6db77e5-3df2-4cf1-b95a-636979351e5b -AttackSurfaceReductionRules_Actions AuditMode #Block persistence through WMI
