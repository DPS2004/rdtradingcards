-- this is a bad idea


-- BUT IM DOING IT ANYWAYS

_G["discordia"] = {
  Client = function()
    return {
      on = function(this,trigger, func)
        discordia.ons[trigger] = func
      end,
      run = function()
        
        while true do
          
          io.write("waiting for input: ")
          local inp = io.read()
          if string.lower(string.sub(inp, 0, 4)) == 'msg!' then
            local messagecontent = string.sub(inp, 5)
            io.write("message detected: " .. messagecontent.. "\n")
            discordia.ons.messageCreate({
              content = messagecontent,
              author = {
                id="290582109750427648",
                name = "DPS2004"
              },
              channel = {
                send = function(this, content)
                  --print("sending")
                  io.write("BOT: " .. content .. "\n")
                end
              }
            })
          
          end
        end
        
      end,
      setGame = function()
        
      end
    
    }
    
  end,
  
  ons = {},
  
  Stopwatch = function()
    return {
      start = function()
        
      end
    }
  end

}
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
  --print("hi")
  handlemessage(message)
end)

print("ok commands loaded, doing reactions")

client:on('reactionAdd', function(reaction, userid)
  handlereaction(reaction,userid)


end)
print("resettingclocks")
resetclocks()



client:run(privatestuff.botid)

client:setGame("with cards | c!help")