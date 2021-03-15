local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)

    message.channel:send("There is currently an ongoing survey, and participating in it will reward you with a **Token** once responses are closed! The survey will close on the 20th. The survey can be found here: https://forms.gle/ZLNnJ4yVGwta5Nea8")

end
return command
  