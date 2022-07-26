Connect-AzAccount

$Extensions = Get-AzVMExtension -ResourceGroupName "rg-sw-thomasv-tst-01" -VMName "VMThomas" 

$Extensions.ProtectedSettings -eq "Succeeded"


