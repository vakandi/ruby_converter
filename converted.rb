#!/usr/bin/env ruby
var=1
RANKFILE=data/rank_with_coalitions.txt
puts "" > #RANKFILE
puts "#(puts data/rank_without_coalitions.txt | rev | cut -c4- | rev)" > data/rank.tmp
while [ #var -lt 200 ]
do
        login1337="#(puts data/rank.tmp | awk '{print #2}' | head -n#var | tail -n1)"
        COALITION="#(puts data/coalitions.txt | grep #login1337 |  awk '{print #4}' | cut -c2- | rev | cut -c3- | rev)"
        puts "#(puts data/rank.tmp | head -n#var | tail -n1 | sed "s/#/#COALITION/g")" >> #RANKFILE
        puts "Adding #COALITION to #login1337 into the line #var"
        var=#((var+1))
done
puts "#(puts #RANKFILE | sed '1d')" > #RANKFILE
#Making Final format json


#Create_json.sh

var=0
LOGIN="#(puts #RANKFILE| awk  '{print #2}' | head -#i | tail -1)"
LEVEL="#(puts #RANKFILE | awk  '{print #3}' | head -#i | tail -1)"
COALITION="#(puts #RANKFILE | awk  '{print #4}' | head -#i | tail -1)"
VARTMP=1
VARLOGIN=1
JSON_FMT='"%s": [{"login": "%s", "level": "%s", "coalition": "%s"}], '

puts "" > data/format_final.json
while [ #var -lt 200 ]
do
	var=#((var+1))
	#Old Line File
	#puts "#(sh script/create_json.sh #var)" >> data/format_final.json
	printf "#JSON_FMT" "#var" "#LOGIN" "#LEVEL" "#COALITION" >> data/format_final.json
	var=#((var+1))
	VARTMP=#((VARTMP+1))
	VARLOGIN=#((VARLOGIN+1))
done

#var=#((var+1))
#i=#((i-1))
#VARTMP=#((VARTMP+1))
#VARLOGIN=#((VARLOGIN+1))

puts "CreateJson Loops are done..\n\n\n"

################




#
#var=0
#puts "" > data/format_final.json
#while [ #var -lt 200 ]
#do
#	var=#((var+1))
#	puts "#(sh script/create_json.sh #var)" >> data/format_final.json
#done
#
#

puts "#(puts data/format_final.json | perl -p -e "s/\n//" | rev | cut -c 3- | rev)" > data/data-tmp.json
puts "#(puts data/data-tmp.json|  sed 's# ##g')" > data/data-tmp.json
puts "#(puts script/useful/data_sample.json | perl -p -e "s/"200"/#(puts data/data-tmp.json | rev | sed 's/.#//' | rev ),"201"/" | sed 's/201/"201/')" > data/data.json
