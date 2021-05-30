local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !pronoun")
  
  if not uj.pronouns then
    uj.pronouns = {}
    uj.pronouns["subject"] = "they"
    uj.pronouns["object"] = "them"
    uj.pronouns["possesdet"] = "their"
    uj.pronouns["possespro"] = "theirs"
    uj.pronouns["reflex"] = "theirself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end
  
  if mt[1] == "they" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "they"
    uj.pronouns["object"] = "them"
    uj.pronouns["possesdet"] = "their"
    uj.pronouns["possespro"] = "theirs"
    uj.pronouns["reflex"] = "theirself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as they/them.")
  elseif mt[1] == "he" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "he"
    uj.pronouns["object"] = "him"
    uj.pronouns["possesdet"] = "his"
    uj.pronouns["possespro"] = "his"
    uj.pronouns["reflex"] = "himself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as he/him.")
  elseif mt[1] == "she" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "she"
    uj.pronouns["object"] = "her"
    uj.pronouns["possesdet"] = "her"
    uj.pronouns["possespro"] = "hers"
    uj.pronouns["reflex"] = "herself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as she/her.")
  elseif mt[1] == "it" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "it"
    uj.pronouns["object"] = "its"
    uj.pronouns["possesdet"] = "its"
    uj.pronouns["possespro"] = "its"
    uj.pronouns["reflex"] = "itself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as it/its.")
  elseif mt[1] == "xe" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "xe"
    uj.pronouns["object"] = "xem"
    uj.pronouns["possesdet"] = "xir"
    uj.pronouns["possespro"] = "xirs"
    uj.pronouns["reflex"] = "xirself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as xe/xem.")
  elseif mt[1] == "sta" then
    uj.pronouns = {}
    uj.pronouns["subject"] = "sta"
    uj.pronouns["object"] = "star"
    uj.pronouns["possesdet"] = "star"
    uj.pronouns["possespro"] = "stars"
    uj.pronouns["reflex"] = "starself"
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    message.channel:send("You will now be refered to as sta/star.")
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
