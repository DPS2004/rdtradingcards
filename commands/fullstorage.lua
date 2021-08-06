local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullstorage")
  message:addReaction("✅")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local numkey = 0
  for k in pairs(uj.storage) do numkey = numkey + 1 end
  
  local storetable = {}
  local contentstring = 'Your storage contains:'
  local titlestring = 'Full Storage'
  local storestring = ''
  local prevstorestring = ''
  for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n") end
  table.sort(storetable)
  for i = 1, numkey do
    storestring = storestring .. storetable[i]
    if #storestring > 2048 then
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
