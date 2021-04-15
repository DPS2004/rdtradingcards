local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !skipprompts")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  uj.skipprompts = not uj.skipprompts
  if uj.skipprompts then
    message.channel:send("Reaction prompts will now be skipped!")
  else
    message.channel:send("Reaction prompts will no longer be skipped!")
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  