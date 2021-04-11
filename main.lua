-- ok i know ths code is hot stinky garbage but it *works*, god damn-it.


-- it works most of the time. most of the time.
_G["discordia"] = require('discordia')
_G["client"] = discordia.Client()
_G["prefix"] = "c!"
_G["json"] = require('libs/json')
_G["fs"] = require('fs')
_G["dpf"] = require('libs/dpf')
_G["utils"] = require('libs/utils')
_G["inspect"] = require('libs/inspect')
_G["trim"] = function (s)
   return s:match "^%s*(.-)%s*$"
end
_G["attachmentchannel"] = "829197797789532181"



-- import all the commands
_G['cmd'] = {}
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

print("ok commands loaded, doing reactions")

client:on('reactionAdd', function(reaction, userid)
  handlereaction(reaction,userid)


end)
print("resettingclocks")
resetclocks()



client:run(privatestuff.botid)