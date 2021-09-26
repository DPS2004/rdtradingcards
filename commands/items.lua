local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !items")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local pagenumber = 1
  if tonumber(mt[1]) then
    pagenumber = math.floor(mt[1])
  end
  pagenumber = math.max(1, pagenumber)

  local numitems = 0
  if not uj.items then
    uj.items = {}
    uj.items["nothing"] = true
    uj.equipped = "nothing"
  end
  if not uj.consumables then uj.consumables = {} end
  dpf.savejson("savedata/" .. message.author.id .. ".json", uj)
  
  for k in pairs(uj.items) do numitems = numitems + 1 end
  for k in pairs(uj.consumables) do numitems = numitems + 1 end
  local maxpn = math.ceil(numitems / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)

  local invtable = {}
  local invstring = ''

  for k,v in pairs(uj.items) do
    if v then table.insert(invtable, "**" .. itemdb[k].name .. "**" .. (uj.equipped == k and " (equipped)" or "") .. "\n") end
  end
  for k,v in pairs(uj.consumables) do
    table.insert(invtable,"**".. consumabledb[k].name  .. "** x" .. v .. "\n")
  end
  table.sort(invtable)

  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if invtable[i] then invstring = invstring .. invtable[i] end
  end

  if not uj.tokens then uj.tokens = 0 end
  invstring = invstring .. '\nYou also have ' .. uj.tokens .. ' **Token' .. (uj.tokens == 1 and "" or "s") .. '**.'

  message.channel:send{
    content = message.author.mentionString .. ", you have the following items:",
    embed = {
      color = 0x85c5ff,
      title = message.author.name .. "'s Items",
      description = invstring,
      footer = {
        text =  "(Page " .. pagenumber .. " of " .. maxpn .. ")",
        icon_url = message.author.avatarURL
      }
    }
  }
end
return command
