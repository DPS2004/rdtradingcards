local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !show")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!show command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local curfilename = texttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not ((uj.inventory[curfilename] or uj.storage[curfilename])) and (not shophas(curfilename)) then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. cdb[curfilename].name .. "** card in your inventory or your storage.")
    end
    return
  end

  print("user has card")
  if not cdb[curfilename].spoiler then
    local embeddescription = ""
    if cdb[curfilename].description then
      embeddescription = "\n\n*The description on the back reads:*\n> " .. cdb[curfilename].description
    end
    message.channel:send{embed = {
      color = 0x85c5ff,
      title = "Showing card...",
      description = 
      'Here it is! Your **'.. cdb[curfilename].name .. '** card. The shorthand form is **' .. curfilename .. '**.' .. embeddescription,
      image = {
        url = type(cdb[curfilename].embed) == "table" and cdb[curfilename].embed[math.random(#cdb[curfilename].embed)] or cdb[curfilename].embed
      }
    }}
  else
    print("spiderrrrrrr")
    message.channel:send{
      content = 'Here it is! Your **'.. cdb[curfilename].name .. '** card. The shorthand form is **' .. curfilename .. '**.',
      file = "card_images/SPOILER_" .. curfilename .. ".png"
    }
    if cdb[curfilename].description then
      message.channel:send("The description on the back reads:\n> " .. cdb[curfilename].description)
    end
  end
end
return command
  