local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !showmedal")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/showmedal.json", "")
  if #mt ~= 1 then
    message.channel:send(lang.no_arguments)
    return
  end

  local curfilename = medaltexttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.no_medal_1 .. mt[1] .. lang.no_medal_2)
    end
    return
  end

  if not uj.medals[curfilename] then
    print("user doesnt have medal")
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.dont_have_1 .. medaldb[curfilename].name .. lang.dont_have_2)
    end
    return
  end

  print("user has medal")
  message.channel:send{embed = {
    color = 0x85c5ff,
    title = lang.showing_medal,
    description = lang.show_medal_1 .. medaldb[curfilename].name .. lang.show_medal_2 .. curfilename .. lang.show_medal_3 .. medaldb[curfilename].description,
    image = {
      url = medaldb[curfilename].embed
    }
  }}
end
return command
