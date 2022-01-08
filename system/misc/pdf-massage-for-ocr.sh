#!/bin/zsh

# 1st page (Top section --- horizontal & Bottom --- 3 columns)
# extract articles 1st page
pdftk "o.pdf" cat 2-end output "o1.pdf" && mv o.pdf o-bak.pdf && mv o1.pdf o.pdf
# margins <<<left top right bottom>>>
pdfcrop --margins '0 -20 0 -20' "o.pdf" "o-m.pdf"
# split into 3 parts vertically
mutool poster -x 3 "o-m.pdf" "o-s.pdf"
# merge all; o-cropped.pdf is generated from krop if we need to crop
pdfunite o-cropped.pdf o-s.pdf pages-merged.pdf

# Lets strip the color metadata as its messing up text detection
# exiftool 1.jpeg | grep -i profile # This shows `Artifex Software sRGB ICC Profile`
# exiftool 1-modified.jpeg | grep -i profile  # This shows nothing
# https://github.com/ImageMagick/ImageMagick/issues/2813#issuecomment-725376463
convert +profile icc -density 200 pages-merged.pdf final.pdf
