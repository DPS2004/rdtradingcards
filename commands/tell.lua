local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    if message.attachment then
      local res, body = http.request("GET", message.attachment.url)
      client:getChannel(mt[1]):send{
        content = table.concat(mt, "/", 2),
        file = {message.attachment.filename, body}
      }
    else
      client:getChannel(mt[1]):send(table.concat(mt, "/", 2))
    end
  else
    message.channel:send("haha no, nice try")
  end
end
return command
  