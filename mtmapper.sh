#!/bin/sh

../../minetestmapper --geometry 0:0+512+512 --zoom 2 --colors colors.txt -i "../../worlds/r_place" -o place.png

optipng place.png
