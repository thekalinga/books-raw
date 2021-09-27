#!/usr/bin/env zsh

# place a line before heading & after heading
perl -i -0777 -pe 's/(\R)(\d+)\R/$1\[^$2\]: /g' text.md
