local function adduse(uj)
  if uj.timesused == nil then
    uj.timesused = 1
  else
    uj.timesused = uj.timesused + 1
  end
  return uj
end

local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !use")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if #mt == 1 or mt[1] == "" then

    if string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" then 
      if uj.tokens == nil then
        uj.tokens = 0
      end
      local numitems = 0
      if uj.items == nil then 
        uj.items = {nothing=true}
      end
      for k,v in pairs(uj.items) do
        numitems = numitems + 1
      end
      if wj.worldstate ~= "largesthole" then
        if numitems < #itempt then
          if uj.tokens >= 2 then
      
            if uj.equipped ~= "brokenmouse" then
              local newmessage = message.channel:send {
                content = 'Will you put two **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')'
              }
              addreacts(newmessage)
              --message.channel:send("IF YOU ARE SEEING THIS, SOMETHING HAS GONE WRONG!!!! <@290582109750427648>")
              local tf = dpf.loadjson("savedata/events.json",{})
              tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usemachine",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
              dpf.savejson("savedata/events.json",tf)
            else
              local loops = 0
              local newitem = "nothing"
              while true do --this is bad!
                newitem = itempt[math.random(#itempt)]
                if not uj.items[newitem] then
                  print("found one!")
                  print(newitem)
                  break
                end
                loops = loops + 1
                print(loops)
              end
              uj.items[newitem] = true
              uj.tokens = uj.tokens - 2
              uj = adduse(uj)
              local newmessage = message.channel:send {
                content = 'After depositing 2 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **' .. itemfntoname(newitem) .. '**! You put the **'.. itemfntoname(newitem) ..'** with your items.'
              }
              dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
              
            end
            
          else
            message.channel:send {
              content = 'You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit two **Tokens**...'
            }
          end
        else
          message.channel:send('You already have every item that is currently available.')
        end
      else
        if uj.tokens >= 4 then
          local newmessage = message.channel:send {
            
            content = 'Will you put four **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')'
          }
          addreacts(newmessage)
          local tf = dpf.loadjson("savedata/events.json",{})
          tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "getladder",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
          dpf.savejson("savedata/events.json",tf)
        else
          message.channel:send {
            content = 'You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit four **Tokens**...'
          }
        end
        
      end
    elseif string.lower(mt[1]) == "hole" then
      if uj.tokens == nil then
        uj.tokens = 0
      end
      
      
      if wj.worldstate == "labopen" or wj.worldstate == "largesthole" or wj.worldstate == "prehole" then
        local newmessage = message.channel:send {
          content = 'The **Hole** is not accepting donations at this time.'
        }
      else
        if uj.tokens > 0 then
          local newmessage = message.channel:send {
            content = 'Will you put a **Token** into the **Hole?** (tokens remaining: ' .. uj.tokens .. ')'
          }
          addreacts(newmessage)
          local tf = dpf.loadjson("savedata/events.json",{})
          tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usehole",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
          dpf.savejson("savedata/events.json",tf)
        else
          local newmessage = message.channel:send {
            content = 'You have no **Tokens** to offer to the **Hole.**'
          }
        end
      end
    elseif string.lower(mt[1]) == "token"  then 
      if uj.tokens > 0 then
        local rnum = math.random(0,1)
        local cflip = ":doctah:"
        if rnum == 0 then
          cflip = "heads"
        else
          cflip = "tails"
        end
        
        message.channel:send {
          
          content = 'You flip a **Token** in the air. It lands on **' .. cflip .. '**.'
        }
      else
        message.channel:send {
          
          content = 'Sadly, you do not have any **Tokens**.'
        }
      end
      uj = adduse(uj)
    elseif string.lower(mt[1]) == "panda"  then    
      if uj.equipped == "coolhat" then
        if not uj.storage.ssss45 then
          message.channel:send {
            
            content = "The **Panda** takes one look at your **Cool Hat**, and puts an **Shaun's Server Statistics Sampling #45** card into your storage out of respect."
          }
          uj.storage.ssss45 = 1
          dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
        else
          
          message.channel:send {
            
            content = ':pensive:'
          }
        end
      else
        message.channel:send {
          
          content = ':flushed:'
        }
      end
      uj = adduse(uj)
    elseif string.lower(mt[1]) == "throne" then       
      message.channel:send {
        
        content = 'It appears that the **Throne** is already in use by the **Panda**.'
      }
      uj = adduse(uj)
    
    elseif string.lower(mt[1]) == "ladder" then
      if wj.worldstate == "labopen" then
        if not wj.labdiscovered then
          wj.labdiscovered = true
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "NEW AREA DISCOVERED: LAB",
            description = 'As you climb down the **Ladder**, you begin to hear the sound of a large computer whirring. Reaching the bottom reveals the source, a huge terminal, in the middle of an **Abandoned Lab.**',
            image = {
              url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
            }
          }}

        else
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Using the ladder...",
            description = 'As you climb down the **Ladder**, you begin to hear the sound of a large computer whirring. Reaching the bottom reveals the source, a huge terminal, in the middle of an **Abandoned Lab.**',
            image = {
              url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
            }
          }}
        end
        
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "Using the ladder...",
          description = 'You attempt to climb down the **Ladder**. Unfortunately, the **Hole** is still too small for you to fit through. You cannot wiggle your way out of it.',
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831868583696269312/nowigglezone.png'
          }
        }}
      end
    elseif (string.lower(mt[1]) == "spider" or string.lower(mt[1]) == "spiderweb" or string.lower(mt[1]) == "web" or string.lower(mt[1]) == "spider web") and wj.labdiscovered then       
      
        
      local newmessage = message.channel:send {
        content = 'Are you okay with seeing a spider?'
      }
      addreacts(newmessage)

      local tf = dpf.loadjson("savedata/events.json",{})
      tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "spideruse",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
      
      

      dpf.savejson("savedata/events.json",tf)
      
    else
      message.channel:send("Sorry, but I don't know how to use " .. mt[1] .. ".")
    end
    




  else
    message.channel:send("Sorry, but the c!use command expects 1 argument. Please see c!help for more details.")
  end
  dpf.savejson("savedata/worldsave.json", wj)
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  