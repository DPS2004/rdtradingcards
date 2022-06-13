local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !getfile")
  local cmember = message.guild:getMember(message.author)
  if not cmember:hasRole(privatestuff.modroleid) then
    message.channel:send("haha no, nice try")
    return
  end

  message.channel:send({
    file = table.concat(mt, "/")
  })
end
return command
