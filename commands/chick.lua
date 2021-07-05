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
          neckwear = "nothing",
          shoes = "nothing",
          others = {}
      }
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end

  if mt[1] == "" then
    mt[1] = "look"
    mt[2] = uj.id
  end
  if mt[1] == "add" then
    -- add accessory code
  elseif mt[1] == "remove" then
    -- remove accessory code
  elseif mt[1] == "inventory" or mt[1] == "inv" then
    -- accessory inventory code
  elseif mt[1] == "look" then
    local chickimg = getchickimage(mt[2])
    chickimg:write_to_file("vips_out/chick.png")

    message.channel:send{
      content = "Chick",
      file = "vips_out/chick.png"
    }
    -- add code for checking other people's chicks
  end

  print(message.author.name .. " did !chick")
end
return command