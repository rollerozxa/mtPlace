#!/bin/bash

IMGDIR="/srv/mtplace/screenshots"
SRVDIR="/home/debian/minetest/servers/mtplace"
GAMEDIR="/home/debian/minetest/games/place"
MTMAPPER="/home/debian/minetest/minetestmapper"

date=$(date '+%Y-%m-%d_%H-%M-%S')

$MTMAPPER --geometry 0:0+512+512 --zoom 2 --colors $GAMEDIR/colors.txt -i $SRVDIR/world -o $IMGDIR/$date.png

optipng $IMGDIR/$date.png

ln -f -s screenshots/$date.png /srv/mtplace/place.png
