local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !showitem")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/showitem.json","")
  if #mt ~= 1 then
    message.channel:send(lang.no_arguments)
    return
  end

  if not uj.consumables then uj.consumables = {} end
  local curfilename = itemtexttofn(mt[1]) or constexttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.no_item_1 .. mt[1] .. lang.no_item_1)
    end
    return
  end

  local description = itemdb[curfilename] and itemdb[curfilename].description or consdb[curfilename].description
  local name = itemdb[curfilename] and itemdb[curfilename].name or consdb[curfilename].name
  local embedurl = itemdb[curfilename] and itemdb[curfilename].embed or consdb[curfilename].embed

  if not (uj.items[curfilename] or uj.consumables[curfilename] or shophas(curfilename)) then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. mt[1] .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.dont_have_1 .. name .. lang.dont_have_2)
    end
    return
  end

  print("user has item or consumable")
  
  message.channel:send{embed = {
    color = 0x85c5ff,
    title = lang.showing_item,
    description = lang.show_item_1 .. name .. lang.show_item_2 .. curfilename .. lang.show_item_3 .. description,
    image = {
      url = embedurl
    }
  }}
end
return command
