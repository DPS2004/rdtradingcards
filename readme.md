# rdtradingcards

rdtradingcards is a bot that allows for a fully fledged trading card game on the Rhythm Doctor Lounge Discord server.

## Installation and usage

First, you will want to download this repo, and make a new file in it called "privatestuff.lua". Use the file named "sampleprivatestuff" as a guideline. 

Next, install [Discordia](https://github.com/SinisterRectus/Discordia) by following its readme.

You also need to install [discordia-interactions](https://github.com/Bilal2453/discordia-interactions) and [discordia-components](https://github.com/Bilal2453/discordia-components) by running `git clone https://github.com/Bilal2453/discordia-components.git ./deps/discordia-components && git clone https://github.com/Bilal2453/discordia-interactions ./deps/discordia-interactions` in the root folder.

To install vips, follow the installation instructions from the [libvips website](https://libvips.github.io/libvips/install.html), then set your PATH to the libvips bin folder. Afterwards, clone the [lua-vips repo](https://github.com/libvips/lua-vips) and copy the src/vips folder to your repo and the src/vips.lua file to the deps folder.

Then, you can run "run.bat" to launch the bot.

I think you also have to make a folder named `savedata` in here in case you get an error that's like `Uncaught exception: error in error handling`.
