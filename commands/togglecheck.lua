local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !togglecheck")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/togglecheck.json","")
  if #mt ~= 1 then
    message.channel:send(lang.no_arguments)
    return
  end
    
  if (mt[1] == "card" or mt[1] == "cards" or mt[1] == "카드") then
    uj.togglecheckcard = not uj.togglecheckcard
    if uj.togglecheckcard then
      message.channel:send(lang.card_disabled_message)
    else
      message.channel:send(lang.card_enabled_message)
    end
  elseif (mt[1] == "token" or mt[1] == "tokens" or mt[1] == "토큰") then
    uj.togglechecktoken = not uj.togglechecktoken
    if uj.togglechecktoken then
      message.channel:send(lang.token_disabled_message)
    else
      message.channel:send(lang.token_enabled_message)
    end
  else
    if mt[1] == "" then
      message.channel:send(lang.no_arguments)
      return
    else
      message.channel:send(lang.no_database_1 .. mt[1] .. lang.no_database_2)
    end
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  