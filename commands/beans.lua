local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !beans")
  if message.guild.name == "Rhythm Doctor Lounge" then
    message:addReaction(client:getEmoji("340218056934686732"))
  else
    message:addReaction(client:getEmoji("816463414959407115"))
  end
end
return command
  