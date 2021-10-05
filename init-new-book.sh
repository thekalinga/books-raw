#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "Enter book name\n"
    exit 1
fi

book_name=$(echo "$*" | perl -pe 's/^\s*//g and s/\s*$//g')

# trim spaces at edges, replace upper case with lower, remove special characters & finally consecutive spaces with `-`
book_folder_name_sanitised=$(echo "$book_name" | perl -pe 's/^\s*//g;' -pe 's/\s*$//g;' -pe 's/([A-Z])/\L$1/g;' -pe 's/[\x27":&()]//g;' -pe 's/\s+/-/g;')

book_folder_path="repo/$book_folder_name_sanitised"

if [[ -d $book_folder_path ]]; then
    echo -e "\n\t¯\_ (ツ)_/¯\n"
    echo -e "Book directory already exists under this path\n"
    echo "$book_folder_path"
    exit 1
fi

mkdir "$book_folder_path"

# add appropriate header
echo "# pick one
#BOOK_TYPE=novel/textbook/report/article
" > "$book_folder_path/.config"


# useful for placing original pdfs so that they wont be checked into repo by accident
mkdir "$book_folder_path/gen"
echo "place original pdf file here if you dont want it to be checkedin" >  "$book_folder_path/gen/why-this-folder.txt"

# add appropriate header
echo "---
title: \"$book_name\"
author: TODO
lang: en
top-level-division: TODO part/chapter
rights: © TODO
---

TODO
" > "$book_folder_path/00-metadata.md"

echo "TODO" > "$book_folder_path/01-preface.md"

cp system/misc/file-names-template.ods "$book_folder_path/file-names.ods"
cp system/misc/help-template.adoc "$book_folder_path/help.adoc"

echo -e "New book template is placed under\n\n$book_folder_path\n"
