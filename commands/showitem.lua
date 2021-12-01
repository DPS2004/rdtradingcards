local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !showitem")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!showitem command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  if not uj.consumables then uj.consumables = {} end
  local curfilename = itemtexttofn(mt[1]) or constexttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " item in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " item in the database. Make sure that you spelled it right!")
    end
    return
  end

  local description = itemdb[curfilename] and itemdb[curfilename].description or consdb[curfilename].description
  local name = itemdb[curfilename] and itemdb[curfilename].name or consdb[curfilename].name
  local embedurl = itemdb[curfilename] and itemdb[curfilename].embed or consdb[curfilename].embed

  if not (uj.items[curfilename] or uj.consumables[curfilename] or shophas(curfilename)) then
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
      url = embedurl
    }
  }}
end
return command
