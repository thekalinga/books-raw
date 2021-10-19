#!/bin/bash

if [ $# -ne 1 ]
then
    echo -e "Enter directory name (that contains *.md). Options are\n\n<<oldest>>\n"
    for dir in $(ls -dtr repo/*); do
      # if the directory has an `.md` file, lets assume it to be a book
      md_file_count=`ls -1 $dir/*.md 2>/dev/null | wc -l`
      if [[ $dir != "system/" ]] && [ $md_file_count != 0  ]; then
        echo ${dir%*/}
      fi
    done
    echo -e "\n<<newest>>"
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
  document_class='book'
elif [[ $BOOK_TYPE == "textbook" ]]; then
  template_file_name='textbook-template.tex'
  document_class='book'
elif [[ $BOOK_TYPE == "report" ]]; then
  template_file_name='report-template.tex'
  document_class='report'
elif [[ $BOOK_TYPE == "article" ]]; then
  template_file_name='article-template.tex'
  document_class='article'
elif [[ $BOOK_TYPE == "" ]]; then
  echo -e "\nBOOK_TYPE not set in $(emphasize $config_file_path); Valid values are $(emphasize novel)/$(emphasize textbook)/$(emphasize report)/$(emphasize article)\n"
  exit 1
else
  echo -e "\nInvalid BOOK_TYPE $(emphasize $BOOK_TYPE) specified in $(emphasize $config_file_path); Valid values are $(emphasize novel)/$(emphasize textbook)/$(emphasize report)/$(emphasize article)\n"
  exit 1
fi

temp_dir=$(mktemp -d)
gen_script=$temp_dir/gen.sh

echo "#!/bin/sh

[ ! -d gen ] && mkdir gen

pandoc \
    --toc \
    --standalone \
    --output=gen/$document_class.html \
    *.md
" > $gen_script

chmod +x $gen_script

echo -e "written script to run inside docker to:\t$gen_script\n"
echo -e "executing the following command inside docker environment\n
docker run --rm --volume "`pwd`/$book_dir_rel_path:/data" \\
       --volume "$temp_dir:/generator" \\
       --user `id -u`:`id -g` \\
       --entrypoint "/generator/gen.sh" \\
       custom/luatex-pandoc-docker:1.0\n"

docker run --rm --volume "`pwd`/$book_dir_rel_path:/data" \
   --volume "$temp_dir:/generator" \
   --user `id -u`:`id -g` \
   --entrypoint "/generator/gen.sh" \
   custom/luatex-pandoc-docker:1.0
