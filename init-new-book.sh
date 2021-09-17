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
echo "place original pdf file here if you dont want it to be checkedin" >  $book_folder_path/gen/why-this-folder.txt

# add appropriate header
echo "---
title: Introduction to International Law
author: TODO
lang: en
top-level-division: TODO part/chapter
rights: © TODO
---

TODO
" > $book_folder_path/00-metadata.md

echo "TODO" > $book_folder_path/01-preface.md

echo '
# General character related one

* Use triple dot (...) for a horizontal ellipsis (…) incase if the sentence ended & some parts are skipped.  No need to replace with actual horizontal ellipsis
* Use four dots (. ...) incase if the sentence ended & some parts are skipped. We get dot followed by horizontal ellipsis (. …). No need to replace with actual horizontal ellipsis
* Use triple hipen (---) for emdash. No need to actual em-dash
* Use double hipen (--) for emdash. No need to actual en-dash
* Replace number ranges with endash using the following regex
    (\d)\-(\d) with $1--$2
* Replace following double quote
  [”“] with "
   [’‘] with single quote

# Place bullet points onto new lines

Replace the following
  (\([a-zA-Z]+)\) with \n$1
  (\((?:i+|iv|vi*|ix|x)+\)) with \n$1
  (\([0-9]+\)) with \n$1

# Handling parts & chapters

If top-level-division is part, single # implies part name & ## implies chapter name

Create one file/part + one file/chapter all in sequence (number the files in sequence & pad apprirpiate number of zeros at start). Otherwise, 1 file/chapter

In any case,

* Within chapter, in the 1st go, start each section with S , subsection with SS so that we will worry about number of hashes at the end of chapter
* Once chapter is complete, Use search & replace to ensure we have correct number of hashes in one go

# Handling footnotes

* If Add footnote # are unique globally, Add / before footnote & its reference e.g /121
* If they are not
  a. Add / before footnote & its reference & prefix chapter number before slash (if they are unique only to chapter) i.e <chapter#>/<footnote#> e.g 1/23
  b. Add / before footnote & its reference & add page specific number (if they are unique only to the page) i.e <page#>/<footnote#> e.g 345/3
* Navigate using / to ensure the count of footnote reference matches footnotes
* Add `:` at the end of footnote only at footnote declaration. To do so, replace
    ^(/\d+) $1:
* For adding appropriate markdown footnote format, replace
    (/\d+) \[^$1\]
* search for the following to find next item
    \[\^\/
* Finally search for the following to move thru footers to bottom
    ^\[\^\d+\/
* Finally trim lines appropriately, do following replacements
    ^(\[\^\d+\/) \n$1
    \n\n\n+ \n\n
* IMPORTANT: space between pages that have no footnotes are also takes care of

For italicising, use this to ensure we always replace the correct word
For e.g, handling this sequences correctly & dont place _ at wrong place if we need to italise the following 3 combinations in order

see also below, see below, see

([^\w_])(words\s*seperated\s*byspace)([^\w_])

$1_$2_$3

Simpler version

(words\s*seperated\s*byspace)

_$1_

# common latin words that needs to be highlighted in law books

see also below
see also above
see below
see above
see
ibid.
prima facie
inter alia
ad hoc
ipso facto
ipso jure
op. cit.
loc. cit.
supra.
ante
cit.
cf.
et seq.
de jure
de facto
per se
obiter dicta
ante
dicta
inter se
res judicata
jus cogens
res gentium
jure gentium
raison d\x27être
opinio juris
'> $book_folder_path/help.txt

cp system/default-template.tex $book_folder_path/template.tex

echo -e "New book template is placed under\n"

echo -e $book_folder_path
