local command = {}
function command.run(message, mt)
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)

  if (not uj.chickstats) then
      uj.chickstats = {
          bodycolor = { 255, 250, 0 },
          eyecolor = { 49, 49, 49 },
          scleracolor = { 248, 248, 248 },
          beakcolor = { 255, 128, 3 },
          footcolor =  { 255, 128, 3 },
          headwear = "nothing",
          eyewear = "nothing",
          neckwear = "nothing"
      }
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end

  local chickimg = getchickimage(message.author.id)
  chickimg:write_to_file("vips_out/chick.png")

  message.channel:send{
    content = "Chick",
    file = "vips_out/chick.png"
  }
  print(message.author.name .. " did !chick")
end
return command