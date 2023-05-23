# mtPlace
The source code for the game the mtPlace server runs.

## Notes on setting up
This is a game, like any other. Recursively clone this repository to your games folder, make a new singlenode world with this game and start up a Minetest server for it.

For the screenshotter, see `screenshot.sh`. It uses `minetestmapper` to take a top-down screenshot of the map, saves the image, runs `optipng` in it and symlinks it in such a way that the latest image is always available at `/place.png` in the website's root folder. This script should be run with a cronjob or something similar.
