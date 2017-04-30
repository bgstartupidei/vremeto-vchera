#!/bin/bash

cities=(
	725905 # Vidin
	727221 # Silistra
	727523 # Ruse
	729114 # Montana
	728203 # Pleven
	727233 # Shumen
	725993 # V.Tarnovo
	726050 # Varna
	727011 # Sofia
	732770 # Burgas
	733191 # Blagoevgrad
	728193 # Plovdiv
	727079 # Sliven
	725578 # Yambol
	727447 # Sandanski
	729794 # Kardzaly
)

# get current hour
hour="$(date +%H)"
current="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
filename="${current}/${hour}.json"
public_html="$(realpath ${current}/../public_html/)"
latest="${public_html}/latest.json"

list=''
for i in "${cities[@]}"
do
   list="${list}${i},"
done

url="http://api.openweathermap.org/data/2.5/group?id=${list%?}&units=metric&appid=${API_KEY}"

# move yesterday's file to latest
if [ -f ${filename} ]
then
	mv "${filename}" "${latest}"
fi

# get today's file
curl -s "${url}" | sed -f translate.sed > "${filename}"
