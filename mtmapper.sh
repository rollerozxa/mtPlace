#!/bin/sh

../../minetestmapper --geometry -128:-128+256+256 --zoom 4 --colors colors.txt -i ../../worlds/r_place -o place.png

optipng place.png
