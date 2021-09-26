local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local pagenumber = 1
  if tonumber(mt[1]) then
    pagenumber = math.floor(mt[1])
  end
  pagenumber = math.max(1, pagenumber)

  local numcards = 0
  for k in pairs(uj.inventory) do numcards = numcards + 1 end
  local maxpn = math.ceil(numcards / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)

  local invtable = {}
  local invstring = ''
  print(uj.inventory)
  for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v) end
  table.sort(invtable)

  invstring = table.concat(invtable, "\n", (pagenumber - 1) * 10 + 1, pagenumber * 10)

  message.channel:send{
    content = message.author.mentionString .. ", your inventory contains:",
    embed = {
      color = 0x85c5ff,
      title = message.author.name .. "'s Inventory",
      description = invstring,
      footer = {
        text =  "(Page " .. pagenumber .. " of " .. maxpn .. ")",
        icon_url = message.author.avatarURL
      }
    }
  }
end
return command
