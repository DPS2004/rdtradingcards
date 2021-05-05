local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !beans")
  message:addReaction(client:getEmoji("340218056934686732"))
end
return command
  