local command = {}
function command.run(message, mt)
  message:addReaction(message.guild.emojis:find(function(e) return e.name == 'beans' end))
  print(message.author.name .. " did !beans")
end
return command
  