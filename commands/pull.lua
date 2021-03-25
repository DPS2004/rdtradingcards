local command = {}
function command.run(message, mt)
local time = sw:getTime()
  --message.channel:send('haha wowie! discord user '.. message.author.mentionString .. ' whos discord ID happens to be ' .. message.author.id ..' you got a card good job my broski')
  print(message.author.name .. " did !pull")
  local cooldown = 11.5
  
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if not uj.equipped then
    uj.equipped = "nothing"
  end
  if uj.equipped == "stoppedwatch" then
    cooldown = 10
  end
  
  if message.channel.id == privatestuff.specialchannelid then --ssss override
      message.channel:send('Pulling card...')
      local newcard = "ssss45"
      local ncn = fntoname(newcard)
      print(ncn)
      message.channel:send {
          content = 'Woah! '.. message.author.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their inventory.',
          file = "card_images/" .. newcard .. ".png"
        }

      local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
      if uj.inventory[newcard] == nil then
        uj.inventory[newcard] = 1
      else
        uj.inventory[newcard] = uj.inventory[newcard] + 1
      end
      if uj.timespulled == nil then
        uj.timespulled = 1
      else
        uj.timespulled = uj.timespulled + 1
      end
      uj.name = message.author.name .. "#".. message.author.discriminator
      uj.id = message.author.id
      uj.lastpull = time:toHours()
      print(message.author.name .. "#" .. message.author.discriminator .. " is the username")
      print("number of cards is " .. uj.inventory[newcard])
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  else
  
    if uj.lastpull + cooldown <= time:toHours() then
      message.channel:send('Pulling card...')
      local newcard = ptable[uj.equipped][math.random(#ptable[uj.equipped])]
      local ncn = fntoname(newcard)
      print(ncn)
      local extension = ""
      local pico8 = getcardpico(newcard)
      local animated = getcardanimated(newcard)
      if animated then
        extension = ".gif"
      elseif pico8 then
        extension = ".p8.png"
      else
        extension = ".png"
      end
      message.channel:send {
          content = 'Woah! '.. message.author.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their inventory. The shorthand form of this card is **'.. newcard .. '**.',
          file = "card_images/" .. newcard .. extension
        }

      local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
      if uj.inventory[newcard] == nil then
        uj.inventory[newcard] = 1
      else
        uj.inventory[newcard] = uj.inventory[newcard] + 1
      end
      if uj.timespulled == nil then
        uj.timespulled = 1
      else
        uj.timespulled = uj.timespulled + 1
      end
      if not uj.name then
        uj.name = message.author.name .. "#".. message.author.discriminator
      end
      uj.id = message.author.id
      uj.lastpull = time:toHours()
      print(message.author.name .. "#" .. message.author.discriminator .. " is the username")
      print("number of cards is " .. uj.inventory[newcard])
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    else
      --extremely jank implementation, please make this cleaner if possible
      local minutesleft = math.ceil(uj.lastpull * 60 - time:toMinutes() + cooldown * 60)
      local durationtext = ""
      if math.floor(minutesleft / 60) > 0 then
        durationtext = math.floor(minutesleft / 60) .. " hour(s)"
      end
      if minutesleft % 60 > 0 then
        if durationtext ~= "" then
          durationtext = durationtext .. " and "
        end
        durationtext = durationtext .. minutesleft % 60 .. " minute(s)"
      end
      message.channel:send('Please wait ' .. durationtext .. ' before pulling again.')
    end
  end
  cmd.checkcollectors.run(message,mt)
end
return command
  