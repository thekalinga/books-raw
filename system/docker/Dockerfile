FROM pandoc/latex:2.14.1

# installs texlive-full minus texlive-doc minus texlive-dev
# see: https://pkgs.alpinelinux.org/package/edge/community/x86_64/texlive-full
RUN apk add --no-cache texlive texlive-dvi texlive-luatex texlive-xetex xdvik
#RUN apk add --no-cache texlive-full

RUN tlmgr update --self && tlmgr update --all

# All `*-template.tex` files use `Merriweather Sans` for quotes. Unlike the one above, we can install the plugin as the plugin resets defualt fonts. So we are installing the manually
RUN wget 'https://fonts.google.com/download?family=Merriweather Sans' -O googlefonts.zip \
  && mkdir -p /usr/share/fonts/truetype/google-fonts/ \
  && unzip googlefonts.zip -d /usr/share/fonts/truetype/google-fonts/ \
  && rm -f googlefonts.zip \
  && fc-cache -f \
  && rm -rf /var/cache/*

# luatex is not workign in this environment unless permissions are changed to this
RUN chmod o+w /opt/texlive/texdir/texmf-var

# `template.tex` file uses crimson font for text
RUN tlmgr install crimson tabulary

# default working directory
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/pandoc"]
