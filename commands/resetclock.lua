
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
      resetclocks()
    end
    message.channel:send('All user cooldowns have been reset.')
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  