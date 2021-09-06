local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    local filename, rawfile
    if message.attachment then
      filename = message.attachment.filename
      local res, body = http.request("GET", message.attachment.url)
      rawfile = body
    end
    client:getChannel(mt[1]):send{
      content = table.concat(mt, "/", 2),
      file = {filename, rawfile}
    }
  else
    message.channel:send("haha no, nice try")
  end
end
return command
  