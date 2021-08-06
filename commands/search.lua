local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !search")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!search command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local request = mt[1]
  local curfilename = texttofn(request)

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  local invnum = uj.inventory[curfilename] or 0
  local stornum = uj.storage[curfilename] or 0
  if nopeeking and invnum + stornum == 0 then
    message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
  else
    message.channel:send("Here is how many **" .. fntoname(curfilename) .. "** cards you have:\n**In your inventory:** x".. invnum .."\n**In your storage:** x".. stornum)
  end
end
return command
