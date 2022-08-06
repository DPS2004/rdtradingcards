local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !checkcard")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  uj.checkcard = not uj.checkcard
  if uj.checkcard then
    message.channel:send("You will no longer be notificated if you pull or box a card that you have none of in your storage!")
  else
    message.channel:send("You will now be notificated if you pull or box a card that you have none of in your storage!")
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  