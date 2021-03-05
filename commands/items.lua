local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !items")
  print(#mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if mt[1] == "" then
    mt[1] = "1"
  end
  print(mt[1])
  local pagenumber = math.floor(tonumber(mt[1]))
  
  if pagenumber < 1 then
    pagenumber = 1
  end
  local numkey = 0
  
  if not uj.items then
    uj.items = {}
    uj.items["nothing"] = true
    uj.equipped = "nothing"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end
  
  for k,v in pairs(uj.items) do
    numkey = numkey + 1
  end
  local maxpn = math.ceil(numkey / 10)
  print("maxpn " .. numkey/10)

  if pagenumber > maxpn then
    pagenumber = maxpn
  end
  print("pagenumber " .. pagenumber)
  local invtable = {}
  local invstring = ''
  for k,v in pairs(uj.items) do
    if v then
      table.insert(invtable, "**" .. itemdb[k].name .. "**\n")
    end
  end
  table.sort(invtable)
  for i=(pagenumber-1)*10+1,(pagenumber)*10 do
    print(i)
    if invtable[i] then
      invstring = invstring .. invtable[i]
    end
  end
  message.channel:send("You have the following items:\n" .. invstring .. "(page ".. pagenumber .. " of " .. maxpn .. ")\nIn addition to your equippable items, you also have " .. uj.tokens .. " **Tokens**.")
end
return command
  