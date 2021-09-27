#!/usr/bin/env zsh

# handle headings

# h1
perl -i -0777 -pe 's/(<h1[^>]*?>\s*)/$1## /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h1>\s+(?!\s*<h1))/$1<br>/g' reedsy-body.html

# h2
perl -i -0777 -pe 's/(<h2[^>]*?>\s*)/$1### /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h2>\s+(?!\s*<h2))/$1<br>/g' reedsy-body.html

# h3
perl -i -0777 -pe 's/(<h3[^>]*?>\s*)/$1#### /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h3>\s+(?!\s*<h3))/$1<br>/g' reedsy-body.html

# h4
perl -i -0777 -pe 's/(<h4[^>]*?>\s*)/$1##### /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h4>\s+(?!\s*<h4))/$1<br>/g' reedsy-body.html

# h5
perl -i -0777 -pe 's/(<h5[^>]*?>\s*)/$1###### /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h5>\s+(?!\s*<h5))/$1<br>/g' reedsy-body.html

# h6
perl -i -0777 -pe 's/(<h6[^>]*?>\s*)/$1####### /g' reedsy-body.html
perl -i -0777 -pe 's/(<\/h6>\s+(?!\s*<h6))/$1<br>/g' reedsy-body.html

# Replace footnotes with their references
# CSD: https://stackoverflow.com/questions/12680767/perl-regular-expression-matching-on-large-unicode-code-points#comment75632144_12680858
perl -CSD -i -0777 -pe 's/\x{FEFF}(<span\s+contenteditable="false"\s*>\s*\d+\s*<\/span>)\x{FEFF}/[^$1]/g' reedsy-body.html

# Replace blockquote with quotation

perl -i -0777 -pe 's/(<blockquote[^>]*>)/$1>/g' reedsy-body.html
perl -i -0777 -pe 's/(<aside[^>]*>)/$1>/g' reedsy-body.html

# Keep spaces between quotation rows

perl -i -0777 -pe 's/(<\/blockquote>\s*(?!\s*<blockquote))/$1<br>/g' reedsy-body.html
perl -i -0777 -pe 's/(<\/aside>\s*(?!\s*<aside))/$1<br>/g' reedsy-body.html

# Scene break
# draggable is making the text unselectable. Lets get rid of that attribute

#TODO
#`\begin{center}\n   $\ast$~$\ast$~$\ast$\n\end{center}`{=latex}
#`<div class="ql-scene-break"><pre>&amp;#8233;&amp;#8258;&amp;#8233;</pre><br>`{=html}
#`<div class="ql-scene-break"><pre>&amp;#8233;&amp;#8258;&amp;#8233;</pre><br>`{=epub}

#perl -i -0777 -pe 's/(<div class="ql-scene-break" draggable="true">)/<div class="ql-scene-break"><pre>&amp;#8233;&amp;#8258;&amp;#8233;</pre><br>/g' reedsy-body.html

perl -i -0777 -pe 's/(<div class="ql-scene-break" draggable="true">)/<div class="ql-scene-break"><br>----<br>/g' reedsy-body.html

#perl -i -0777 -pe 's///g' reedsy-body.html
