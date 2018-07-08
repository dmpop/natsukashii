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

mkdir -p $CONFIG_DIR
date1=$(date +%Y-%m-%d -d "365 days ago")

mkdir -p $FOUND_DIR
echo "Searching for photos from $date1..."

results=$(find "$PHOTOS" -type f -name '*.'$EXT -not -path "*/.@__thumb/*")
lines=$(echo -e "$results" | wc -l)

for line in $(seq 1 $lines)
do
    photo=$(echo -e "$results" | sed -n "$line p")
    date2=$(exiftool -d "%Y-%m-%d" -DateTimeOriginal -S -s "$photo")
    echo "$photo"
    if [ "$date2" =  "$date1" ]; then
	cp "$photo" $FOUND_DIR
    fi
done

if [ ! -z "$(ls -A $FOUND_DIR)" ]; then
    if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl -k \
"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=There%20are%20photos%20from%20${date1}!" \
	 > /dev/null
    fi
    if [ ! -z "$WEB_DIR" ]; then
        rsync -a --delete "$FOUND_DIR/" "$WEB_DIR"/photos
        rm -rf "$FOUND_DIR"
	fi
else
    rm -rf $FOUND_DIR
    if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl -k \
"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=There%20no%20photos%20from%20${date1}!" \
	 > /dev/null
    fi
fi
