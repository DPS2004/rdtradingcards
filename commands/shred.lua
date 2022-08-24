local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !shred")
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/shred.json", "")
  if not (#mt == 1 or #mt == 2) then
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

  if not uj.inventory[curfilename] then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send(lang.dont_have_1 .. cdb[curfilename].name .. lang.dont_have_2)
    end
    return
  end

  local numcards = 1
  if tonumber(mt[2]) then
    if tonumber(mt[2]) > 1 then numcards = math.floor(mt[2]) end
  end
  if mt[2] == "all" then
    numcards = uj.inventory[curfilename]
  end

  if uj.inventory[curfilename] >= numcards then
    if uj.lang == "ko" then
		ynbuttons(message, lang.shred_confirm_1 .. uj.id .. lang.shred_confirm_2 .. cdb[curfilename].name .. lang.shred_confirm_3 .. numcards .. lang.shred_confirm_4 .. lang.shred_confirm_5, "shred", {curfilename = curfilename,numcards = numcards}, uj.id, uj.lang)
	else
		ynbuttons(message, lang.shred_confirm_1 .. uj.id .. lang.shred_confirm_2 .. numcards .. lang.shred_confirm_3 .. cdb[curfilename].name .. lang.shred_confirm_4 .. (numcards ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.shred_confirm_5, "shred", {curfilename = curfilename,numcards = numcards}, uj.id, uj.lang)
	end
  else
    message.channel:send(lang.not_enough_1 .. cdb[curfilename].name .. lang.not_enough_2)
  end
end
return command
  