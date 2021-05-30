local command = {}
function command.run(message, mt)
  message.channel:send('Current Pronouns: He, She, They, It, Xe, Sta')
  print(message.author.name .. " did !pronounlist")
end
return command
