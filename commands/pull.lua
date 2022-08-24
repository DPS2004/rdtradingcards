local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pull")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/pull.json", "")
  
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end

  local cooldown = 11.5

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
      durationtext = math.floor(minutesleft / 60) .. lang.time_hour
	  if lang.needs_plural_s == true then
        if math.floor(minutesleft / 60) ~= 1 then durationtext = durationtext .. lang.time_plural_s end
      end
	end
    if minutesleft % 60 > 0 then
      if durationtext ~= "" then durationtext = durationtext .. lang.time_and end
      durationtext = durationtext .. minutesleft % 60 .. lang.time_minute
	  if lang.needs_plural_s == true then
        if minutesleft % 60 ~= 1 then durationtext = durationtext .. lang.time_plural_s end
	  end
    end
    
    message.channel:send(lang.wait_message_1 .. durationtext .. lang.wait_message_2)
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

  message.channel:send(lang.pulling_card)

  uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local pulledcards = {}
  if uj.disablecommunity then
    pulledcards = {ptablenc[uj.equipped][math.random(#ptablenc[uj.equipped])]}
  else
    pulledcards = {ptable[uj.equipped][math.random(#ptable[uj.equipped])]}
  end
  
  if not uj.conspt then
    uj.conspt = "none"
  end
  if uj.conspt == "none" then
    if uj.equipped == "fixedmouse" and math.random(6) == 1 then
	
	  if uj.disablecommunity then
		  table.insert(pulledcards, ptablenc[uj.equipped][math.random(#ptablenc[uj.equipped])])
	  else
		  table.insert(pulledcards, ptable[uj.equipped][math.random(#ptable[uj.equipped])])
	  end
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
	    if uj.disablecommunity then
        table.insert(pulledcards, constablenc["quantummouse"][math.random(#constablenc["quantummouse"])])
	    else
	      table.insert(pulledcards, constable["quantummouse"][math.random(#constable["quantummouse"])])
	    end
	  
      if uj.equipped == "fixedmouse" and math.random(6) == 1 then
        if uj.disablecommunity then
			    table.insert(pulledcards, constablenc["quantummouse"][math.random(#constablenc["quantummouse"])])
		    else
			    table.insert(pulledcards, constable["quantummouse"][math.random(#constable["quantummouse"])])
		    end
        uj.timesdoubleclicked = uj.timesdoubleclicked and uj.timesdoubleclicked + 1 or 1
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

    local title = lang.pulled_woah
    if uj.equipped == "okamiiscollar" then title = lang.pulled_woof end
    if v == "yor" or v == "yosr" or v == "your" then title = lang.pulled_yo end
    if i == 2 then title = lang.pulled_doubleclick end
    if i == 3 then title = lang.pulled_tripleclick end

    if v == "rdnot" then
	  if uj.lang == "ko" then
        message.channel:send("```" .. title .. "\n@" .. message.author.name .. lang.rdnot_message_1 .. lang.rdnot_message_2 .. [[
_________________
| SR            |
|               |
|    \____/     |
|    / TT \  /  |
|   /|____|\/   |
|     l  l      |
|             𝅘𝅥𝅯 |
_________________```]])
	  else
	    message.channel:send("```" .. title .. "\n@" .. message.author.name .. lang.rdnot_message_1 .. uj.pronouns["their"] .. lang.rdnot_message_2 .. [[
_________________
| SR            |
|               |
|    \____/     |
|    / TT \  /  |
|   /|____|\/   |
|     l  l      |
|             𝅘𝅥𝅯 |
_________________```]])
	  end
    elseif not cdb[v].spoiler then
	  if uj.lang == "ko" then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = title,
        description = message.author.mentionString .. lang.pulled_message_1 .. cardname .. lang.pulled_message_2 .. cardname .. lang.pulled_message_3 .. lang.pulled_message_4 .. v .. lang.pulled_message_5,
        image = {url = type(cdb[v].embed) == "table" and cdb[v].embed[math.random(#cdb[v].embed)] or cdb[v].embed}
      }}
	  else
	    message.channel:send{embed = {
        color = 0x85c5ff,
        title = title,
        description = message.author.mentionString .. lang.pulled_message_1 .. cardname .. lang.pulled_message_2 .. cardname .. lang.pulled_message_3 .. uj.pronouns["their"] .. lang.pulled_message_4 .. v .. lang.pulled_message_5,
        image = {url = type(cdb[v].embed) == "table" and cdb[v].embed[math.random(#cdb[v].embed)] or cdb[v].embed}
      }}
	  end
    else
      print("spider moments")
      if uj.lang == "ko" then
	    message.channel:send{
          content = "**" .. title .. "**\n" .. message.author.mentionString .. lang.pulled_message_1 .. cardname .. lang.pulled_message_2 .. cardname .. lang.pulled_message_3 .. lang.pulled_message_4 .. v .. lang.pulled_message_5,
          file = "card_images/SPOILER_" .. v .. ".png"
        }
	  else
	    message.channel:send{embed = {
        color = 0x85c5ff,
        title = title,
        description = message.author.mentionString .. lang.pulled_message_1 .. cardname .. lang.pulled_message_2 .. cardname .. lang.pulled_message_3 .. uj.pronouns["their"] .. lang.pulled_message_4 .. v .. lang.pulled_message_5,
        image = {url = type(cdb[v].embed) == "table" and cdb[v].embed[math.random(#cdb[v].embed)] or cdb[v].embed}
      }}
	  end
    end
    if not uj.togglecheckcard then
      if not uj.storage[v] then
        message.channel:send(lang.not_in_storage_1 .. cardname .. lang.not_in_storage_2)
      end
    end
  end
end
return command
