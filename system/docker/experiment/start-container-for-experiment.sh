#!/bin/sh

echo -n "Do you not see any error messages?\n\nDoes the process looks like its stuck?\n\nTHAT MEANS WE CAN ATTACH\n\n"

echo -n "OPEN new terminal/tab & ATTACH by running:\n\ndocker exec -i -t --user root pandoc-experiment sh\n\n"

docker run --rm \
    --name pandoc-experiment \
    --volume "`pwd`:/data" \
    --user `id -u`:`id -g` \
    --entrypoint "/data/_sleep-container-forever.sh" \
    pandoc/latex:2.16.2
