
## Python Developer Setup

### Install Windows Subsystem for Linux and Homebrew
* Install Windows Subsystem for Linux using these [instructions](https://learn.microsoft.com/en-us/windows/wsl/install). In the Command Prompt **running as admin**, run:
`wsl --install`
* If you get a `Catastrophic failure` error message, follow [this workaround](https://github.com/microsoft/WSL/issues/9420#issuecomment-1753919660). In the Command Prompt  **running as admin**, run:
`netsh winsock reset`
* Reboot the computer.
* Then, in a Command Prompt **not**  running as admin, run the following. 
`wsl --update`
`wsl --install`
* Install Homebrew within WSL terminal following instructions at [https://brew.sh](https://brew.sh)
    
### Install Python from conda-forge
-   Install Python within WSL terminal following these instructions on the [conda-forge repository](https://github.com/conda-forge/miniforge?tab=readme-ov-file#install).
* Open the WSL terminal and test if `python`, `conda`, and `pip` are installed correctly:
`python --version`
`conda --version`
`python -m pip --version`

### Trust common package repositories
* Disable SSL verification so we are able to install packages from common  repositories. Open WSL terminal and run:
`conda config --set ssl_verify False`
* Create a conda environment to test if it worked by opening WSL terminal and run:
`conda create --name testenv python=3.11 --yes`
`conda activate testenv`
`conda install -c conda-forge pandas`
* Check if the pip.conf file exists:
`pip config debug`
* If no pip.conf file exists in any of the default locations create one in the home user directory:
`mkdir -p /home/<myusername>/.pip`
`touch pip.conf`
* Open pip.conf with Notepad++:
`alias npp="/mnt/c/'Program Files'/Notepad++/Notepad++.exe"`
`npp pip.conf`
* Copy in these trusted sources into the `pip.conf` file:
	```
	[global]
	trusted-host = pypi.python.org
	               pypi.org
	               files.pythonhosted.org
	               raw.githubusercontent.com
	               github.com
	```
* Run a pip install test:
`pip install urlrequest`
* To trust sources manually this is another option:
`pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org urlrequest`

### Setup WSL with Visual Studio Code
* Download and install [Git for Windows](https://git-scm.com/download/win).
* Download and install [Visual Studio Code for Windows](https://code.visualstudio.com/download).
* Open VSCode and install the WSL plugin:
	* `WSL` allows VS Code to run software and environments installed via WSL Linux. 
* Go to search box at top and type  `> WSL: Connect to WSL` and VSCode will restart with the WSL Linux subsystem.
* Install additional plugins in VSCode:
	* `SQL Server (mssql)` connect to SQL Data Warehouses from VSCode and execute code.
	* `Python` provides formatting, linting, variable explorers for Python 
	* `flake8` automatically checks for errors, styling issues for Python
	* `Jupyter` allows inline cells and interactive window using `# %%` 
	* `indent-rainbow` make indents more readable
	* `Rainbow CSV` makes it easy to read CSVs in VSCode
	* `Docker` build, manage, and deploy containerized applications
	* `Dev Containers` use Docker container in VSCode
	* `Remote - Tunnels` open folders / run code on remote machine/VM using a VS Code Tunnel
	* `Remote - SSH` open folders / run code on remote machine/VM using SSH
	* `Remote Containers` open folders / run code mounted into/inside a container

### Test conda environment in VSCode
* Go to VSCode search bar and type `> Python: Select interpreter` and choose `Python 3.11 ('testenv')`
* In VSCode go to File > New File and save a new `.py` file.
* In `.py` file test a couple lines to confirm the test environment works:
	```
	import pandas as pd
	pd.DataFrame({'A': [1, 2, 3]})
	```
* In WSL terminal remove `testenv` if it is no longer needed:
	`conda remove -n testenv --all`
