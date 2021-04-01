
local command = {}
function command.run(message, mt)
  print("c!runlua!!!!!")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    message.channel:send('Ok, running!')
    local request = mt[1]
    local rfunc = loadstring(request)
    rfunc()
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  