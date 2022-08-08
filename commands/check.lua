local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !check")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!check command expects 1 argument. Please see c!help for more details.")
    return
  end
    
  if (mt[1] == "card") then
    uj.checkcard = not uj.checkcard
    if uj.checkcard then
      message.channel:send("Getting a card that you have none of in your storage will no longer be notified!")
    else
      message.channel:send("Getting a card that you have none of in your storage will now be notified!")
    end
  elseif (mt[1] == "token") then
    uj.checktoken = not uj.checktoken
    if uj.checktoken then
      message.channel:send("How many tokens you have after praying or giving will no longer be notified!")
    else
      message.channel:send("How many tokens you have after praying or giving will now be notified!")
    end
  else
    if mt[1] == "" then
      message.channel:send("Sorry, but the c!check command expects 1 argument. Please see c!help for more details.")
      return
    else
      message.channel:send("Sorry, but I cannot find " .. mt[1] .. ".You can either set to check **cards** or **tokens**.")
    end
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  