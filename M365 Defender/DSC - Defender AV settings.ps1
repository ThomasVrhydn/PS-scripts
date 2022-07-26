<# GE INFO
Get-DscResource -Module WindowsDefender -Syntax
Install-Module -Name WindowsDefender
#>


Configuration MyDSCConfiguration {
# Import DSC modules with resources to use in the configuration: https://www.powershellgallery.com/packages/WindowsDefender/1.0.0.4
    Import-DscResource -ModuleName WindowsDefender   
    

# Create configuration for the server localhost

Node "Localhost" {
WindowsDefender #Config {
AttackSurfaceReductionOnlyExclusions = AuditMode
CheckForSignaturesBeforeRunningScan = $True
CloudBlockLevel = High
CloudExtendedTimeout = 50    
    DisableArchiveScanning = $false
    DisableAutoExclusions = $false
    DisableBehaviorMonitoring = $false
    DisableBlockAtFirstSeen = $false
    DisableCatchupFullScan = $True
    DisableCatchupQuickScan = $false
    DisableEmailScanning = $True
    DisableIntrusionPreventionSystem = $false
    DisableIOAVProtection = $false
    DisableRealtimeMonitoring = $false
    DisableRemovableDriveScanning = $false
    DisableRestorePoint = $True
    DisableScanningMappedNetworkDrivesForFullScan = $false
    DisableScanningNetworkFiles = $false
    DisableScriptScanning = $false
    EnableControlledFolderAccess = AuditMode
    EnableNetworkProtection = AuditMode
    MAPSReporting = Advanced
    RealTimeScanDirection = Both
    RemediationScheduleDay = Everyday
    RemediationScheduleTime = 12:00
    ScanAvgCPULoadFactor = 50
    ScanOnlyIfIdleEnabled = $true
    ScanParameters = QuickScan
    ScanPurgeItemsAfterDelay = 15
    ScanScheduleDay = Wednesday
    ScanScheduleTime = 09:00    
    SignatureScheduleDay =  Everyday
    SignatureUpdateInterval = 1
    SubmitSamplesConsent = Always
}
}
}