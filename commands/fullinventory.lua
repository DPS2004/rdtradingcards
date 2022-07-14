local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullinventory")
  local filename = "savedata/" .. message.author.id .. ".json"

  if not (mt[1] == "") then
    filename = usernametojson(mt[1])
  end

  if not filename then
    message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    return
  end

  message:addReaction("✅")
  local uj = dpf.loadjson(filename, defaultjson)
  local numkey = 0
  for k in pairs(uj.inventory) do numkey = numkey + 1 end

  local invtable = {}
  local contentstring = (uj.id == message.author.id and "Your" or "<@" .. uj.id .. ">'s") .. " inventory contains:"
  local titlestring = 'Full Inventory'
  local invstring = ''
  local previnvstring = ''
  for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
  table.sort(invtable)
  for i = 1, numkey do
    invstring = invstring .. invtable[i]
    if #invstring > 4096 then
      message.author:send{
        content = contentstring,
        embed = {
          color = 0x85c5ff,
          title = titlestring,
          description = previnvstring
        },
      }
      invstring = invtable[i]
      contentstring = ''
      titlestring = 'Full Inventory (cont.)'
    end
    previnvstring = invstring
  end
  message.author:send{
    content = contentstring,
    embed = {
      color = 0x85c5ff,
      title = titlestring,
      description = previnvstring
    },
  }
end
return command
