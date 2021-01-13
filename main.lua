-- ok i know ths code is hot stinky garbage but it *works*, god damn-it.


-- it works most of the time. most of the time.
local discordia = require('discordia')
local client = discordia.Client()
_G["prefix"] = "c!"
_G["json"] = require('libs/json')
_G["fs"] = require('fs')
_G["dpf"] = require('libs/dpf')
_G["utils"] = require('libs/utils')
_G["inspect"] = require('libs/inspect')
_G["trim"] = function (s)
   return s:match "^%s*(.-)%s*$"
end



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
  if userid ~= "767445265871142933" then
    local ef = dpf.loadjson("savedata/events.json",{})
    print('a reaction with an emoji named '.. reaction.emojiName .. ' was added to a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
    eom = ef[reaction.message.id]
    if eom then
      print('it is an event message being reacted to')
      if eom.etype == "trade" then
        cmdre.trade.run(ef, eom, reaction, userid)
      elseif eom.etype == "store" then
        print('it is a storage message being reacted to')
        cmdre.store.run(ef, eom, reaction, userid)
      end
      
      
      
      
    end
  end


end)
print("resettingclocks")
resetclocks()



client:run(privatestuff.botid)