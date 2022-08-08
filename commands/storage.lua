local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !storage")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  
  local enableShortNames = false

  local pagenumber = 1
  
  args = {}
  for substring in mt[1]:gmatch("%S+") do
    table.insert(args, substring)
  end
  
  for index, value in ipairs(args) do
    if tonumber(value) then
      pagenumber = math.floor(tonumber(value))
    end
    if value == "-s" then
      enableShortNames = true
    end
  end
  
  pagenumber = math.max(1, pagenumber)

  local numcards = 0
  for k in pairs(uj.storage) do numcards = numcards + 1 end
  local maxpn = math.ceil(numcards / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)

  local storagetable = {}
  local storagestring = ''
  if enableShortNames == true then
    for k,v in pairs(uj.storage) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
  else
    for k,v in pairs(uj.storage) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
  end
  table.sort(storagetable)

  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if storagetable[i] then storagestring = storagestring .. storagetable[i] end
  end

  message.channel:send{
    content = message.author.mentionString .. ", your storage contains:",
    embed = {
      color = 0x85c5ff,
      title = message.author.name .. "'s Storage",
      description = storagestring,
      footer = {
        text =  "(Page " .. pagenumber .. " of " .. maxpn .. ")",
        icon_url = message.author.avatarURL
      }
    }
  }
end
return command
