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
4. Run this one line of code to convert (only works for 250 files then stops for some reason):
	```
	soffice --convert-to docx *.wpd
	```
 5. Run this code chunk if there are more than 250 WPD files:
	```
	input_dir=/mnt/c/Users/<username>/<wpd-input-directory>
	output_dir=/mnt/c/Users/<username>/<wpd-output-directory>
	find $input_dir -iname "*.wpd" -type f -print0 |xargs -0 -I {} soffice --convert-to docx --outdir $output_dir {}
 	```
 6. Run this code chunk if you have a partially complete conversion (some files were added to the input directory or some weren't completed):
	```
	input_dir=/mnt/c/Users/<username>/<wpd-input-directory>
	output_dir=/mnt/c/Users/<username>/<wpd-output-directory>
	
	declare -a input_array
	mapfile -d '' input_array < <( find "$input_dir" -iname '*.wpd' -type f -exec basename {} \; | sed 's/\..*$//' | sed 's/.*/"&"/' )
	
	declare -a output_array
	mapfile -d '' output_array < <( find "$output_dir" -iname '*.docx' -type f -exec basename {} \; | sed 's/\..*$//' | sed 's/.*/"&"/' )
	
	difference=$(grep -vxFf <(printf "%s\n" "${output_array[@]}") <(printf "%s\n" "${input_array[@]}"))
	readarray -t diff_array <<< "$difference"
	
	for basename in "${diff_array[@]}"; do
	    basename=("${basename//\"}")
	    matching_files=$(find "$input_dir" -type f -iname '*.wpd' | grep -i "\/${basename}\.wpd" | grep "${basename}")
	    echo "$matching_files"
	    soffice --headless --convert-to docx "$matching_files" --outdir "$output_dir"
	done
 	```

