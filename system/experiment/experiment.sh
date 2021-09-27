#!/bin/sh

#docker run --rm \
#    --name pandoc-experiment \
#    --volume "`pwd`:/data" \
#    --user `id -u`:`id -g` \
#    --entrypoint "/data/experiment.sh" \
#    pandoc/latex:2.14.1

# Uncomment this if you want to run the container in sleeping mode so that we can connect using another terminal
# while true; do sleep 30; done;

# Start the docker container with the above script & then run this to attach to container shell as root user
#docker exec -i -t --user root pandoc-experiment sh

# Generate tex file from the markdown using default template tex pandoc uses internally

# Tex file just for the fragment without pandoc container
#pandoc \
#  --output=experiment.tex \
#  experiment.md

# Tex file with embedded in pandoc container
#pandoc \
#  -s \
#  --output=experiment.tex \
#  experiment.md

#pdflatex experiment.tex

# Export to pdf
#pandoc \
#  --output=experiment.pdf \
#  experiment.md

# Export to epub
#pandoc \
#  --output=experiment.pdf \
#  experiment.md

#pandoc \
#  --output=experiment.pdf \
#  experiment.html

# pandoc -D latex > pandex-default-template.latex

