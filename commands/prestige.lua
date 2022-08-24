local command = {}
function command.run(message)

  print(message.author.name .. " did !prestige")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/prestige.json","")

	cmd.checkcollectors.run(message, mt)
	cmd.checkmedals.run(message, mt)

  if not message.guild then
    message.channel:send(lang.dm_message) -- You could probably add some flair to these error messages lol
    return
  end

  if not uj.medals["cardmaestro"] then
    local excludedcards = { "rdcards", "key" }
    local missingcount = 0

    for k, v in pairs(cdb) do
      if not table.search(excludedcards, k) and not uj.storage[k] and v.season <= 8 then
        missingcount = missingcount + 1
      end
    end
    message.channel:send(lang.missingcards_1 .. missingcount .. lang.missingcards_2)
    return
  end

  ynbuttons(message, message.author.mentionString .. lang.prestige_confirm, "prestige", {}, uj.id, uj.lang)
end
return command