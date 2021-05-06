local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !items")
  print(#mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if mt[1] == "" then
    mt[1] = "1"
  end
  print(mt[1])
  local pagenumber = 1
  if tonumber(mt[1]) then
    local tnresult = tonumber(mt[1])
    print("tonumber returns not nil, specifically " .. tnresult)
    print(type(tnresult))
    pagenumber = math.floor(tnresult)
    print("math.floor 1 = " .. math.floor(1))
    
  else
    print("tonumber returns nil")
    pagenumber = 1
  end
  
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
      local eqstring = ""
      if uj.equipped == k then
        eqstring = " (equipped)"
      end
      table.insert(invtable, "**" .. itemdb[k].name .. "**" .. eqstring .. "\n")
    end
  end
  table.sort(invtable, function(a,b) return string.lower(a)<string.lower(b) end)
  for i=(pagenumber-1)*10+1,(pagenumber)*10 do
    print(i)
    if invtable[i] then
      invstring = invstring .. invtable[i]
    end
  end
  if not uj.tokens then
    uj.tokens = 0
  end
  local isplural = ""
  if uj.tokens ~= 1 then
    isplural = "s"
  end
  invstring = invstring .. '\nYou also have ' .. uj.tokens .. ' **Token' .. isplural .. '**.'
  -- message.channel:send("<@".. message.author.id ..">, you have the following items:\n" .. invstring .. "(page ".. pagenumber .. " of " .. maxpn .. ")\nIn addition to your equippable items, you also have " .. uj.tokens .. " **Token" .. isplural .. "**.")
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
  