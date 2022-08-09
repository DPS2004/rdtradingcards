local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pull")
  if not message.guild then
    message.channel:send("Sorry, but you cannot pull cards in DMs!")
    return
  end

  local cooldown = 11.5
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  if not uj.equipped then
    uj.equipped = "nothing"
  end

  if uj.equipped == "stoppedwatch" then
    cooldown = 10
  end

  if uj.lastpull + cooldown > time:toHours() then
    --extremely jank implementation, please make this cleaner if possible
    local minutesleft = math.ceil(uj.lastpull * 60 - time:toMinutes() + cooldown * 60)
    local durationtext = ""
    if math.floor(minutesleft / 60) > 0 then
      durationtext = math.floor(minutesleft / 60) .. " hour"
      if math.floor(minutesleft / 60) ~= 1 then durationtext = durationtext .. "s" end
    end
    if minutesleft % 60 > 0 then
      if durationtext ~= "" then durationtext = durationtext .. " and " end
      durationtext = durationtext .. minutesleft % 60 .. " minute"
      if minutesleft % 60 ~= 1 then durationtext = durationtext .. "s" end
    end
    
    message.channel:send('Please wait ' .. durationtext .. ' before pulling again.')
    return
  end
  
  if not uj.names then
    uj.names = {}
    uj.names[message.author.name .. "#" .. message.author.discriminator] = true
  end
  uj.id = message.author.id
  uj.lastpull = time:toHours()
  print(inspect(uj.names) .. " is/are the nickname/s")
  
  if uj.sodapt and uj.sodapt.pull then
    uj.lastpull = uj.lastpull + uj.sodapt.pull
    uj.sodapt.pull = nil
    if uj.sodapt == {} then uj.sodapt = nil end
  end
  
  dpf.savejson("savedata/" .. message.author.id .. ".json", uj)

  message.channel:send('Pulling card...')

  uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local pulledcards = {ptable[uj.equipped][math.random(#ptable[uj.equipped])]}
  if not uj.conspt then
    uj.conspt = "none"
  end
  if uj.conspt == "none" then
    if uj.equipped == "fixedmouse" and math.random(6) == 1 then
      table.insert(pulledcards, ptable[uj.equipped][math.random(#ptable[uj.equipped])])
      uj.timesdoubleclicked = uj.timesdoubleclicked and uj.timesdoubleclicked + 1 or 1
    end
  else
    if uj.conspt == "sbubby" then
      pulledcards = { "sandwich" }
    elseif uj.conspt:sub(1, 6) == "season" then
      pulledcards = {}
      table.insert(pulledcards, constable[uj.conspt][math.random(#constable[uj.conspt])])
      table.insert(pulledcards, constable[uj.conspt][math.random(#constable[uj.conspt])])
      table.insert(pulledcards, constable[uj.conspt][math.random(#constable[uj.conspt])])
    else
      pulledcards = { constable[uj.conspt][math.random(#constable[uj.conspt])] }
    end
    if uj.conspt == "quantummouse" then
      table.insert(pulledcards, constable["quantummouse"][math.random(#constable["quantummouse"])])
      if uj.equipped == "fixedmouse" and math.random(6) == 1 then
        table.insert(pulledcards, constable["quantummouse"][math.random(#constable["quantummouse"])])
      end
    end
    uj.conspt = "none"
  end

  for i, v in ipairs(pulledcards) do
    uj.inventory[v] = uj.inventory[v] and uj.inventory[v] + 1 or 1
    uj.timespulled = uj.timespulled and uj.timespulled + 1 or 1
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)

	if doinfodeskpull then
		pulledcards = {'rdcards'}
	end

  for i, v in ipairs(pulledcards) do
    local cardname = cdb[v].name

    local title = "Woah!"
    if uj.equipped == "okamiiscollar" then title = "Woof!" end
    if v == "yor" or v == "yosr" or v == "your" then title = "Yo!" end
    if i == 2 then title = "Doubleclick!" end
    if i == 3 then title = "Tripleclick!!!" end

    if v == "rdnot" then
      message.channel:send("```" .. title .. "\n@" .. message.author.name .. " got a What is RD Not? card! The What is RD Not? card has been added to " .. uj.pronouns["their"] .. " inventory. The shorthand form of this card is rdnot.\n" .. [[
_________________
| SR            |
|               |
|    \____/     |
|    / TT \  /  |
|   /|____|\/   |
|     l  l      |
|             𝅘𝅥𝅯 |
_________________```]])
    elseif not cdb[v].spoiler then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = title,
        description = message.author.mentionString .. ' got a **' .. cardname .. '** card! The **' .. cardname .. '** card has been added to ' .. uj.pronouns["their"] .. ' inventory. The shorthand form of this card is **' .. v .. '**.',
        image = {url = type(cdb[v].embed) == "table" and cdb[v].embed[math.random(#cdb[v].embed)] or cdb[v].embed}
      }}
    else
      print("spider moments")
      message.channel:send{
        content = "**" .. title .. "**\n" .. message.author.mentionString .. ' got a **' .. cardname ..'** card! The **' .. cardname .. '** card has been added to ' .. uj.pronouns["their"]..' inventory. The shorthand form of this card is **' .. v .. '**.',
        file = "card_images/SPOILER_" .. v .. ".png"
      }
    end
    if not uj.togglecheckcard then
      if not uj.storage[v] then
        message.channel:send('You do not have the **' .. cardname.. '** card in your storage!')
      end
    end
  end
end
return command
