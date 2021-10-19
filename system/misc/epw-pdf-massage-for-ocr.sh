#!/bin/zsh

# 1st page (Top section --- horizontal & Bottom --- 3 columns)
# extract articles 1st page
pdftk "orig.pdf" cat 2-2 output "article-p1.pdf"
# extract just the top part (while cropping header)
# TODO: Adjust 500 manually
# left top right bottom
pdfcrop --margins '0 -30 0 -500' "article-p1.pdf" "article-p1-top-section.pdf"
# TODO: Adjust 260 manually
# left top right bottom
# extract just the bottom part (while cropping footer & margins on left & right)
pdfcrop --margins '-30 -260 -30 -55' "article-p1.pdf" "article-p1-bottom-section.pdf"
# split each of the 3 columns
mutool poster -x 3 "article-p1-bottom-section.pdf" "article-p1-bottom-section-splity.pdf"

# 2nd page till end (3 columns)
# extract article's 2nd page till end
pdftk "orig.pdf" cat 3-end output "article-p2-end.pdf"
# cropping header, footer & margins on left & right
# left top right bottom
pdfcrop --margins '-30 -65 -30 -55' "article-p2-end.pdf" "article-p2-end-margins-cropped.pdf"
# split each of the 3 columns
mutool poster -x 3 "article-p2-end-margins-cropped.pdf" "article-p2-end-splity.pdf"

# combine all parts
pdfunite article-p1-top-section.pdf article-p1-bottom-section-splity.pdf article-p2-end-splity.pdf pages-merged.pdf

# convert into an image so that google can handle it better
convert -density 100 pages-merged.pdf final.pdf

