#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Enter directory name (that contains book.md). Options are"
    echo ""
    for dir in $(ls -dt repo/*/); do
      if [[ $dir != "system/" ]] && test -f "$dir/book.md"; then
        echo ${dir%*/}
      fi
    done
    echo ""
    exit 1
fi

book_dir_rel_path=$1

temp_dir=$(mktemp -d)
gen_script=$temp_dir/gen.sh

echo "#!/bin/sh

[ ! -d gen ] && mkdir gen

pandoc \
    --toc \
    --standalone \
    --output=gen/book.epub \
    book.md
" > $gen_script

chmod +x $gen_script

echo -e "written script to run inside docker to:\t$gen_script\n"
echo -e "executing the following command inside docker environment\n
docker run --rm --volume "`pwd`/$book_dir_rel_path:/data" \\
       --volume "$temp_dir:/generator" \\
       --user `id -u`:`id -g` \\
       --entrypoint "/generator/gen.sh" \\
       local/pandoc-custom:1.0\n"

docker run --rm --volume "`pwd`/$book_dir_rel_path:/data" \
   --volume "$temp_dir:/generator" \
   --user `id -u`:`id -g` \
   --entrypoint "/generator/gen.sh" \
   local/pandoc-custom:1.0
