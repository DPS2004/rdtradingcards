local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local request = data.crequest
  print("Loaded uj")

  if response == "yes" then
    print('user has accepted')

    if not uj.consumables[request] then
      interaction:reply(lang.no_item)
      return
    end
	if uj.equipped == 'aceofhearts' then
		if uj.acepulls ~= 0 then
			message.channel:send('The pulls stored in your **Ace of Hearts** disappear...')
			uj.acepulls = 0
		end
	end

    local fn = request
    if consdb[request].command then
      request = consdb[request].command
    end

    cmdcons[request].run(uj, ujf, message, data.mt, interaction, fn)
  end

  if response == "no" then
    print('user has denied')
    interaction:reply(lang.denied_message_1 .. consdb[data.crequest].name .. lang.denied_message_2)
  end
end
return reaction
