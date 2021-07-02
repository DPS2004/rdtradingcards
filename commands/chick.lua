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
          footcolor =  { 255, 128, 3 }
      }
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end

  --getting all the body parts
  local chickbody = vips.Image.new_from_file("chick/chick_body.png")
  local chickeyes = vips.Image.new_from_file("chick/chick_eyes.png")
  local chicksclerae = vips.Image.new_from_file("chick/chick_sclerae.png")
  local chickbeak = vips.Image.new_from_file("chick/chick_beak.png")
  local chickfeet = vips.Image.new_from_file("chick/chick_feet.png")

  --coloring the body
  local cbodycolor = uj.chickstats.bodycolor
  chickbody = chickbody:colourspace("hsv") * { 0, 0, 1, 1 }
  chickbody = chickbody:colourspace("srgb") * { cbodycolor[1] / 255, cbodycolor[2] / 255, cbodycolor[3] / 255, 1 }

  --coloring the body parts
  local ceyecolor = uj.chickstats.eyecolor
  chickeyes = chickeyes * { ceyecolor[1] / 255, ceyecolor[2]/255, ceyecolor[3] / 255, 1 }

  local cscleracolor = uj.chickstats.scleracolor
  chicksclerae = chicksclerae * { cscleracolor[1] / 255, cscleracolor[2]/255, cscleracolor[3] / 255, 1 }
  
  local cbeakcolor = uj.chickstats.beakcolor
  chickbeak = chickbeak * { cbeakcolor[1] / 255, cbeakcolor[2]/255, cbeakcolor[3] / 255, 1 }

  local cfootcolor = uj.chickstats.footcolor
  chickfeet = chickfeet * { cfootcolor[1] / 255, cfootcolor[2]/255, cfootcolor[3] / 255, 1 }

  --combining the body parts
  local chickimg = chickbody:composite2(chickeyes, "over")
  chickimg = chickimg:composite2(chicksclerae, "over")
  chickimg = chickimg:composite2(chickbeak, "over")
  chickimg = chickimg:composite2(chickfeet, "over")

  chickimg:write_to_file("vips_out/chick.png")

  message.channel:send{
    content = "Chick",
    file = "vips_out/chick.png"
  }
  print(message.author.name .. " did !chick")
end
return command