local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !pronoun")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  
  if not uj.pronouns then
    uj.pronouns = {}
    uj.pronouns["they"] = "they"
    uj.pronouns["them"] = "them"
    uj.pronouns["their"] = "their"
    uj.pronouns["theirs"] = "theirs"
    uj.pronouns["theirself"] = "themself"
  end
  
  if mt[1] == "they" then
    uj.pronouns["they"] = "they"
    uj.pronouns["them"] = "them"
    uj.pronouns["their"] = "their"
    uj.pronouns["theirs"] = "theirs"
    uj.pronouns["theirself"] = "themself"
    message.channel:send("You will now be referred to with they/them.")
  elseif mt[1] == "he" then
    uj.pronouns["they"] = "he"
    uj.pronouns["them"] = "him"
    uj.pronouns["their"] = "his"
    uj.pronouns["theirs"] = "his"
    uj.pronouns["theirself"] = "himself"
    message.channel:send("You will now be referred to with he/him.")
  elseif mt[1] == "she" then
    uj.pronouns["they"] = "she"
    uj.pronouns["them"] = "her"
    uj.pronouns["their"] = "her"
    uj.pronouns["theirs"] = "hers"
    uj.pronouns["theirself"] = "herself"
    message.channel:send("You will now be referred to with she/her.")
  elseif mt[1] == "it" then
    uj.pronouns["they"] = "it"
    uj.pronouns["them"] = "its"
    uj.pronouns["their"] = "its"
    uj.pronouns["theirs"] = "its"
    uj.pronouns["theirself"] = "itself"
    message.channel:send("You will now be referred to with it/its.")
  elseif mt[1] == "xe" then
    uj.pronouns["they"] = "xe"
    uj.pronouns["them"] = "xem"
    uj.pronouns["their"] = "xir"
    uj.pronouns["theirs"] = "xirs"
    uj.pronouns["theirself"] = "xirself"
    message.channel:send("You will now be referred to with xe/xem.")
  elseif mt[1] == "sta" then
    uj.pronouns["they"] = "sta"
    uj.pronouns["them"] = "star"
    uj.pronouns["their"] = "star"
    uj.pronouns["theirs"] = "stars"
    uj.pronouns["theirself"] = "starself"
    message.channel:send("You will now be referred to with sta/star.")
  elseif mt[1] == "ze" then
    uj.pronouns["they"] = "ze"
    uj.pronouns["them"] = "zir"
    uj.pronouns["their"] = "zir"
    uj.pronouns["theirs"] = "zirs"
    uj.pronouns["theirself"] = "zirself"
    message.channel:send("You will now be referred to with ze/zir.")
  elseif mt[1] == "vee" then
    uj.pronouns["they"] = "vee"
    uj.pronouns["them"] = "veem"
    uj.pronouns["their"] = "veem"
    uj.pronouns["theirs"] = "veem's"
    uj.pronouns["theirself"] = "veeself"
    message.channel:send("You will now be referred to with vee/veem.")
  elseif mt[1] == "" then
    message.channel:send("Please enter your pronouns.")
  else
    message.channel:send("Sorry, but I could not find " ..mt[1].. " pronouns. See if you mispelled, or if your pronouns are in c!pronounlist. If they are not there, you may use c!pronounform to suggest adding them.")
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json", uj)
end
return command
