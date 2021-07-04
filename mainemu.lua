-- this is a bad idea


-- BUT IM DOING IT ANYWAYS

_G["json"] = require('libs/json')
_G["fs"] = require('fs')
_G["dpf"] = require('libs/dpf')
_G["emuser"] = {}

io.write("EMU: What user would you like to load?\n")
local defaultuser = io.read()
emuser = dpf.loadjson("emu_users/" .. defaultuser .. ".json", {name = "defaultuser", id = "481293038594304959", mentionString = "<@481293038594304959>", discriminator = "6969", mod = false})





_G["discordia"] = {
  Client = function()
    return {
      on = function(this,trigger, func)
        io.write("EMU: client.on called\n")
        discordia.ons[trigger] = func
      end,
      run = function()
        
        while true do
          
          io.write("waiting for input: ")
          local inp = io.read()
          if string.lower(string.sub(inp, 0, 2)) == 'm!' then
            local messagecontent = string.sub(inp, 3)
            io.write("message detected: " .. messagecontent.. "\n")
            discordia.ons.messageCreate({
              content = messagecontent,
              author = {
                id=emuser.id,
                name = emuser.name,
                mentionString = emuser.mentionString,
                discriminator = emuser.discriminator
              },
              channel = {
                send = function(this, content)
                  --print("sending")
                  if type(content) ~= "string" then
                    content = inspect(content)
                  end
                  io.write("BOT: " .. content .. "\n")
                  
                  return {
                    addReaction = function(self)
                      io.write("EMU: message:addReaction called. Please set a message id: (this will be asked twice, probably)\n")
                      local inp = io.read()
                      self.id = inp --ostor is sus!
                    end
                    
                  }
                end
              },
              guild = {
                getMember = function()
                  io.write("EMU: guild.getMember called\n")
                  return({
                    hasRole = function()
                      io.write("EMU: member:hasRole called\n")
                      return emuser.mod
                    end
                  })
                  
                end
              }
            })
          end
          if string.lower(string.sub(inp, 0, 2)) == 'r!' then
            local messageid = string.sub(inp, 3)
            io.write("reaction detected: " .. messageid.. "\n")
            io.write("what emoji? (✅ or ❌): ")
            local inp = io.read()
            discordia.ons.reactionAdd(
              {
                emojiName = inp,
                message = {
                  id = messageid,
                  channel = {
                    send = function(this, content)
                      --print("sending")
                      if type(content) ~= "string" then
                        content = inspect(content)
                      end
                      io.write("BOT: " .. content .. "\n")
                      
                      return {
                        addReaction = function(self)
                          io.write("EMU: message:addReaction called. Please set a message id: (this will be asked twice, probably)\n")
                          local inp = io.read()
                          self.id = inp --ostor is sus!
                        end
                        
                      }
                    end
                  }
                }
              },
              emuser.id
            )
          end

        end
        
      end,
      setGame = function()
        
      end
    
    }
    
  end,
  
  ons = {},
  
  Stopwatch = function()
    
    io.write("EMU: Stopwatch created\n")
      
    return {
      start = function()
        io.write("EMU: Stopwatch.start called\n")
      end,
      getTime = function()
        io.write("EMU: Stopwatch.getTime called.\n")
        return {
          toHours = function()
            io.write("EMU: Stopwatch.getTime:toHours called. Please enter a value: \n")
            local inp = io.read()
            return tonumber(inp)
          end,
          toDays = function()
            io.write("EMU: Stopwatch.getTime:toDays called. Please enter a value: \n")
            local inp = io.read()
            return tonumber(inp)
          end
          
        }
      end
    }
  end

}
_G["client"] = discordia.Client()
_G["prefix"] = "c!"

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