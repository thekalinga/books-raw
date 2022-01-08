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
      -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36' \
      -H 'accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8' \
      -H "cookie: $cookie" \
      -H "referer: https://www.jstor.org/stable/$document_id" \
      -H 'authority: www.jstor.org' \
      -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
      -H 'sec-gpc: 1' \
      -H 'sec-fetch-site: same-origin' \
      -H 'sec-fetch-mode: navigate' \
      -H 'sec-fetch-user: ?1' \
      -H 'sec-fetch-dest: document' \
      -o "$i.jpeg" \
      --compressed
  # Lets strip the color metadata as its messing up text detection
  # exiftool 1.jpeg | grep -i profile # This shows `Artifex Software sRGB ICC Profile`
  # exiftool 1-modified.jpeg | grep -i profile  # This shows nothing
  # https://github.com/ImageMagick/ImageMagick/issues/2813#issuecomment-725376463
  convert "$i.jpeg" +profile icc "$i-modified.jpeg"
  # lets give lil of time before we pull
  sleep 1
done

convert "*-modified.{jpeg}" -quality 100 o.pdf && rm "*.jpg"
