#!/bin/zsh

# document id
document_id=
# number of pages
num_of_pages=
# login & get cookie string from any link that points to jstor.org
cookie=""

num_of_digits="${#num_of_pages}"

for i in $(seq -f "%0${num_of_digits}g" 0 $((num_of_pages-1)))
do
  curl -v "https://www.jstor.org/page-scan-delivery/get-page-scan/$document_id/$i" \
      -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36' \
      -H "cookie: $cookie" \
      -o "$i.jpeg"
done

convert "*.{jpeg}" -quality 100 o.pdf
