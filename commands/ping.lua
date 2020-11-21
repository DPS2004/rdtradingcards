command = {}
function command.run(message, mt)
  message.channel:send('pong')
  print(message.member.name .. " did !ping")
end
return command
  