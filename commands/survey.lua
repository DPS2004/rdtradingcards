local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)

    message.channel:send("There is currently no ongoing survey.")

end
return command
  