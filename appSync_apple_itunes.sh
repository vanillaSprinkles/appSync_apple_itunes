#!/bin/bash

TMP="/tmp/itunesDLpage"   # itunes download iframe page

#wget --save-cookies apple.c01 http://www.apple.com/itunes/download/

url=$( curl http://www.apple.com/itunes/download/ 2>/dev/null | /bin/grep -Eo "iframe src=\"http.*html\"" | cut -d'"' -f2 )
rm -f $TMP
wget $url -O $TMP  2>/dev/null

macdl=$( /bin/grep -Eo "value='http.*.dmg'"   $TMP | cut -d"'" -f2 )
win32dl=$( /bin/grep -Eo "win.radio.binaryUrl.*iTunesSetup.exe'"  $TMP | cut -d"'" -f3 )
win64dl=$( /bin/grep -Eo "win.64bit.radio.binaryUrl.*.exe'"  $TMP | cut -d"'" -f3 )
rm -f $TMP


echo $macdl
echo $win32dl
echo $win64dl

exit

#wget --save-cookies apple.c02 ${url}

#referrer="https://swdlp.apple.com/iframes/82/en_us/82_en_us.html"
referrer="$url"

#wget --referer=$referrer --load-cookies apple.cf01  https://swdlp.apple.com/iFramesPublisherServiceBroker/ServiceBroker


curl --referer ${referrer} --cookie "$(cat apple.cf01)" https://swdlp.apple.com/iFramesPublisherServiceBroker/ServiceBroker
