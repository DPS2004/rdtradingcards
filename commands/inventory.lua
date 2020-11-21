command = {}
function command.run(message, mt)
  print(message.member.name .. " did !inventory")
  local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
  local invstring = ''
  for k,v in pairs(uj.inventory) do
    invstring = invstring .. "**" .. (fntoname(k) or "ERROR!!!!!!!!") .. "** x" .. v .. "\n"
  end
  message.channel:send("Your inventory contains:\n" .. invstring)
end
return command
  