local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !search")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/search.json","")
  if #mt ~= 1 then
    message.channel:send(lang.no_arguments)
    return
  end

  local request = mt[1]
  local curfilename = texttofn(request)

  if not curfilename then
    if nopeeking then
      message.channel:send(lang.error_nopeeking_1 .. request .. lang.error_nopeeking_2)
    else
      message.channel:send(lang.no_item_1 .. request .. lang.no_item_2)
    end
    return
  end

  local invnum = uj.inventory[curfilename] or 0
  local stornum = uj.storage[curfilename] or 0
  if nopeeking and invnum + stornum == 0 then
    message.channel:send(lang.error_nopeeking_1 .. request .. lang.error_nopeeking_2)
  else
    message.channel:send(lang.search_message_1 .. cdb[curfilename].name .. lang.search_message_2 .. invnum .. lang.search_message_3 .. stornum .. lang.search_message_4)
  end
end
return command
