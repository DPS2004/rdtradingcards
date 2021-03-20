local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    local uj = dpf.loadjson("savedata/" .. mt[1] .. ".json",defaultjson)
    if not uj.tokens then
      uj.tokens = 1
    else
      uj.tokens = uj.tokens + 1
    end
    dpf.savejson("savedata/" .. mt[1] .. ".json",uj)
        
    message.channel:send("token has been given")
  else
    message.channel:send("haha no, nice try")
  end
end
return command