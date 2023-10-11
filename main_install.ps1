### Run as Admin PowerShell ###

## Run Windows cleanup
try{ $PSScriptRoot/windows_cleanup.ps1 }
catch { Write-Output "Error in Windows cleanup script..." }


## Run Chocolatey setup and installs
try { $PSScriptRoot/chocolatey_install.ps1 }
catch { Write-Output "Error in Chocolatey script..." }

## Run Python and Machine Learning installs
## Commented because there are non-automated steps
#try { $PSScriptRoot/python_ml_install.ps1 }
#catch { Write-Output "Error in Python ML script..." }
