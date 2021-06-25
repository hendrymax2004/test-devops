#!/bin/bash
#Description: this script is used to generate a random new post for hugo website

if [ ! -d "hugosite" ]; then
	echo 'create new website'
  hugo new site hugosite >> log.txt  
  #download hugo themes
  git clone https://github.com/vaga/hugo-theme-m10c.git themes/m10c
fi

cd hugosite

#generate a new post file with the given name or use a random name
if [ ! -n "$1" ] ;then
  rb=$RANDOM
else
  rb=$1
fi

if [ ! -f "content/post/$rb.md" ]; then
  hugo new post/$rb.md
else
  echo 'Error, '$rb'.md already exists, please change the file name '
  exit
fi

#echo the output of fortune command into the post file
sed '4s/true/false/' content/post/$rb.md
fortune >> content/post/$rb.md


#generate the static content of the website
use_theme='m10c'
hugo -t $use_theme

#git push 
cd public
git commit -m 'generate the static content of the website with new post file '$ra.md
git push

