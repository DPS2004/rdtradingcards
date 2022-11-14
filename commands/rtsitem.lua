local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !rtsitem")
  local cmember = message.guild:getMember(message.author)
  if not cmember:hasRole(privatestuff.modroleid) then
    message.channel:send("haha no, nice try")
    return
  end

  

  local uj2f = usernametojson(mt[1])
  if not uj2f then
    message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)
  
  local item = 'granolabar'
  local itemtype = 'cons'
  
  if mt[3] == 'granolabar' then
	item = 'granolabar'
	itemtype = 'cons'
  end --add other items as needed

  local numitems = 1
  if tonumber(mt[3]) then
    if tonumber(mt[3]) > 1 then numitems = math.floor(mt[3]) end
  end

  if itemtype == 'cons' then
	if not uj2.consumables[item] then
	  uj2.consumables[item] = numitems
	else
	  uj2.consumables[item] = uj2.consumables[item] + numitems
	end
  else --non-consumable item
    uj2.items[item] = true
  end
  --add essence as well
  
  if not uj2.consumables['essenceof'..item] then
	uj2.consumables['essenceof'..item] = numitems
  else
	uj2.consumables['essenceof'..item] = uj2.consumables['essenceof'..item] + numitems
  end
  
  
  dpf.savejson(uj2f,uj2)
  
  
  
  print("saved user2 json with new stuff")

  message.channel:send {
    content = 'You have given ' .. numitems .. ' rewards to <@' .. uj2.id .. '> .'
  }
end
return command
