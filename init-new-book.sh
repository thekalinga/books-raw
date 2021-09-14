#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "Enter book name\n"
    exit 1
fi

book_name=`echo "$*" | perl -pe 's/^\s*//g and s/\s*$//g'`

# trim spaces at edges, replace upper case with lower, spaces with `-` & remove quotes
book_folder_name_sanitised=`echo $book_name | perl -pe 's/^\s*//g and s/\s*$//g and s/([A-Z])/\L$1/g and s/\s+/-/g and s/[\x27"]//g'`

book_folder_path="repo/$book_folder_name_sanitised"

if [[ -d $book_folder_path ]]; then
    echo -e "\n\t¯\_ (ツ)_/¯\n"
    echo -e "Book directory already exists under this path\n"
    echo $book_folder_path
    exit 1
fi

mkdir $book_folder_path

# useful for placing original pdfs so that they wont be checked into repo by accident
mkdir $book_folder_path/gen

# add appropriate header
echo "---
title: $book_name
author: TODO
lang: en
rights: © TODO
---

TODO
" > $book_folder_path/book.md

cp system/default-template.tex $book_folder_path/template.tex

echo -e "New book template is placed under\n"

echo -e $book_folder_path
