# RDCards

RDCards is a bot that allows for a fully fledged trading card game on the Rhythm Doctor Lounge Discord server.

## Installation and usage

First, you will want to clone this repo, and make a new file in it called "privatestuff.lua". Use the file named "sampleprivatestuff.lua" as a guideline. 

## Quick Install (Windows, for development purposes)

Download the [Quickstart zip](https://cdn.discordapp.com/attachments/830582530045378563/1002600862356611152/quickstart.zip) and extract it to the root of the rdcards repo

To install vips, follow the installation instructions from the [libvips website](https://libvips.github.io/libvips/install.html), then add the libvips bin folder to your PATH. 

if a folder named `savedata` does not exist, make it in the root of the repo.

Then, you can run "run.bat" to launch the bot.

## Advanced Install (other OS, or for hosting)
install [Discordia](https://github.com/SinisterRectus/Discordia) by following its readme.

You also need to install [discordia-interactions](https://github.com/Bilal2453/discordia-interactions) and [discordia-components](https://github.com/Bilal2453/discordia-components) by running `git clone https://github.com/Bilal2453/discordia-components.git ./deps/discordia-components && git clone https://github.com/Bilal2453/discordia-interactions ./deps/discordia-interactions` in the root folder.

To install vips, follow the installation instructions from the [libvips website](https://libvips.github.io/libvips/install.html), then add the libvips bin folder to your PATH. Afterwards, clone the [lua-vips repo](https://github.com/libvips/lua-vips) and copy the src/vips folder to your repo and the src/vips.lua file to the deps folder.

I think you also have to make a folder named `savedata` in here in case you get an error that's like `Uncaught exception: error in error handling`.

# NOTICE
The MIT license only applies to the underlying RDCards code. The license does *not* apply to any other media, including characters, games, art, and screenshots.
