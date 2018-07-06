#!/usr/bin/env bash

# Author: Dmitri Popov, dmpop@linux.com
# License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
# Source code: https://gitlab.com/dmpop/natsukashii

# opkg install perl-image-exiftool

echo
echo "--------------------------------"
echo "    Hello! I'm Natsukashii.     "
echo "Let's find photos from the past!"
echo "--------------------------------"
echo

CONFIG_DIR=$(dirname "$0")
CONFIG="${CONFIG_DIR}/natsukashii.cfg"

if [ ! -f "$CONFIG" ]; then
    echo "Specify working directory and press [ENTER]:"
    read WORK_DIR
    echo 'WORK_DIR="'$WORK_DIR'"' >> "$CONFIG"
    echo "Specify the desired file extension (e.g., JPG) and press [ENTER]:"
    read EXT
    echo 'EXT="'$EXT'"' >> "$CONFIG"
    echo "Specify directory containing photos and press [ENTER]:"
    read PHOTOS
    echo 'PHOTOS="'$PHOTOS'"' >> "$CONFIG"
    echo "Enter your Notify token and press [ENTER]."
    echo "Skip to disable notifications:"
    read NOTIFY_TOKEN
    echo 'NOTIFY_TOKEN="'$NOTIFY_TOKEN'"' >> "$CONFIG"
    fi

source "$CONFIG"

if [ ! -x "$(command -v exiftool)" ] ; then
    echo "ExifTool is missing."
    exit 1
    fi

mkdir -p $WORK_DIR
date1=$(date +%Y-%m-%d -d "365 days ago")
last_year_dir="$WORK_DIR/$date1"

mkdir -p $last_year_dir
echo "Searching for photos from $date1..."

results=$(find "$PHOTOS" -type f -name '*.'$EXT -not -path "*/.@__thumb/*")
lines=$(echo -e "$results" | wc -l)

for line in $(seq 1 $lines)
do
    photo=$(echo -e "$results" | sed -n "$line p")
    date2=$(exiftool -d "%Y-%m-%d" -DateTimeOriginal -S -s "$photo")
    echo "$photo"
    if [ "$date2" =  "$date1" ]; then
	cp "$photo" $last_year_dir
    fi
done

if [ ! -z "$(ls -A $last_year_dir)" ]; then
    if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl -k \
"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=Momo%20has%20found%20photos%20from%20${date1}!" \
	 > /dev/null
    fi
else
    rm -rf $last_year_dir
    if [ ! -z "$NOTIFY_TOKEN" ]; then
    curl -k \
"https://us-central1-notify-b7652.cloudfunctions.net/sendNotification?to=${NOTIFY_TOKEN}&text=Momo%20has%20found%20no%20photos%20from%20${date1}!" \
	 > /dev/null
    fi
fi
