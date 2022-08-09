local command = {}
function command.run(message)

  print(message.author.name .. " did !prestige")

	cmd.checkcollectors.run(message, mt)
	cmd.checkmedals.run(message, mt)

  if not message.guild then
    message.channel:send("You cannot prestige in DMs.") -- You could probably add some flair to these error messages lol
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)

  if not uj.medals["cardmaestro"] then
    local excludedcards = { "rdcards", "key" }
    local missingcount = 0

    for k, v in pairs(cdb) do
      if not table.search(excludedcards, k) and not uj.storage[k] and v.season <= 8 then
        missingcount = missingcount + 1
      end
    end
    message.channel:send("You are still missing " .. missingcount .. " cards.")
    return
  end

  ynbuttons(message, message.author.mentionString .. ", Are you sure you want to prestige? **This will erase one of every non-prestige card in your storage and reset your medal progress.**", "prestige", {})
end
return command