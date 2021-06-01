local command = {}
function command.run(message, mt)
  message.channel:send('**Common Pronouns:**\nHe, She, They, It\n\n**Neopronouns:**\nXe, Ze, Sta')
  print(message.author.name .. " did !pronounlist")
end
return command
