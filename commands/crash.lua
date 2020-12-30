
local command = {}
function command.run(message, mt)
  print("lmao someone did c!crash")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
      resetclocks()
    end
    message.channel:send('Time to crash! Here I go! Hopefully this should say something about concatenating a nil value!')
    print("string string stringity string" .. nilvalue)
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  