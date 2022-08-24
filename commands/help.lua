
local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/help.json", "")
  print(message.author.name .. " did !help")
  message.channel:send(lang.help_message)
end
return command
  