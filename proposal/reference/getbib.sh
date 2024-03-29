#!/bin/bash
#hupili
#20120131

#this file is originated in my p2p project, 
#now adapted for private-Bt study. 
#
#20120316
#hey! It adapts again for my spectral algorithm 
#course project! You see, sth. is so useful 
#that you keep on adapting it everywhere. 
#As it's said, whenever you have a hammer, 
#everything becomes a snail. I totally agree...
#This way of managing bibliography is so 
#convenient! 
#
#Feel free to adapt this method to your thesis! 

#NOTICE:
#   * [INPUT] gen_bib_body.tex : modify this file
#     to cite elements from .bib library, 
#     which should be specified in later 
#     part of this script. 
#   * [INPUT] manual_bib.tex : modify this file 
#     to create bib entries that are not in 
#     the .bib library listed below. 
#   * [OUTPUT] gen_bib.bbl : this is the output file 
#     of this script. Include it in .tex 
#     article source file. 

mkdir -p tmp

declare -a LIB_BIB=( \ 
"/home/hpl/library/database/social-network/mylibrary.bib" 
"/home/hpl/library/database/data-mining/mylibrary.bib" 
"/home/hpl/library/database/spectral-algorithm/mylibrary.bib" 
"/home/hpl/library/database/general-networking/mylibrary.bib" 
)

rm -f tmp/all.bib

for i in ${LIB_BIB[@]}
do
	echo $i
	cat "$i" >> tmp/all.bib
	grep "^@.*," tmp/all.bib  | sed -e 's/@.*{//g' -e 's/,$//g' > tmp/all.bib.key
done

rm -f tmp/gen_bib.tex 
rm -f tmp/gen_bib_body.tex

cp gen_bib_body.tex tmp/gen_bib_body.tex

cat gen_bib_begin.tex tmp/gen_bib_body.tex gen_bib_end.tex > tmp/gen_bib.tex

cd tmp
latex gen_bib
bibtex gen_bib
cd -

#cp -f tmp/gen_bib.bbl .
rm -f gen_bib.bbl
#sed 's/\\end\{thebibliography\}//g' tmp/gen_bib.bbl > gen_bib.bbl
sed 's/\\end{thebibliography}//g' tmp/gen_bib.bbl > gen_bib.bbl
cat manual_bib.tex >> gen_bib.bbl
echo '\end{thebibliography}' >> gen_bib.bbl

