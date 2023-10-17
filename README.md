# Fresh install summary

- ***Run all commands in an Admin PowerShell instance***
- *Will later all be compiled into a single PowerShell script.*


## Main script

```powershell
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
```



## Cleanup Windows bloatware

Script to be refined: `.\windows_cleanup.ps1`

```powershell
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
```



## Setup and install Chocolatey and basic packages

Script to be refined: `.\chocolatey_install.ps1`

```powershell
## Install package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Install basic packages
choco install firefox vlc spotify sublimetext4 libreoffice-fresh 7zip -a

## Install gaming packages
choco install discord steam obs-studio -a

## Install development packages
choco install vscode git github-desktop marktext -a

## Install security packages
choco install protonvpn -a
```



## Install Drivers for Machine Learning with CUDA

- *To be automated if possible?*
- Visual C++: https://learn.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170
- NVIDIA drivers: https://www.nvidia.com/download/index.aspx
- CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-archive
- cuDNN: https://developer.nvidia.com/cudnn


## Install Python and create a Virtual Environment for Machine Learning

Script to be refined: `.\python_ml_install.ps1`

```powershell
## Get Python from official website: https://www.python.org/downloads/
## Version 3.9.x is recommended for Tensorflow and PyTorch compatibility

## Or install using Chocolatey
try{ choco install python39 -a }
catch { Write-Output "Error in Windows cleanup script..." }

## Create virtual environment
cd $HOME
mkdir venvs
cd venvs
python -m venv ml
Set-ExecutionPolicy RemoteSigned
venvs\ml\Scripts\activate.ps1
cd $HOME
pip install --upgrade pip

## Install basic packages
pip install pytest jupyter ipykernel

## Install Data Science packages
pip install numpy matplotlib scipy pandas seaborn

## Install packages for Machine Learning
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install tensorflow tensorflow-cpu tensorboard

## Check for successful installations
try { python -c "import torch; torch.cuda.is_available()" }
catch { Write-Output "Error with PyTorch check..." }

try { python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))" }
catch { Write-Output "Error with TensorFlow CPU check..." }

try { python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))" }
catch { Write-Output "Error with TensorFlow GPU check..." }
```
