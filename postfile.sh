#!/bin/bash
#Description: this script is used to generate a random new post for hugo website

hugo new site hugosite

cd hugosite

#generate a new post file with the given name or use a random name
if [ ! -n "$1" ] ;then
  ra=$RANDOM
else
  ra=$1  
fi
  
if [ ! -f "content/post/$ra.md" ]; then  
  hugo new post/$ra.md
else 
  echo 'Error, '$ra'.md already exists, please change the file name '
  exit
fi  

#echo the output of fortune command into the post file
fortune >> content/post/$ra.md

#download hugo themes
git clone https://github.com/vaga/hugo-theme-m10c.git themes/m10c

#generate the static content of the website
use_theme='m10c'
hugo -t $use_theme 

#git push 
cd public
git commit -m 'generate the static content of the website with new post file '$ra.md
git push
