# Experiment with pandoc container

Incase of any trouble with pandoc, just run simple experiments specified in the script

1. Run `start-container-for-experiment.sh` to start the container that sleeps forever so that we can access the machine using another terminal to do what we want

2. Pandoc related activities

    a. Generate `experiment.tex` file corresponding to `experiment.md` fragment without pandoc default template surrounding it
    ```shell
    pandoc \
      --output=experiment.tex \
      experiment.md
    ```
    b. Same as above but `experiment.tex` surrounded by pandoc default template
    ```shell
    pandoc \
      -s \
      --output=experiment.tex \
      experiment.md
    ```
    
    c. Generate pdf from `experiment.tex` using lualatex, xelatex & pdflatex
    ```shell
    lualatex experiment.tex
    xelatex experiment.tex
    pdflatex experiment.tex
    ```
    
    d. Generate pdf from `experiment.md` using pandoc
    ```shell
    pandoc \
      --output=experiment.pdf \
      experiment.md
    ```
    
    e. Generate epub from `experiment.md` using pandoc
    ```shell
    pandoc \
      --output=experiment.pdf \
      experiment.md
    ```
    
    f. Generate html from `experiment.md` using pandoc
    ```shell
    pandoc \
      --output=experiment.pdf \
      experiment.html
    ```
    
    g. Export pandoc default template
    ```shell
    pandoc -D latex > pandex-default-template.latex
    ```

3. Versions

```shell
# tex version
tex --version
# pandoc version
pandoc --version
```

4. List texlive packages and versions

```shell
# To list all packages
tlmgr info
# To list only installed packages
tlmgr info --only-installed
# To get details about a specific package
tlmgr info babel
```
