local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if uj.lang == "ko" then
      local pingmessage = {"퐁!", "뿅!", "뿡!", "팡!", "팝!", "삐용!", "삐슝!", "빠슝!", "파닥!"}
	  local cping = math.random(1, #pingmessage)
	  message.channel:send(pingmessage[cping])
  else
      message.channel:send(trf('ping'))
  end
  print(message.author.name .. " did !ping")
end
return command
  