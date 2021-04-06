
local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !addallnicknames")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
        cuj = dpf.loadjson("savedata/"..v,defaultjson)
        if not cuj.names then
            if cuj.name then
                print("adding nickname to " .. cuj.name)
                cuj.names = {}
                cuj.names[cuj.name] = true
                cuj.name = nil
                dpf.savejson("savedata/"..v,cuj)
            end
        end
    end
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  