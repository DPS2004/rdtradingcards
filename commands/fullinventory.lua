local command = {}
function command.run(message, mt)
  message:addReaction("✅")
  print(message.author.name .. " did !fullinventory")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local numkey = 0
  for k,v in pairs(uj.inventory) do
    numkey = numkey + 1
  end
  local invtable = {}
  local invstring = ''
  local previnvstring = ''
  for k,v in pairs(uj.inventory) do
    table.insert(invtable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n")
  end
  table.sort(invtable, function(a,b) return string.lower(a)<string.lower(b) end)
  message.author:send("Your inventory contains:")
  for i = 1, numkey do
    invstring = invstring .. invtable[i]
    if #invstring >= 2000 then
      message.author:send(previnvstring)
      invstring = ''
    end
    previnvstring = invstring
  end
  message.author:send(invstring)
end
return command
  