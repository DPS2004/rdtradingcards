local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !pronounlist")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/pronoun.json", "")
  
  message.channel:send(lang.pronounlist_message)
end
return command
