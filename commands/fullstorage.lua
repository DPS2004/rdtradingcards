local command = {}
function command.run(message, mt)
  message:addReaction("✅")
  print(message.author.name .. " did !fullstorage")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local numkey = 0
  for k,v in pairs(uj.storage) do
    numkey = numkey + 1
  end
  local storetable = {}
  local storestring = 'Your storage contains:\n'
  local prevstorestring = ''
  for k,v in pairs(uj.storage) do
    table.insert(storetable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n")
  end
  table.sort(storetable, function(a,b) return string.lower(a)<string.lower(b) end)
  for i = 1, numkey do
    storestring = storestring .. storetable[i]
    if #storestring > 2000 then
      message.author:send(prevstorestring)
      storestring = storetable[i]
    end
    prevstorestring = storestring
  end
  message.author:send(storestring)
end
return command
  