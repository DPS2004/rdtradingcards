local command = {}
function command.run(message, mt)
  print("bruh")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    
    wj.specialuser = mt[1]
    
    --old states, do not use!: 
    
    --prehole: pre-s5
    --tinyhole: s5 intro
    --smallhole: ditto
    --mediumhole: ditto
    --largehole: ditto
    --largerhole: ditto
    --largesthole: waiting for ladder
    --labopen: lab is initially open
    --terminalopen: terminal has been logged in to
    
    dpf.savejson("savedata/worldsave.json", wj)
    message.channel:send("world updated")
  else
    message.channel:send("despite your efforts, the world remains the same")
  end
end
return command
  