command = {}
function command.run(message, mt)
  print(message.author.name .. " did !storage")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local invstring = ''
  for k,v in pairs(uj.storage) do
    invstring = invstring .. "**" .. (fntoname(k) or "ERROR!!!!!!!!") .. "** x" .. v .. "\n"
  end
  message.channel:send("Your storage contains:\n" .. invstring)
end
return command
  