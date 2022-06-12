-- this is a bad idea

-- BUT IM DOING IT ANYWAYS
_G["realdiscordia"] = require('discordia-with-buttons')
_G["json"] = require('libs/json')
_G["fs"] = require('fs')
--from https://github.com/DeltaF1/lua-tracery, TODO properly follow the license lmao
_G["tracery"] = require('libs/tracery')
_G["dpf"] = require('libs/dpf')
_G["emuser"] = {}
_G["EMULATOR"] = true
io.write("EMU: What user would you like to load?\n")
local defaultuser = io.read()
local emuser = dpf.loadjson("emu_users/" .. defaultuser .. ".json", {name = "defaultuser", id = "481293038594304959", mentionString = "<@481293038594304959>", discriminator = "6969", mod = false})

_G["disc"] = {
  messageid = 0,
  send = function(content)
    local printmsg = content
    if type(content) ~= "string" then
      printmsg = inspect(content)
      if content.components then
        -- handle and store buttons somehow
      end
    end
    io.write("BOT: " .. printmsg .. "\n")
    disc.messageid = disc.messageid + 1
    return {
      id = tostring(disc.messageid),
      addReaction = function(self)
        io.write("EMU: message:addReaction called. Please set a message id: (this will be asked twice, probably)\n")
        local inp = io.read()
        self.id = inp --ostor is sus!
      end
    }
    
  end
  
   
}

_G["discordia"] = {
  Client = function()
    return {
      user = {
        id = "795144198252658718"
      },
      waitFor = function()
      end,
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
                  return disc.send(content)
                  
                    
                  
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
                      return disc.send(content)
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
--_G["utils"] = require('libs/utils')
_G["inspect"] = require('libs/inspect')
_G["vips"] = require('vips')

-- load all the extensions
realdiscordia.extensions()

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

print("ok commands loaded, doing reactions")

print("Resetting clocks...")
resetclocks()

print("Clearing cache")
clearcache()

print("Stocking shop")
stockshop()

client:run(privatestuff.botid)

client:setGame("with cards | c!help")