#!/bin/bash

cities=(
	727011 # Sofia
	728193 # Plovdiv
	726050 # Varna
	732770 # Burgas
	727523 # Ruse
	726848 # Stara Zagora
	728203 # Pleven
	727079 # Sliven
	727233 # Shumen
	725578 # Yambol
	733191 # Blagoevgrad
	725993 # V.Tarnovo
	725905 # Vidin
	729794 # Kardzaly
	729114 # Montana
	727221 # Silistra
	727447 # Sandanski
)

# get current hour
hour="$(date +%H)"
current="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
filename="${current}/${hour}.json"
public_html="$(realpath ${current}/../public_html/)"
latest="${public_html}/latest.json"
translate="${current}/translate.sed"

list=''
for i in "${cities[@]}"
do
   list="${list}${i},"
done

url="http://api.openweathermap.org/data/2.5/group?id=${list%?}&units=metric&appid=${API_KEY}"

# move yesterday's file to latest
if [ -f ${filename} ]
then
	cp "${filename}" "${latest}"
fi

# get today's file
curl -s "${url}" | sed -f "${translate}" > "${filename}"
