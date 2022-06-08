local command = {}
function command.run(message, mt,mc)
  if not mc then
    mc = message.channel
  end
  print("checking medals for ".. message.author.name)
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  for i,v in ipairs(medalrequires) do
    --print(inspect(v.require))
    local rfunc = loadstring(v.require)()
    if rfunc(uj) then
      print("user can have "..v.receive)
      if not uj.medals[v.receive] then
        print("user does not have it yet!")
        uj.medals[v.receive] = true
        mc:send{embed = {
          color = 0x85c5ff,
          title = "Congratulations!",
          description = 'After collecting and storing some cards, '.. message.author.mentionString ..' got the **"'.. medaldb[v.receive].name ..'"** medal!',
          image = {
            url = medaldb[v.receive].embed
          }
        }}
      end
    else
      print("user cannot have "..v.receive)
      uj.medals[v.receive]=false
    end
  end
  dpf.savejson(ujf,uj)
end
return command
  