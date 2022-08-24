local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !show")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/show.json","")
  if #mt ~= 1 then
    message.channel:send(lang.no_arguments)
    return
  end

  local curfilename = texttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.no_item_1 .. mt[1] .. lang.no_item_2)
    end
    return
  end

  if not ((uj.inventory[curfilename] or uj.storage[curfilename])) and (not shophas(curfilename)) then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.dont_have_1 .. cdb[curfilename].name .. lang.dont_have_2)
    end
    return
  end

  print("user has card")
  if not cdb[curfilename].spoiler then
    local embeddescription = ""
    if cdb[curfilename].description then
      embeddescription = "\n\n*" .. lang.embeddescription .. "*\n> " .. cdb[curfilename].description
    end
    message.channel:send{embed = {
      color = 0x85c5ff,
      title = lang.showing_card,
      description = 
      lang.show_card_1 .. cdb[curfilename].name .. lang.show_card_2 .. curfilename .. lang.show_card_3 .. embeddescription,
      image = {
        url = type(cdb[curfilename].embed) == "table" and cdb[curfilename].embed[math.random(#cdb[curfilename].embed)] or cdb[curfilename].embed
      }
    }}
  else
    print("spiderrrrrrr")
    message.channel:send{
      content = lang.show_card_1 .. cdb[curfilename].name .. lang.show_card_2 .. curfilename .. lang.show_card_3,
      file = "card_images/SPOILER_" .. curfilename .. ".png"
    }
    if cdb[curfilename].description then
      message.channel:send(lang.embeddescription .. "\n> " .. cdb[curfilename].description)
    end
  end
end
return command
  