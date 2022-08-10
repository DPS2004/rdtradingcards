local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !togglecc")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    
	uj.disablecommunity = not uj.disablecommunity
	if uj.disablecommunity then
	  message.channel:send("You will now only be able to pull cards from Season 1 to Season 8.")
	else
	  message.channel:send("You will now be able to pull all cards.")
	end
	
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  