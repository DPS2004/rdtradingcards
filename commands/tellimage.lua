local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    message.guild:getChannel(mt[1]):send({
          content = '',
          
          file = "assets/" .. mt[2]
        })
  else
    message.channel:send("haha no, nice try")
  end
end
return command
  