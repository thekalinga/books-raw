#!/bin/bash

if [ $# -ne 1 ]
then
    echo -e "Enter directory name (that contains *.md). Options are\n"
    for dir in $(ls -dt repo/*); do
      # if the directory has an `.md` file, lets assume it to be a book
      md_file_count=`ls -1 $dir/*.md 2>/dev/null | wc -l`
      if [[ $dir != "system/" ]] && [ $md_file_count != 0  ]; then
        echo ${dir%*/}
      fi
    done
    echo ""
    exit 1
fi

book_dir_rel_path=$1

if [ ! -f "$book_dir_rel_path/.config" ]; then
  echo -e "Config file $book_dir_rel_path/.config is missing";
  exit 1
fi

# Loads the configuration specific to the book. Usually contains settings like the tex template to use to use when exporting to pdf
config_file_path=$book_dir_rel_path/.config
source $config_file_path
sourcing_status=$?

if [ $sourcing_status != 0 ]; then
  echo -e "\nError occurred while sourcing $config_file_path; Please fix the errors\n"
  exit 1
fi

emphasize () {
  echo "\e[1;33;4;44m$1\e[0m";
}

if [[ $BOOK_TYPE == "novel" ]]; then
  template_file_name='novel-template.tex'
elif [[ $BOOK_TYPE == "textbook" ]]; then
  template_file_name='textbook-template.tex'
elif [[ $BOOK_TYPE == "" ]]; then
  echo -e "\nBOOK_TYPE not set in $(emphasize $config_file_path); Valid values are $(emphasize novel)/$(emphasize textbook)\n"
  exit 1
else
  echo -e "\nInvalid BOOK_TYPE $(emphasize $BOOK_TYPE) specified in $(emphasize $config_file_path); Valid values are $(emphasize novel)/$(emphasize textbook)\n"
  exit 1
fi

temp_dir=$(mktemp -d)
gen_script=$temp_dir/gen.sh

# we generate an intermediate script which will be executed inside the docker environment
echo "#!/bin/sh

cd /data/book-source
[ ! -d gen ] && mkdir gen

# Convert the MARKDOWN → PDF using pandoc (internally uses lualatex)
# since we are using 'fontspec' for setting quote fonts, we need to use luatex instead of pdflatex
pandoc \
    --template=/data/latex-templates/$template_file_name \
    --variable documentclass="book" \
    --variable fontsize="12pt" \
    --variable lang \
    --variable babel-lang="english" \
    --variable indent \
    --pdf-engine=lualatex \
    --toc \
    --standalone \
    --output=gen/book.pdf \
    *.md
" > $gen_script

chmod +x $gen_script

echo -e "written script to run inside docker to:\t$gen_script\n"
echo -e "executing the following command inside docker environment\n
docker run --rm \\
    --volume "`pwd`/$book_dir_rel_path:/data/book-source" \\
    --volume "`pwd`/system/latex/:/data/latex-templates" \\
    --volume "$temp_dir:/generator" \\
    --user `id -u`:`id -g` \\
    --entrypoint "/generator/gen.sh" \\
    custom/luatex-pandoc-docker:1.0\n"

docker run --rm \
    --volume "`pwd`/$book_dir_rel_path:/data/book-source" \
    --volume "`pwd`/system/latex/:/data/latex-templates" \
    --volume "$temp_dir:/generator" \
    --user `id -u`:`id -g` \
    --entrypoint "/generator/gen.sh" \
    custom/luatex-pandoc-docker:1.0
