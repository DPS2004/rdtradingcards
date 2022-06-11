local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local request = data.crequest
  print("Loaded uj")

  if response == "yes" then
    print('user has accepted')

    if not uj.consumables[request] then
      interaction:reply("An error has occured. Please make sure that you still have the item!")
      return
    end

    local fn = request
    if consdb[request].command then
      request = consdb[request].command
    end

    cmdcons[request].run(uj, ujf, message, data.mt, interaction, fn)
  end

  if response == "no" then
    print('user has denied')
    interaction:reply("You decide to not use the **".. consdb[data.crequest].name .."**.")
  end
end
return reaction
