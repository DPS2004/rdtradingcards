command = {}
function command.run(message, mt,mc)
  if not mc then
    mc = message.channel
  end
  print("checking medals for ".. message.author.name)
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  for i,v in ipairs(medalrequires) do
    if loadstring(v.require)() then
      print("user can have "..v.recieve)
      if not uj.medals[v.revieve] then
        print("user does not have it yet!")
        uj.medals[v.recieve]= true
    else
      print("user cannot have "..v.recieve)
      uj.medals[v.recieve]=false
    end
  end
  dpf.savejson(ujf,uj)
end
return command
  