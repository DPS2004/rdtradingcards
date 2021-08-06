local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !pronounlist")
  message.channel:send('**Common Pronouns:**\nHe, She, They, It\n\n**Neopronouns:**\nXe, Ze, Sta, Vee\n\n*If your pronouns are not included, please use c!pronounform')
end
return command
