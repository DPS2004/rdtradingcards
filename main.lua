-- ok i know ths code is hot stinky garbage but it *works*, god damn-it.

-- it works most of the time. most of the time.
_G["discordia"] = require('discordia')
require("discordia-components")
_G["client"] = discordia.Client()
_G["prefix"] = "c!"
_G["json"] = require('libs/json')
_G["fs"] = require('fs')
--from https://github.com/DeltaF1/lua-tracery, TODO properly follow the license lmao
_G["tracery"] = require('libs/tracery')
_G["dpf"] = require('libs/dpf')
_G["inspect"] = require('libs/inspect')
_G["prosel"] = require('libs/prosel')
_G["vips"] = require('vips')
_G["http"] = require('coro-http')

-- load all the extensions
discordia.extensions()

-- import all the commands
_G['cmd'] = {}
-- import reaction commands
_G['cmdre'] = {}

_G['cmdcons'] = {}

_G['tr'] = {}
local rdb = dofile('commands/reloaddb.lua')
rdb.run(nil,nil,true)
print("exited rdb.run")

_G['sw'] = discordia.Stopwatch()
sw:start()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)
print("yay got past load ready")

client:on('messageCreate', function(message)
  handlemessage(message)
end)

print("Resetting clocks")
resetclocks()

print("Clearing cache")
clearcache()

print("Stocking shop")
stockshop()

client:run(privatestuff.botid)

client:setGame("with cards | c!help")