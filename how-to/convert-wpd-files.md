### Batch Convert Word Perfect files to MS Word files

1. Install WSL for Windows [(see these directions)](https://github.com/cookcountyil-public-defender/wiki/blob/main/installation-guides/setup-python.md#install-windows-subsystem-for-linux-and-homebrew).
2. Open WSL terminal and run the following installations:
	```
	sudo apt install libreoffice-common
	sudo apt-get install default-jre libreoffice-java-common
	sudo apt install libreoffice-writer
	```
3. Set current directory to folder containing WPD files:
	```
	cd /mnt/c/Users/<username>/<wpd-directory>
	```
4. Run this one line of code to convert:
	```
	soffice --convert-to docx *.WPD
	```
