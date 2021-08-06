local command = {}
function command.run(message, mt)
  message.channel:send("There is currently no ongoing survey.")
end
return command
