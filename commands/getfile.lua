local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    message.channel:send({
          content = '',
          
          file =  mt[1]
        })
  else
    message.channel:send("haha no, nice try")
  end
end
return command
  