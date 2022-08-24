local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !catch")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/catch.json", "")

  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end

  if not (#mt == 1) then
    message.channel:send(lang.no_arguments)
    return
  end

  local tj = dpf.loadjson("savedata/thrown.json", {})

  local cardfilename, consfilename = texttofn(mt[1]), constexttofn(mt[1])
  local curfilename = cardfilename or consfilename
  print(curfilename)

  if not curfilename then
    if nopeeking then
      message.channel:send(lang.nopeeking_1 .. mt[1] .. lang.nopeeking_2)
    else
      message.channel:send(lang.nodatabase_1 .. mt[1] .. lang.nodatabase_2)
    end
    return
  end

  local caughtname = cardfilename and cdb[cardfilename].name or consdb[consfilename].name

  if not (tj[curfilename]) then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send(lang.nopeeking_1 .. mt[1] .. lang.nopeeking_2)
    else
      message.channel:send(lang.notthrown_1 .. caughtname .. lang.notthrown_2)
    end
    return
  end

  if cardfilename then
    uj.inventory[cardfilename] = uj.inventory[cardfilename] and uj.inventory[cardfilename] + 1 or 1
  else
    uj.consumables[consfilename] = uj.consumables[consfilename] and uj.consumables[consfilename] + 1 or 1
  end
  uj.timescaught = uj.timescaught and uj.timescaught + 1 or 1
  client:emit(tj[curfilename][1])
  table.remove(tj[curfilename], 1)
  if not next(tj[curfilename]) then tj[curfilename] = nil end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  dpf.savejson("savedata/thrown.json", tj)

  local item = cardfilename and lang.card or lang.item
  if uj.lang == "ko" then
    local eul_leul = (item == "카드" and "를" or "을")
	local eul_leul_2 = (item == "카드" and "가 " or "이 ")
    message.channel:send(message.author.mentionString .. lang.caught_1 .. caughtname .. "** " .. item .. eul_leul .. lang.caught_2 .. caughtname .. "** " .. item .. eul_leul_2 .. lang.caught_3)
  else
    message.channel:send(message.author.mentionString .. lang.caught_1 .. caughtname .. "** " .. item .. lang.caught_2 .. caughtname .. "** " .. item .. lang.caught_3 .. uj.pronouns["their"] .. lang.caught_4)
  end
  if not uj.togglecheckcard then
    if not uj.storage[caughtname] then
      message.channel:send(lang.not_in_storage_1 .. caughtname .. lang.not_in_storage_2)
    end
  end
end
return command
