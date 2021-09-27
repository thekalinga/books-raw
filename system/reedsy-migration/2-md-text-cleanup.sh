#!/usr/bin/env zsh

# place a line before heading & after heading
perl -i -0777 -pe 's/(^|\R)(#[^\n]+?\R)/\n$2\n/g' text.md

# emdash

perl -i -0777 -pe 's/—/---/g' text.md

# endash

perl -i -0777 -pe 's/–/--/g' text.md

# quotes

perl -i -0777 -pe 's/“/"/g' text.md
perl -i -0777 -pe 's/”/"/g' text.md

perl -i -0777 -pe "s/‘/'/g" text.md
perl -i -0777 -pe "s/’/'/g" text.md

# ellipses

perl -i -0777 -pe "s/\.…/. .../g" text.md
perl -i -0777 -pe "s/…/.../g" text.md

perl -CSD -i -0777 -pe "s/\x{FEFF}\R\x{FEFF}/\n\n/g" text.md
perl -CSD -i -0777 -pe "s/\x{FEFF}//g" text.md

# remove spaces from start & end of document
# Why order of -i & -0777 matters
# -0777 enables whats called slurp mode aka reading the document as a whole
# https://stackoverflow.com/a/69280333/211794
perl -i -0777 -pe 's/^\s+|(\R)\s+$/$1/g' text.md

# collapse consecutive empty lines
perl -i -0777 -pe 's/\R\R\R+/\n\n/g' text.md

#perl -i -0777 -pe 's///g' reedsy-body.html
