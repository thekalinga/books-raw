#!/bin/bash

current_dir=$(pwd)
script_dir=$(dirname "$0" | while read -r a; do cd "$a" && pwd && break; done)

echo -e "\nDo you not see any error messages?\nDoes the process looks like its stuck?\nTHAT MEANS WE CAN ATTACH\n\n"

echo -e "Press CTRL+C to stop container (takes ~30 secs) \n\n"

echo -e "To attach to container as current user (testing pandoc commands) use this\n"

echo -e "OPEN new terminal/tab & ATTACH by running:\n\ndocker exec -i -t --user \$(id -u):\$(id -g) pandoc-experiment sh\n"

echo -e "To use pandoc to convert from epub to markdown, use this\n"

echo -e "pandoc --output o.md o.epub\n\n"

echo -e "To connect to container as root (for testing package installation etc), use this\n"

echo -e "OPEN new terminal/tab & ATTACH by running:\n\ndocker exec -i -t --user root pandoc-experiment sh\n\n"

echo -e "Current directory will be mapped to /data inside the container"

docker run --rm \
    --name pandoc-experiment \
    --volume "`pwd`:/data" \
    --volume "$script_dir:/docker-script-dir" \
    --user `id -u`:`id -g` \
    --entrypoint "/docker-script-dir/_sleep-pandoc-container-forever.sh" \
    pandoc/latex:2.16.2
