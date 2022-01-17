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
  && wget 'https://fonts.google.com/download?family=Noto Serif Bengali' -O notoserif-bengali.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Bengali' -O notosans-bengali.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-bengali/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-bengali/ \
  && unzip notoserif-bengali.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-bengali/ \
  && unzip notosans-bengali.zip -d /usr/share/fonts/truetype/google-fonts/notosans-bengali/ \
  && rm -f notoserif-bengali.zip \
  && rm -f notosans-bengali.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Devanagari' -O notoserif-devanagari.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Devanagari' -O notosans-devanagari.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-devanagari/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-devanagari/ \
  && unzip notoserif-devanagari.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-devanagari/ \
  && unzip notosans-devanagari.zip -d /usr/share/fonts/truetype/google-fonts/notosans-devanagari/ \
  && rm -f notoserif-devanagari.zip \
  && rm -f notosans-devanagari.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Gujarati' -O notoserif-gujarati.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Gujarati' -O notosans-gujarati.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-gujarati/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-gujarati/ \
  && unzip notoserif-gujarati.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-gujarati/ \
  && unzip notosans-gujarati.zip -d /usr/share/fonts/truetype/google-fonts/notosans-gujarati/ \
  && rm -f notoserif-gujarati.zip \
  && rm -f notosans-gujarati.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Gurmukhi' -O notoserif-gurmukhi.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Gurmukhi' -O notosans-gurmukhi.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-gurmukhi/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-gurmukhi/ \
  && unzip notoserif-gurmukhi.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-gurmukhi/ \
  && unzip notosans-gurmukhi.zip -d /usr/share/fonts/truetype/google-fonts/notosans-gurmukhi/ \
  && rm -f notoserif-gurmukhi.zip \
  && rm -f notosans-gurmukhi.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Kannada' -O notoserif-kannada.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Kannada' -O notosans-kannada.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-kannada/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-kannada/ \
  && unzip notoserif-kannada.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-kannada/ \
  && unzip notosans-kannada.zip -d /usr/share/fonts/truetype/google-fonts/notosans-kannada/ \
  && rm -f notoserif-kannada.zip \
  && rm -f notosans-kannada.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Malayalam' -O notoserif-malayalam.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Malayalam' -O notosans-malayalam.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-malayalam/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-malayalam/ \
  && unzip notoserif-malayalam.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-malayalam/ \
  && unzip notosans-malayalam.zip -d /usr/share/fonts/truetype/google-fonts/notosans-malayalam/ \
  && rm -f notoserif-malayalam.zip \
  && rm -f notosans-malayalam.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Oriya' -O notoserif-oriya.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-oriya/ \
  && unzip notoserif-oriya.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-oriya/ \
  && rm -f notoserif-oriya.zip \
  && rm -f notosans-oriya.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Tamil' -O notoserif-tamil.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Tamil' -O notosans-tamil.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-tamil/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-tamil/ \
  && unzip notoserif-tamil.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-tamil/ \
  && unzip notosans-tamil.zip -d /usr/share/fonts/truetype/google-fonts/notosans-tamil/ \
  && rm -f notoserif-tamil.zip \
  && rm -f notosans-tamil.zip \
  && wget 'https://fonts.google.com/download?family=Noto Serif Telugu' -O notoserif-telugu.zip \
  && wget 'https://fonts.google.com/download?family=Noto Sans Telugu' -O notosans-telugu.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notoserif-telugu/ \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/notosans-telugu/ \
  && unzip notoserif-telugu.zip -d /usr/share/fonts/truetype/google-fonts/notoserif-telugu/ \
  && unzip notosans-telugu.zip -d /usr/share/fonts/truetype/google-fonts/notosans-telugu/ \
  && rm -f notoserif-telugu.zip \
  && rm -f notosans-telugu.zip \
  && fc-cache -f \
  && rm -rf /var/cache/*

# luatex is not workign in this environment unless permissions are changed to this
RUN chmod o+w /opt/texlive/texdir/texmf-var

# `template.tex` file uses crimsonpro font for text
RUN tlmgr install crimsonpro tabulary selnolig

#RUN apk add --no-cache texmf-dist-langextra

# default working directory
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/pandoc"]
