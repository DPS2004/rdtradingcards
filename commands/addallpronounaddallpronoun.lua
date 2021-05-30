local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !addallpronouns")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
      cuj = dpf.loadjson("savedata/"..v,defaultjson)
      if not cuj.pronouns then
        print("adding pronouns to person")
        cuj.pronouns = {}
        cuj.pronouns["subject"] = "they"
        cuj.pronouns["object"] = "them"
        cuj.pronouns["possesdet"] = "their"
        cuj.pronouns["possespro"] = "theirs"
        cuj.pronouns["reflex"] = "theirself"
        dpf.savejson("savedata/"..v,cuj)
      end
    end
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
