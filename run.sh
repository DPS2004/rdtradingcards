#!/usr/bin/env bash

if [ ! -d savedata ]; then mkdir savedata; fi
if [ ! -d vips_out ]; then mkdir vips_out; fi
if [ ! -d vips_out/cache ]; then mkdir vips_out/cache; fi
if [ ! -d vips_out/cache/shop ]; then mkdir vips_out/cache/shop; fi
if [ ! -d vips_out/cache/items ]; then mkdir vips_out/cache/items; fi
if [ ! -d vips_out/cache/cards ]; then mkdir vips_out/cache/cards; fi
luvit main.lua
