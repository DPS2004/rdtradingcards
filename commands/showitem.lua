local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !showitem")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!showitem command expects 1 argument. Please see c!help for more details.")
    return
  end
  
  local consumable = false

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local curfilename = itemtexttofn(mt[1])
  if not curfilename then
    if constexttofn(mt[1]) then
      curfilename = constexttofn(mt[1])
      consumable = true
    end
  end
  local description = "error"
  local name = "error"
  if consumable then
    description = consumabledb[curfilename].description
    name = consfntoname(curfilename)
    url = consumabledb[curfilename].embed
  else
    description = itemdb[curfilename].description
    name = itemfntoname(curfilename)
    url = itemdb[curfilename].embed
  end
  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " item in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " item in the database. Make sure that you spelled it right!")
    end
    return
  end

  if ((not uj.items[curfilename]) and (not uj.consumables[curfilename])) and (not shophas(curfilename)) then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " item in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. name .. "** item.")
    end
    return
  end

  print("user has item or consumable")
  
  message.channel:send{embed = {
    color = 0x85c5ff,
    title = "Showing item...",
    description = 'Here it is! Your **'.. name .. '** item. The shorthand form is **' .. curfilename .. '**.\n\n*The description on the back reads:*\n> ' .. description,
    image = {
      url = url
    }
  }}
end
return command
