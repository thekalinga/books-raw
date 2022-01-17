FROM pandoc/latex:2.17.0.1

# installs texlive-full minus texlive-doc minus texlive-dev
# see: https://pkgs.alpinelinux.org/package/edge/community/x86_64/texlive-full
RUN apk add --no-cache texlive texlive-dvi texlive-luatex texlive-xetex xdvik
#RUN apk add --no-cache texlive-full

RUN tlmgr update --self && tlmgr update --all

# All `*-template.tex` files use `Merriweather Sans` for quotes. Unlike the one above, we can install the plugin as the plugin resets defualt fonts. So we are installing the manually
RUN wget 'https://fonts.google.com/download?family=Merriweather Sans' -O merriweather-sans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/merriweather-sans/ \
  && unzip merriweather-sans.zip -d /usr/share/fonts/truetype/google-fonts/merriweather-sans/ \
  && rm -f merriweather-sans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Bengali' -O bengali-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Bengali' -O bengali-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/bengali-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/bengali-notosans/ \
  && unzip bengali-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/bengali-notoserif/ \
  && unzip bengali-notosans.zip -d /usr/share/fonts/truetype/google-fonts/bengali-notosans/ \
  && rm -f bengali-notoserif.zip \
  && rm -f bengali-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Devanagari' -O devanagari-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Devanagari' -O devanagari-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/devanagari-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/devanagari-notosans/ \
  && unzip devanagari-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/devanagari-notoserif/ \
  && unzip devanagari-notosans.zip -d /usr/share/fonts/truetype/google-fonts/devanagari-notosans/ \
  && rm -f devanagari-notoserif.zip \
  && rm -f devanagari-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Gujarati' -O gujarati-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Gujarati' -O gujarati-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/gujarati-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/gujarati-notosans/ \
  && unzip gujarati-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/gujarati-notoserif/ \
  && unzip gujarati-notosans.zip -d /usr/share/fonts/truetype/google-fonts/gujarati-notosans/ \
  && rm -f gujarati-notoserif.zip \
  && rm -f gujarati-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Gurmukhi' -O punjabi-gurmukhi-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Gurmukhi' -O punjabi-gurmukhi-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/punjabi-gurmukhi-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/punjabi-gurmukhi-notosans/ \
  && unzip punjabi-gurmukhi-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/punjabi-gurmukhi-notoserif/ \
  && unzip punjabi-gurmukhi-notosans.zip -d /usr/share/fonts/truetype/google-fonts/punjabi-gurmukhi-notosans/ \
  && rm -f punjabi-gurmukhi-notoserif.zip \
  && rm -f punjabi-gurmukhi-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Kannada' -O kannada-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Kannada' -O kannada-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/kannada-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/kannada-notosans/ \
  && unzip kannada-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/kannada-notoserif/ \
  && unzip kannada-notosans.zip -d /usr/share/fonts/truetype/google-fonts/kannada-notosans/ \
  && rm -f kannada-notoserif.zip \
  && rm -f kannada-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Malayalam' -O malayalam-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Malayalam' -O malayalam-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/malayalam-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/malayalam-notosans/ \
  && unzip malayalam-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/malayalam-notoserif/ \
  && unzip malayalam-notosans.zip -d /usr/share/fonts/truetype/google-fonts/malayalam-notosans/ \
  && rm -f malayalam-notoserif.zip \
  && rm -f malayalam-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Baloo Bhaina 2' -O oriya-serif-baloo-bhaina.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/oriya-serif-baloo-bhaina/ \
  && unzip oriya-serif-baloo-bhaina.zip -d /usr/share/fonts/truetype/google-fonts/oriya-serif-baloo-bhaina/ \
  && rm -f oriya-serif-baloo-bhaina.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Oriya' -O oriya-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/oriya-notosans/ \
  && unzip oriya-notosans.zip -d /usr/share/fonts/truetype/google-fonts/oriya-notosans/ \
  && rm -f oriya-notosans.zip \
  && rm -f oriya-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Tamil' -O tamil-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Tamil' -O tamil-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/tamil-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/tamil-notosans/ \
  && unzip tamil-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/tamil-notoserif/ \
  && unzip tamil-notosans.zip -d /usr/share/fonts/truetype/google-fonts/tamil-notosans/ \
  && rm -f tamil-notoserif.zip \
  && rm -f tamil-notosans.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Telugu' -O telugu-notoserif.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Telugu' -O telugu-notosans.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/telugu-notoserif/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/telugu-notosans/ \
  && unzip telugu-notoserif.zip -d /usr/share/fonts/truetype/google-fonts/telugu-notoserif/ \
  && unzip telugu-notosans.zip -d /usr/share/fonts/truetype/google-fonts/telugu-notosans/ \
  && rm -f telugu-notoserif.zip \
  && rm -f telugu-notosans.zip \
  && fc-cache -f \
  && rm -rf /var/cache/*

# luatex is not workign in this environment unless permissions are changed to this
RUN chmod o+w /opt/texlive/texdir/texmf-var

# `template.tex` file uses crimsonpro font for text
RUN tlmgr install crimsonpro tabulary selnolig pdfpages

#RUN apk add --no-cache texmf-dist-langextra

# default working directory
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/pandoc"]
