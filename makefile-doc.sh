#!/usr/bin/env bash
set -e

declare -a paths
declare -a makefile_files

index=0

for file_with_path in "$@"; do
  file_with_path="${file_with_path// /__REPLACED__SPACE__}"

  paths[index]=$(dirname "$file_with_path")

  if [[ "$file_with_path" == "Makefile"* ]]; then
    makefile_files+=("$file_with_path")
  fi

  ((index+=1))
done

readonly tmp_file=$(mktemp)
readonly text_file="README.md"

for path_uniq in $(echo "${paths[*]}" | tr ' ' '\n' | sort -u); do
  path_uniq="${path_uniq//__REPLACED__SPACE__/ }"

  pushd "$path_uniq" > /dev/null

  if [[ ! -f "$text_file" ]]; then
    popd > /dev/null
    continue
  fi

  START_LINE="\`\`\`\n\$ make help \n"
  END_LINE="\n\`\`\`"

  # Remove color codes and add make help output to temp file
   echo -e "$START_LINE$(make help | sed "s,$(printf '\033')\\[[0-9;]*[a-zA-Z],,g") $END_LINE" > "$tmp_file"

  # Replace content between markers with the placeholder - https://stackoverflow.com/questions/1212799/how-do-i-extract-lines-between-two-line-delimiters-in-perl#1212834
  perl -i -ne 'if (/START makefile-doc/../END makefile-doc/) { print $_ if /START makefile-doc/; print "I_WANT_TO_BE_REPLACED\n$_" if /END makefile-doc/;} else { print $_ }' "$text_file"

  # Replace placeholder with the content of the file
  perl -i -e 'open(F, "'"$tmp_file"'"); $f = join "", <F>; while(<>){if (/I_WANT_TO_BE_REPLACED/) {print $f} else {print $_};}' "$text_file"

  rm -f "$tmp_file"

  popd > /dev/null
done