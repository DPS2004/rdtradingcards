local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !pronoun")
  
  if not uj.pronouns then
    uj.pronouns = {}
    uj.pronouns["they"] = "they"
    uj.pronouns["them"] = "them"
    uj.pronouns["their"] = "their"
    uj.pronouns["theirs"] = "theirs"
    uj.pronouns["theirself"] = "themself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end
  
  if mt[1] == "they" then
    uj.pronouns = {}
    uj.pronouns["they"] = "they"
    uj.pronouns["them"] = "them"
    uj.pronouns["their"] = "their"
    uj.pronouns["theirs"] = "theirs"
    uj.pronouns["theirself"] = "theirself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as they/them.")
  elseif mt[1] == "he" then
    uj.pronouns = {}
    uj.pronouns["they"] = "he"
    uj.pronouns["them"] = "him"
    uj.pronouns["their"] = "his"
    uj.pronouns["theirs"] = "his"
    uj.pronouns["theirself"] = "himself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as he/him.")
  elseif mt[1] == "she" then
    uj.pronouns = {}
    uj.pronouns["they"] = "she"
    uj.pronouns["them"] = "her"
    uj.pronouns["their"] = "her"
    uj.pronouns["theirs"] = "hers"
    uj.pronouns["theirself"] = "herself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as she/her.")
  elseif mt[1] == "it" then
    uj.pronouns = {}
    uj.pronouns["they"] = "it"
    uj.pronouns["them"] = "its"
    uj.pronouns["their"] = "its"
    uj.pronouns["theirs"] = "its"
    uj.pronouns["theirself"] = "itself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as it/its.")
  elseif mt[1] == "xe" then
    uj.pronouns = {}
    uj.pronouns["they"] = "xe"
    uj.pronouns["them"] = "xem"
    uj.pronouns["their"] = "xir"
    uj.pronouns["theirs"] = "xirs"
    uj.pronouns["theirself"] = "xirself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as xe/xem.")
  elseif mt[1] == "sta" then
    uj.pronouns = {}
    uj.pronouns["they"] = "sta"
    uj.pronouns["them"] = "star"
    uj.pronouns["their"] = "star"
    uj.pronouns["theirs"] = "stars"
    uj.pronouns["theirself"] = "starself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as sta/star.")
  else
    message.channel:send("Sorry, but I could not find "..mt[1].." pronouns. See if you mispelled, or if you would like these pronouns to be added, please message @Nocallia#0695 or fill out the google form.")
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
