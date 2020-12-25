command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local invstring = ''
  for k,v in pairs(uj.inventory) do
    invstring = invstring .. "**" .. (fntoname(k) or "ERROR!!!!!!!!") .. "** x" .. v .. "\n"
  end
  message.channel:send("Your inventory contains:\n" .. invstring)
end
return command
  