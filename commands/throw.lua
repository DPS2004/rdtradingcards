local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !throw")

  local time = sw:getTime()
  local timeout = 20
  if not message.guild then
    message.channel:send("Sorry, but you cannot throw cards in DMs!")
    return
  end

  if not (#mt == 1) then
    message.channel:send("Sorry, but the c!throw command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local tj = dpf.loadjson("savedata/throwncards.json", {})

  local curfilename = texttofn(mt[1])
  
  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not uj.inventory[curfilename] then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory.")
    end
    return
  end

  uj.inventory[curfilename] = uj.inventory[curfilename] - 1
  if uj.inventory[curfilename] == 0 then uj.inventory[curfilename] = nil end

  if not tj[curfilename] then tj[curfilename] = {tostring(time:toHours())} else table.insert(tj[curfilename], tostring(time:toHours())) end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  print("user had card, removed from original user")
  dpf.savejson("savedata/throwncards.json", tj)

  message.channel:send(message.author.mentionString .. " has thrown a **" .. fntoname(curfilename) .. "** card in the air! Type this command within " .. timeout .. " seconds to catch it!")
  message.channel:send("`c!catch " .. curfilename .. "`")

  if not client:waitFor(tostring(time:toHours()), timeout * 1000) then
    print("card hasn't been caught!")
    tj = dpf.loadjson("savedata/throwncards.json", {})
    uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)

    uj.inventory[curfilename] = uj.inventory[curfilename] and uj.inventory[curfilename] + 1 or 1
    for x = #tj[curfilename], 1, -1 do
      if tj[curfilename][x] == tostring(time:toHours()) then
        table.remove(tj[curfilename], x)
        break
      end
    end

    if not next(tj[curfilename]) then tj[curfilename] = nil end
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    dpf.savejson("savedata/throwncards.json", tj)
    message.channel:send("The **" .. fntoname(curfilename) .. "** card has fallen back to the ground. " .. message.author.mentionString .. " picked it up and put it back to " .. uj.pronouns["their"] .. " inventory.")
  end
end
return command
  