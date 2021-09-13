# Book repo

`repo ` directory consists of all books in markdown format which can be converted into `pdf`/`epub` on demand

## Generating pdf

Run `pdf.sh`

## Generating epub

Run `epub.sh`

## Debug pdf generation

Generate tex file by running `tex.sh`

Edit `gen/book.tex`

Run `pdf-from-tex.sh` to generate pdf from book.tex instead

## One time setup

1. Ensure docker is installed
2. Run `build.sh` from `docker` directory which generates builds required docker image
