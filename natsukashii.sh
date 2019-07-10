#!/usr/bin/env bash

# Author: Dmitri Popov, dmpop@linux.com
# License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
# Source code: https://gitlab.com/dmpop/natsukashii

echo
echo "--------------------------------"
echo "     ( ・_・)ノ Hello!           "
echo
echo "Let's find photos from the past!"
echo "--------------------------------"

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $ROOT_DIR
CONFIG="$ROOT_DIR/natsukashii.cfg"

if [ ! -f "$CONFIG" ]; then
    echo "Specify directory containing photos and press [ENTER]:"
    read PHOTOS
    echo 'PHOTOS="'$PHOTOS'"' >> "$CONFIG"
    echo "Specify the desired file extension (e.g., JPG) and press [ENTER]:"
    read EXT
    echo 'EXT="'$EXT'"' >> "$CONFIG"
    echo "Specify the desired port (e.g., 8000) and press [ENTER]:"
    read PORT
    echo 'PORT="'$PORT'"' >> "$CONFIG"
    echo "Enter your Notify token and press [ENTER]."
    echo "Skip to disable:"
    read NOTIFY_TOKEN
    echo 'NOTIFY_TOKEN="'$NOTIFY_TOKEN'"' >> "$CONFIG"
    fi

source "$CONFIG"

if [ ! -x "$(command -v exiftool)" ] || [ ! -x "$(command -v seq)" ] || \
   [ ! -x "$(command -v sed)" ] || [ ! -x "$(command -v mogrify)" ] || [ ! -x "$(command -v php)" ]; then
    echo "Make sure that the following packages are installed on your system:"
    echo "ExifTool, seq, sed, ImageMagick, PHP"
    exit 1
    fi

date1=$(date +%m-%d)
rm -rf "$ROOT_DIR/www/photos/"
mkdir -p "$ROOT_DIR/www/photos"


results=$(find "$PHOTOS" -type f -name '*.'$EXT -not -path "*/.@__thumb/*")
lines=$(echo -e "$results" | wc -l)

for line in $(seq 1 $lines)
do
    photo=$(echo -e "$results" | sed -n "$line p")
    date2=$(exiftool -d "%m-%d" -DateTimeOriginal -S -s "$photo")
    if [ "$date2" =  "$date1" ]; then
	cp "$photo" "$ROOT_DIR/www/photos/"
    fi
done
if [ ! -z "$(ls -A $ROOT_DIR/www/photos)" ]; then
    mogrify -resize "800>" "$ROOT_DIR/www/photos/*"
    if [ -z $1 ]; then
        killall php
        php -S 0.0.0.0:$PORT -t "$ROOT_DIR/www" &
        fi
if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl "https://api.simplepush.io/send/${NOTIFY_TOKEN}/Natsukashii/You have photos from the past!"
fi
else
    killall php
    if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl "https://api.simplepush.io/send/${NOTIFY_TOKEN}/Natsukashii/No photos from the past."
    fi
fi
