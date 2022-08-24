local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !pronoun")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/pronoun.json", "")
  
  if not uj.pronouns then
    uj.pronouns = {}
	uj.pronouns["selection"] = "they"
    uj.pronouns["they"] = lang.they_they
    uj.pronouns["them"] = lang.they_them
    uj.pronouns["their"] = lang.they_their
    uj.pronouns["theirs"] = lang.they_theirs
    uj.pronouns["theirself"] = lang.they_theirself
  end
  
  if mt[1] == "they" then
    uj.pronouns["selection"] = "they"
    uj.pronouns["they"] = lang.they_they
    uj.pronouns["them"] = lang.they_them
    uj.pronouns["their"] = lang.they_their
    uj.pronouns["theirs"] = lang.they_theirs
    uj.pronouns["theirself"] = lang.they_theirself
    message.channel:send(lang.they_changed)
  elseif mt[1] == "he" then
    uj.pronouns["selection"] = "he"
    uj.pronouns["they"] = lang.he_they
    uj.pronouns["them"] = lang.he_them
    uj.pronouns["their"] = lang.he_their
    uj.pronouns["theirs"] = lang.he_theirs
    uj.pronouns["theirself"] = lang.he_theirself
    message.channel:send(lang.he_changed)
  elseif mt[1] == "she" then
    uj.pronouns["selection"] = "she"
    uj.pronouns["they"] = lang.she_they
    uj.pronouns["them"] = lang.she_them
    uj.pronouns["their"] = lang.she_their
    uj.pronouns["theirs"] = lang.she_theirs
    uj.pronouns["theirself"] = lang.she_theirself
    message.channel:send(lang.she_changed)
  elseif mt[1] == "it" then
    uj.pronouns["selection"] = "it"
    uj.pronouns["they"] = lang.it_they
    uj.pronouns["them"] = lang.it_them
    uj.pronouns["their"] = lang.it_their
    uj.pronouns["theirs"] = lang.it_theirs
    uj.pronouns["theirself"] = lang.it_theirself
    message.channel:send(lang.it_changed)
  elseif mt[1] == "xe" then
    uj.pronouns["selection"] = "xe"
    uj.pronouns["they"] = lang.xe_they
    uj.pronouns["them"] = lang.xe_them
    uj.pronouns["their"] = lang.xe_their
    uj.pronouns["theirs"] = lang.xe_theirs
    uj.pronouns["theirself"] = lang.xe_theirself
    message.channel:send(lang.xe_changed)
  elseif mt[1] == "sta" then
    uj.pronouns["selection"] = "sta"
    uj.pronouns["they"] = lang.sta_they
    uj.pronouns["them"] = lang.sta_them
    uj.pronouns["their"] = lang.sta_their
    uj.pronouns["theirs"] = lang.sta_theirs
    uj.pronouns["theirself"] = lang.sta_theirself
    message.channel:send(lang.sta_changed)
  elseif mt[1] == "ze" then
    uj.pronouns["selection"] = "ze"
    uj.pronouns["they"] = lang.ze_they
    uj.pronouns["them"] = lang.ze_them
    uj.pronouns["their"] = lang.ze_their
    uj.pronouns["theirs"] = lang.ze_theirs
    uj.pronouns["theirself"] = lang.ze_theirself
    message.channel:send(lang.ze_changed)
  elseif mt[1] == "vee" then
    uj.pronouns["selection"] = "vee"
    uj.pronouns["they"] = lang.vee_they
    uj.pronouns["them"] = lang.vee_them
    uj.pronouns["their"] = lang.vee_their
    uj.pronouns["theirs"] = lang.vee_theirs
    uj.pronouns["theirself"] = lang.vee_theirself
    message.channel:send(lang.vee_changed)
  elseif mt[1] == "" then
    message.channel:send(lang.no_value)
  else
    message.channel:send(lang.no_database_1 ..mt[1].. lang.no_database_2)
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json", uj)
end
return command
