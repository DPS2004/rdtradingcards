local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !move")

  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if not mt[1] then
    mt[1] = "pyrowmid"
  end
  local locations = {"Pyrowmid", "Abandoned Lab", "Windy Mountains", "Quaint Shop", "Dark Hallway", "Shady Casino"}
  local success = false
  local request = string.lower(mt[1])
  local newroom = 0
  
  --0: pyrowmid
  --1: lab
  --2: mountain
  --3: shop
  --4: hallway
  --5: casino
  
  if request == "pyrowmid" or request == "the pyrowmid" then
    success = true
    newroom = 0
  elseif request == "lab" or request == "abandonedlab" or request == "the abandoned lab" or request == "abandoned lab" then
    success = true
    newroom = 1
  elseif wj.ws >= 702 and (request == "mountains" or request == "mountain" or request == "windymountains" or request == "the windy mountains" or request == "windy mountains") then
    success = true
    newroom = 2
  elseif wj.ws >= 702 and (request == "shop" or request == "quaintshop" or request == "quaint shop" or request == "the quaint shop") then
    success = true
    newroom = 3
  elseif wj.ws >= 804 and (request == "hallway" or request == "darkhallway" or request == "the dark hallway" or request == "dark hallway") then
    success = true
    newroom = 4
  elseif wj.ws >= 805 and (request == "casino" or request == "shadycasino" or request == "the shady casino" or request == "shady casino") then
    success = true
    newroom = 5
  end
  
  
  if success then
    print("newroom is ".. newroom)
    if newroom == uj.room then
      message.channel:send("You are already in the **" .. locations[newroom+1] .. "**!")
      return
	else
      uj.room = newroom
      message.channel:send("Your location is now the **" .. locations[newroom+1] .. "**.")
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
      return uj
	end
  else
    message.channel:send("Sorry, but I could not find " .. mt[1] .. ". Make sure that you spelled it right!")
  end

end
return command
  