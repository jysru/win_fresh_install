### Run as Admin PowerShell ###


## Get Product Key
try {wmic path softwareLicensingService get OA3xOriginalProductKey}
catch {Write-Output "Could not get product key..."}


## Uninstall bloatware
try {
	Get-AppxPackage -name “Microsoft.Music.Preview” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.People” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.WindowsCamera” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.Getstarted” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.Office.OneNote” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.WindowsMaps” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.MicrosoftOfficeHub” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.BioEnrollment” | Remove-AppxPackage
	Get-AppxPackage -name “Microsoft.WindowsPhone” | Remove-AppxPackage
}
catch {
	Write-Output "Some package threw an error... Try different names."
}

try{
	Get-AppxPackage *3dbuilder* | Remove-AppxPackage
	Get-AppxPackage *bing* | Remove-AppxPackage
	Get-AppxPackage *officehub* | Remove-AppxPackage
	Get-AppxPackage *onenote* | Remove-AppxPackage
	Get-AppxPackage *solitairecollection* | Remove-AppxPackage
	Get-AppxPackage *skypeapp* | Remove-AppxPackage
	Get-AppxPackage *xboxapp* | Remove-AppxPackage
	Get-AppxPackage *zune* | Remove-AppxPackage
}
catch {
	Write-Output "Some packages could not be deleted..."
}


## Restore bloatware
# Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}