local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !pronoun")
  
  if not uj.pronoun then
    uj.pronoun = {}
    insert code about changing pronoun here
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end
  
  if mt[1] == "they" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as they/them.")
  elseif mt[1] == "he" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as he/him.")
  elseif mt[1] == "she" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as she/her.")
  elseif mt[1] == "it" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as it/its.")
  elseif mt[1] == "xe" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as xe/xem.")
  elseif mt[1] == "sta" then
    insert code about changing pronoun here
    message.channel:send("You will now be refered to as sta/star.")
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
