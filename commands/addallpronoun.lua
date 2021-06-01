local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !addallpronoun")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
      cuj = dpf.loadjson("savedata/"..v,defaultjson)
      if not cuj.pronouns then
        print("adding pronouns to person")
        cuj.pronouns = {}
        cuj.pronouns["they"] = "they"
        cuj.pronouns["them"] = "them"
        cuj.pronouns["their"] = "their"
        cuj.pronouns["theirs"] = "theirs"
        cuj.pronouns["theirself"] = "theirself"
        dpf.savejson("savedata/"..v,cuj)
      end
    end
    message.channel:send('Pronouns Added!')
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
