local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !throw")

  local time = sw:getTime()
  local timeout = 20
  if not message.guild then
    message.channel:send("Sorry, but you cannot throw in DMs!")
    return
  end

  if not (#mt == 1) then
    message.channel:send("Sorry, but the c!throw command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)

  local cardfilename, consfilename = texttofn(mt[1]), constexttofn(mt[1])
  local curfilename = cardfilename or consfilename
  
  if not (curfilename) then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find " .. mt[1] .. " in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find " .. mt[1] .. " in the database. Make sure that you spelled it right!")
    end
    return
  end

  local thrownname = cardfilename and cdb[cardfilename].name or consdb[consfilename].name

  if not (cardfilename and uj.inventory[cardfilename] or uj.consumables[consfilename]) then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find " .. mt[1] .. " in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have **" .. thrownname .. "** in your inventory.")
    end
    return
  end

  message.channel:send(trf("throw",{ping = message.author.mentionString, name = thrownname}) .. " Type this command within " .. timeout .. " seconds to catch it!\n`c!catch " .. (curfilename) .. "`")
  
  uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  if cardfilename then
    uj.inventory[cardfilename] = uj.inventory[cardfilename] - 1
    if uj.inventory[cardfilename] == 0 then uj.inventory[cardfilename] = nil end
  else
    uj.consumables[consfilename] = uj.consumables[consfilename] - 1
    if uj.consumables[consfilename] == 0 then uj.consumables[consfilename] = nil end
  end
  uj.timesthrown = uj.timesthrown and uj.timesthrown + 1 or 1

  local tj = dpf.loadjson("savedata/thrown.json", {})
  if not tj[curfilename] then tj[curfilename] = {tostring(time:toHours())} else table.insert(tj[curfilename], tostring(time:toHours())) end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  print("user had item, removed from original user")
  dpf.savejson("savedata/thrown.json", tj)

  if not client:waitFor(tostring(time:toHours()), timeout * 1000) then
    print((curfilename) .. " hasn't been caught!")
    tj = dpf.loadjson("savedata/thrown.json", {})
    uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)

    for x = #tj[curfilename], 1, -1 do
      if tj[curfilename][x] == tostring(time:toHours()) then
        table.remove(tj[curfilename], x)
        break
      end
    end

    if cardfilename then
      uj.inventory[cardfilename] = uj.inventory[cardfilename] and uj.inventory[cardfilename] + 1 or 1
    else 
      uj.consumables[consfilename] = uj.consumables[consfilename] and uj.consumables[consfilename] + 1 or 1
    end

    if not next(tj[curfilename]) then tj[curfilename] = nil end
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    dpf.savejson("savedata/thrown.json", tj)
    message.channel:send(trf("fall",{name = thrownname, item = cardfilename and "card" or "item"}) .. message.author.mentionString .. " picked it up and put it back in " .. uj.pronouns["their"] .. " inventory.")
  end
end
return command
