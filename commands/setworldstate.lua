local command = {}
function command.run(message, mt)
  print("bruh")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    wj.worldstate = mt[1] -- valid states: prehole, tinyhole, smallhole, mediumhole, largehole, largerhole, largesthole, labopen
    dpf.savejson("savedata/worldsave.json", wj)
    message.channel:send("world updated")
  else
    message.channel:send("despite your efforts, the world remains the same")
  end
end
return command
  