local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
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
  print(pagenumber)
  if pagenumber < 1 then
    pagenumber = 1
  end
  local numkey = 0
  for k,v in pairs(uj.inventory) do
    numkey = numkey + 1
  end
  local maxpn = math.ceil(numkey / 10)
  print("maxpn " .. numkey/10)

  if pagenumber > maxpn then
    if not message.channel.id == privatestuff.specialchannelid then
      pagenumber = maxpn
    end
  end
  print("pagenumber " .. pagenumber)
  if pagenumber >= 100 then
    pagenumber = 100
  end
  local invtable = {}
  local invstring = ''
  for k,v in pairs(uj.inventory) do
    table.insert(invtable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n")
  end
  table.sort(invtable, function(a,b) return string.lower(a)<string.lower(b) end)
  for i=(pagenumber-1)*10+1,(pagenumber)*10 do
    print(i)
    if invtable[i] then
      invstring = invstring .. invtable[i]
    end
  end
  if message.channel.id == privatestuff.specialchannelid then
    if pagenumber == 1 then
      message.channel:send("<@".. message.author.id ..'>, your inventory contains:\n**"I am pensiving so hard rn" - Kin** x1\n**"Rhythm Doctor is already out, We have been played for fools" - definitely_not_HIM** x1\n**"it\'s called a midlife crisis if you\'re in your 30s, right now it\'s just anxiety" - Hexakon** x1\n**"so we are being infected by space crust" - Nocallia** x1\n**"so we could literally suck on em until they\'re goo" - Donte** x1\n**"i think we delayed the game too long and theyre angry" - fizzd** x1\n(page 1 of 2)')
    else
      message.channel:send("<@".. message.author.id ..'>, your inventory contains:\n**"imagine putting in ram sticks when you can just download them" - Hexakon** x1\n**"DON\'T "sfdjhgksfdj" ME, I AM IN PAIN :NotLikeShift:" - Econ** x1\n**"if i die blame firefox" - KubeBow** x1\n"**It\'s like feeding seagulls but the birds are us and the breadcrumbs are small editor previews" - CV35W** x1\n**"what kind of baguette fuckery is this" - TNTz** x1\n**"i just hid loss in rd and i feel great" - giacomo** x1\n(page 2 of 2)')
    end
  else
    message.channel:send("<@".. message.author.id ..">, your inventory contains:\n" .. invstring .. "(page ".. pagenumber .. " of " .. maxpn .. ")")
  end
end
return command
  