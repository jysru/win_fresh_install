### Run as Admin PowerShell ###


## Install drivers for Machine Learning
- Visual C++: https://learn.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170
- NVIDIA drivers: https://www.nvidia.com/download/index.aspx
- CUDA toolkit: https://developer.nvidia.com/cuda-toolkit-archive
- cuDNN: https://developer.nvidia.com/cudnn


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
python -c "import torch; torch.cuda.is_available()"

python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"