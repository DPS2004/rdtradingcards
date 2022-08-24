local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !langlist")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/lang.json", "")
  
  message.channel:send(lang.langlist_message)
end
return command
