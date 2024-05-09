#!/bin/bash

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

