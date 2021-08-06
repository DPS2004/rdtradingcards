local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !shred")
  if not (#mt == 1 or #mt == 2) then
    message.channel:send("Sorry, but the c!shred command expects 1 or 2 arguments. Please see c!help for more details.")
    return
  end

  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
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
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory.")
    end
    return
  end

  local numcards = 1
  if tonumber(mt[2]) then
    if tonumber(mt[2]) > 1 then numcards = math.floor(mt[2]) end
  end
  if mt[2] == "all" then
    numcards = uj.inventory[curfilename]
  end

  if uj.inventory[curfilename] >= numcards then
    ynbuttons(message, "<@" .. uj.id .. ">, do you want to shred your " .. numcards .. " **" .. fntoname(curfilename) .. "** card" .. (numcards == 1 and "" or "s") .. "? **This cannot be undone.** Click the Yes button to confirm and No to deny.", "shred", {curfilename = curfilename,numcards = numcards})
  else
    message.channel:send("Sorry, but you do not have enough **" .. fntoname(curfilename) .. "** cards in your inventory.")
  end
end
return command
  