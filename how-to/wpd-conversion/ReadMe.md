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
4. There are three different options for WPD conversion: 
	a. Run this one line of code to convert (only works for 250 files then stops for some reason):
		```
		soffice --convert-to docx *.wpd
		```
	b. Run this code chunk if there are more than 250 WPD files:
		```
		input_dir=/mnt/c/Users/<username>/<wpd-input-directory>
		output_dir=/mnt/c/Users/<username>/<wpd-output-directory>
		find $input_dir -iname "*.wpd" -type f -print0 |xargs -0 -I {} soffice --convert-to docx --outdir $output_dir {}
	 	```
   	c. Run this [bash script](https://github.com/cookcountyil-public-defender/wiki/blob/main/how-to/wpd-conversion/wpd-convert.sh) to perform a file conversion on the difference between WPD files in an input and docx files in an output directory.
