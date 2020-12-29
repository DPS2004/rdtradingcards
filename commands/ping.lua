local command = {}
function command.run(message, mt)
  message.channel:send('pong')
  print(message.author.name .. " did !ping")
end
return command
  