# rdtradingcards

rdtradingcards is a bot that allows for a fully fledged trading card game on the Rhythm Doctor Lounge Discord server.

## Installation and usage

First, you will want to download this repo, and make a new file in it called "privatestuff.lua". Use the file named "sampleprivatestuff" as a guideline. 

Next, install [Discordia](https://github.com/SinisterRectus/Discordia) by following its readme.

Install [Discordia-With-Buttons](https://github.com/Readof/Discordia-With-Buttons) by downloading the repo as a zip, and unzip it in deps/ as a folder named "discordia-with-buttons". make sure this folder has an "init.lua" in it.

To install vips, follow the installation instructions from the [libvips website](https://libvips.github.io/libvips/install.html), then set your PATH to the libvips bin folder. Afterwards, clone the [lua-vips repo](https://github.com/libvips/lua-vips) and copy the src/vips folder to your repo and the src/vips.lua file to the deps folder.

Then, you can run "run.bat" to launch the bot.

I think you also have to make a folder named `savedata` in here in case you get an error that's like `Uncaught exception: error in error handling`.
