#!/usr/bin/env bash

# Author: Dmitri Popov, dmpop@linux.com
# License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
# Source code: https://gitlab.com/dmpop/natsukashii

echo
echo "---------------------------------------"
echo "Hello! Let's find photos from the past!"
echo "---------------------------------------"
echo

CONFIG_DIR=$(dirname "$0")
CONFIG="${CONFIG_DIR}/natsukashii.cfg"
FOUND_DIR="$CONFIG_DIR/found"

if [ ! -f "$CONFIG" ]; then
    echo "Specify directory containing photos and press [ENTER]:"
    read PHOTOS
    echo 'PHOTOS="'$PHOTOS'"' >> "$CONFIG"
    echo "Specify the desired file extension (e.g., JPG) and press [ENTER]:"
    read EXT
    echo 'EXT="'$EXT'"' >> "$CONFIG"
    echo "Specify web directory and press [ENTER]"
    echo "Skip to disable:"
    read WEB_DIR
    echo 'WEB_DIR="'$WEB_DIR'"' >> "$CONFIG"
    echo "Enter your Notify token and press [ENTER]."
    echo "Skip to disable:"
    read NOTIFY_TOKEN
    echo 'NOTIFY_TOKEN="'$NOTIFY_TOKEN'"' >> "$CONFIG"
    fi

source "$CONFIG"

if [ ! -x "$(command -v exiftool)" ] ; then
    echo "ExifTool is missing."
    exit 1
    fi

if [ -z "$1" ]; then
    date1=$(date +%Y-%m-%d -d "365 days ago")
    echo "Searching for photos from one year ago ..."
else
    date1=$(date +%m-%d)
    echo "Searching for photos from the past ..."
    fi

mkdir -p "$FOUND_DIR"
mkdir -p "$WEB_DIR/photos"

results=$(find "$PHOTOS" -type f -name '*.'$EXT -not -path "*/.@__thumb/*")
lines=$(echo -e "$results" | wc -l)

for line in $(seq 1 $lines)
do
    photo=$(echo -e "$results" | sed -n "$line p")
    if [ -z "$1" ]; then
	date2=$(exiftool -d "%Y-%m-%d" -DateTimeOriginal -S -s "$photo")
    else
	date2=$(exiftool -d "%m-%d" -DateTimeOriginal -S -s "$photo")
	fi
    echo "$photo"
    if [ "$date2" =  "$date1" ]; then
	cp "$photo" "$FOUND_DIR"
    fi
done

if [ ! -z "$(ls -A $FOUND_DIR)" ]; then
    mogrify -resize "800>" "$FOUND_DIR/*.$EXT"
    rsync -a --delete "$FOUND_DIR/" "$WEB_DIR/photos"
    rm -rf "$FOUND_DIR"
if [ ! -z "$NOTIFY_TOKEN" ]; then
    TEXT=$(sed 's/ /%20/g' <<< "You have photos from the past!")
    curl -k \
	"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=${TEXT}" \
	> /dev/null
fi
else
    rsync -a --delete "$FOUND_DIR/" "$WEB_DIR/photos"
    cp "$CONFIG_DIR/nopicture.jpg" "$WEB_DIR/photos"
    rm -rf "$FOUND_DIR"
    if [ ! -z "$NOTIFY_TOKEN" ]; then
	TEXT=$(sed 's/ /%20/g' <<< "No photos from the past today.")
	curl -k \
"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=${TEXT}" \
	 > /dev/null
    fi
fi
