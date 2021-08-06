local command = {}
function command.run(message, mt)
  print("loading the resetclock command!")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    resetclocks()
    message.channel:send('All user cooldowns have been reset.')
  else
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  