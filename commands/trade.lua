local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !trade")
  if not message.guild then
    message.channel:send("Sorry, but you cannot trade cards in DMs!")
    return
  end

  if #mt ~= 3 then
    message.channel:send("Sorry, but the c!trade command expects 3 arguments. Please see c!help for more details.")
    return
  end

  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj2f = usernametojson(mt[2])

  print("checking if user 2 exists")
  if not uj2f then
    message.channel:send("Sorry, but I could not find a user named " .. mt[2] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    return
  end

  print("checking if users are different people")
  if uj2f == ujf then
    message.channel:send("Sorry, you cannot trade with yourself!")
    return
  end

  print("checking if item 1 exists")
  local item1 = texttofn(mt[1])
  if not item1 then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  print("checking if item 2 exists")
  local item2 = texttofn(mt[3])
  if not item2 then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[3] .. " card in the database, or ".. mt[2] .. " does not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[3] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  local uj = dpf.loadjson(ujf, defaultjson)
  local uj2 = dpf.loadjson(uj2f, defaultjson)

  print("checking if u1 has i1")
  if not uj.inventory[item1] then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
    end
    return
  end

  print("checking if u2 has i2")
  if not uj2.inventory[item2] then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[3] .. " card in the database, or ".. mt[2] .. " does not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but ".. mt[2] .. " doesn't have the **" .. fntoname(item2) .. "** card in " .. uj2.pronouns["their"] .. " inventory.")
    end
    return
  end

  print("success!!!!!")
  ynbuttons(message, "<@".. uj2.id ..">, <@" .. uj.id .. "> wants to trade " .. uj.pronouns["their"] .. " **" .. fntoname(item1) .. "** for your **" .. fntoname(item2) .. "**. Click the Yes button to accept and No to deny.", "trade", {uj2f = uj2f, item1 = item1,item2 = item2})
end
return command
