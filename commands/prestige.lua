local command = {}
function command.run(message)

  print(message.author.name .. " did !prestige")

  if not message.guild then
    message.channel:send("guild prestige error") -- You could probably add some flair to these error messages lol
    return
  end
  
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  
  if not uj.medals["cardmaestro"] then
    message.channel:send("not all cards obtained error")
    return
  end

  ynbuttons(message, message.author.mentionString .. ", Are you sure you want to prestige? **This will erase one of every non-prestige card in your storage and reset your medal progress.**", "prestige", {})
end
return command