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

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

CONFIG="${ROOT_DIR}/config.cfg"
source "$CONFIG"

if [ ! -x "$(command -v exiftool)" ] || [ ! -x "$(command -v seq)" ] ||
    [ ! -x "$(command -v sed)" ] || [ ! -x "$(command -v mogrify)" ] || [ ! -x "$(command -v php)" ]; then
    echo "Make sure that the following packages are installed on your system:"
    echo "PHP, ExifTool, seq, sed, ImageMagick, cURL"
    exit 1
fi

date1=$(date +%m-%d)
rm -rf "$ROOT_DIR/www/photos/"
mkdir -p "$ROOT_DIR/www/photos"

printf "Working"
spinner &

results=$(find "$PHOTOS" -type f -name '*.'$EXT -not -path "*/.@__thumb/*")
lines=$(echo -e "$results" | wc -l)

for line in $(seq 1 $lines); do
    photo=$(echo -e "$results" | sed -n "$line p")
    date2=$(exiftool -q -q -d "%m-%d" -DateTimeOriginal -S -s "$photo")
    if [ "$date2" = "$date1" ]; then
        cp "$photo" "$ROOT_DIR/www/photos/"
    fi
done

kill "$!"

if [ ! -z "$(ls -A $ROOT_DIR/www/photos)" ]; then
    mogrify -resize "800>" "$ROOT_DIR/www/photos/*"
    if [ $LOCAL_SERVER = true ]; then
        killall php
        php -S 0.0.0.0:$PORT -t "$ROOT_DIR/www" &
    fi
    if [ $FTP = true ]; then
        curl -G "$RM_URL"
        ncftpput -R -v -u "$FTP_USER" -p "$FTP_PASSWD" "$FTP_ADDR" "$FTP_DIR" "$ROOT_DIR/www/photos"
    fi
    if [ $GIF = true ]; then
        convert -delay 300 -loop 0 "$ROOT_DIR/www/photos/*" "$ROOT_DIR/www/photos/$date1.gif"
        gifview -a "$ROOT_DIR/www/photos/$date1.gif" &
    fi
    if [ $NOTIFY = true ]; then
        curl --url 'smtps://'$SMTP_SERVER':'$SMTP_PORT --ssl-reqd \
            --mail-from $MAIL_USER \
            --mail-rcpt $MAIL_USER \
            --user $MAIL_USER':'$MAIL_PASSWORD \
            -T <(echo -e 'From: '$MAIL_USER'\nTo: '$MAIL_TO'\nSubject: Natsukashii has photos for you\n\nYou have photos from the past. :-)')
    fi
else
    killall php
    if [ $NOTIFY = true ]; then
        curl --url 'smtps://'$SMTP_SERVER':'$SMTP_PORT --ssl-reqd \
            --mail-from $MAIL_USER \
            --mail-rcpt $MAIL_USER \
            --user $MAIL_USER':'$MAIL_PASSWORD \
            -T <(echo -e 'From: '$MAIL_USER'\nTo: '$MAIL_TO'\nSubject: Natsukashii has no photos for you\n\nYou have no photos from the past. :-(')
    fi
fi
