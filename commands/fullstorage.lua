local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullstorage")
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
  for k in pairs(uj.storage) do numkey = numkey + 1 end
  
  local storetable = {}
  local contentstring = (uj.id == message.author.id and "Your" or "<@" .. uj.id .. ">'s") .. " storage contains:"
  local titlestring = 'Full Storage'
  local storestring = ''
  local prevstorestring = ''
  for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
  table.sort(storetable)
  for i = 1, numkey do
    storestring = storestring .. storetable[i]
    if #storestring > 4096 then
      message.author:send{
        content = contentstring,
        embed = {
          color = 0x85c5ff,
          title = titlestring,
          description = prevstorestring
        },
      }
      storestring = storetable[i]
      contentstring = ''
      titlestring = 'Full Storage (cont.)'
    end
    prevstorestring = storestring
  end
  message.author:send{
    content = contentstring,
    embed = {
      color = 0x85c5ff,
      title = titlestring,
      description = storestring
    },
  }
end
return command
