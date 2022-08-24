local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/prestige.json", "")
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    for k, v in pairs(uj.storage) do
      if k ~= "rdcards" then
        uj.storage[k] = uj.storage[k] - 1
        if uj.storage[k] == 0 then uj.storage[k] = nil end
      end
    end

    for k, v in pairs(uj.medals) do
      uj.medals[k] = false
    end

    uj.storage["rdcards"] = uj.storage["rdcards"] and uj.storage["rdcards"] + 1 or 1
    uj.timesprestiged = uj.timesprestiged and uj.timesprestiged + 1 or 1

    dpf.savejson(ujf,uj)

    interaction:updateDeferred()

    cmd.checkcollectors.run(message, nil, message.channel)
    cmd.checkmedals.run(message, nil, message.channel)

    message:reply(lang.prestiged_message)

  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.denied_message)
  end
end
return reaction
