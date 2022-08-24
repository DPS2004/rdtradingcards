local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !skipprompts")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/skipprompts.json","")
  uj.skipprompts = not uj.skipprompts
  if uj.skipprompts then
    message.channel:send(lang.enabled_message)
  else
    message.channel:send(lang.disabled_message)
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  