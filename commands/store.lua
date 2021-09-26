local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !store")
  if not (#mt == 1 or #mt == 2) then
    message.channel:send("Sorry, but the c!store command expects 1 or 2 arguments. Please see c!help for more details.")
    return
  end

  print(string.sub(message.content, 0, 8))
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  
  local item1 = texttofn(mt[1])
  if not item1 then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not uj.inventory[item1] then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. cdb[item1].name .. "** card in your inventory.")
    end
    return
  end

  print("success!!!!!")
  local numcards = 1
  if tonumber(mt[2]) then
    if tonumber(mt[2]) > 1 then
      numcards = math.floor(mt[2])
    end
  end

  if mt[2] == "all" then
    numcards = uj.inventory[item1]
  end

  if uj.inventory[item1] < numcards then
    message.channel:send("Sorry, but you do not have enough **" .. cdb[item1].name .. "** cards in your inventory.")
      return
  end

  if not uj.skipprompts then
    ynbuttons(message,"<@" .. uj.id .. ">, do you want to put your " .. numcards .. " **" .. cdb[item1].name .. "** card" .. (numcards == 1 and "" or "s") ..  " into storage? This cannot be undone. Click the Yes button to confirm and No to deny.", "store", {numcards = numcards, item1 = item1})
  else
    uj.inventory[item1] = uj.inventory[item1] - numcards
    if uj.inventory[item1] == 0 then uj.inventory[item1] = nil end

    uj.storage[item1] = uj.storage[item1] and uj.storage[item1] + numcards or numcards
    uj.timesstored = uj.timesstored and uj.timesstored + numcards or numcards

    message.channel:send("<@" .. uj.id .. "> successfully put " .. uj.pronouns["their"] .. " " .. numcards .. " **" .. cdb[item1].name .. "** card" .. (numcards == 1 and "" or "s") .. " into storage.")
    dpf.savejson(ujf, uj)
    cmd.checkcollectors.run(message, mt)
    cmd.checkmedals.run(message, mt)
  end
end
return command
