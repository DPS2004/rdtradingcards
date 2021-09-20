local command = {}
function command.run(message, mt)
  message.channel:send(trf('ping'))
  print(message.author.name .. " did !ping")
end
return command
  