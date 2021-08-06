local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullinventory")
  message:addReaction("✅")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local numkey = 0
  for k in pairs(uj.inventory) do numkey = numkey + 1 end

  local invtable = {}
  local contentstring = 'Your inventory contains:'
  local titlestring = 'Full Inventory'
  local invstring = ''
  local previnvstring = ''
  for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (fntoname(k) or k) .. "** x" .. v .. "\n") end
  table.sort(invtable)
  for i = 1, numkey do
    invstring = invstring .. invtable[i]
    if #invstring > 2048 then
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
