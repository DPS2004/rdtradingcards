local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !move")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if not mt[1] then
    mt[1] = "pyrowmid"
  end
  local locations = {"Pyrowmid", "Abandoned Lab", "Dark Hallway", "Shady Casino"}
  local success = false
  local request = string.lower(mt[1])
  local newroom = 0
  
  --0: pyrowmid
  --1: lab
  --2: hallway
  --3: casino
  
  if request == "pyrowmid" or request == "the pyrowmid" then
    success = true
    newroom = 0
  elseif request == "lab" or request == "abandonedlab" or request == "the abandoned lab" or request == "abandoned lab" then
    success = true
    newroom = 1
  elseif wj.ws >= 3 and (request == "hallway" or request == "darkhallway" or request == "the dark hallway" or request == "dark hallway") then
    success = true
    newroom = 2
  elseif wj.ws >= 4 and (request == "casino" or request == "shadycasino" or request == "the shady casino" or request == "shady casino") then
    success = true
    newroom = 3
  end
  
  if success then
    print("newroom is ".. newroom)
    uj.room = newroom
    message.channel:send("Your location is now the **" .. locations[newroom+1] .. "**.")
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  else
    message.channel:send("Sorry, but I could not find " .. mt[1] .. ". Make sure that you spelled it right!")
  end

end
return command
  