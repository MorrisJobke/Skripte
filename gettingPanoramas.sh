#!/bin/bash
wget http://commons.wikimedia.org/wiki/Commons:Featured_pictures/Places/Panoramas -q -O main
< main grep 'a href="/wiki/File' | grep 'thumbinner' > tmp
sed 's/.* href="//g' tmp | sed 's/".*//g' | sed 's/^/http\:\/\/commons\.wikimedia\.org/' > plinks

#wget http://commons.wikimedia.org/wiki/File:Wellington_City_Night.jpg -q -O cur
#< cur grep 'fullImageLink' | sed 's/.* href="//g' | sed 's/".*//g' >> links

zeilen=0
while read line
do
	zeilen=$[$zeilen+1]
done < plinks

rm links

zeile=0
while read line
do
	zeile=$[$zeile+1]
	echo "Analysiere $[$zeile*100/$zeilen]% $zeile/$zeilen"
	wget $line -q -O cur
	< cur grep 'fullImageLink' | sed 's/.* href="//g' | sed 's/".*//g' >> links
done < plinks

rm cur plinks tmp main

zeilen=0
while read line
do
    zeilen=$[$zeilen+1]
done < links

zeile=0
while read line
do
    zeile=$[$zeile+1]
    echo "Downloade $[$zeile*100/$zeilen]% $zeile/$zeilen"
    wget $line -q 
done < links

rm links
