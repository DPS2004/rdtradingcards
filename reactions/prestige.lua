local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)

  print("Loaded uj")
  
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)
  

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    for k, v in pairs(uj.storage) do
      if k ~= "rdcards" then
        uj.storage[k] = uj.storage[k] - 1
        if uj.storage[k] == 0 then uj.storage[k] = nil end
      end
    end

    uj.storage["rdcards"] = uj.storage["rdcards"] and uj.storage["rdcards"] + 1 or 1

    cmd.checkmedals.run(eom.ogmessage, {}, reaction.message.channel)
	
    reaction.message.channel:send("You feel your storage getting a lot lighter. The **RDCards** card gets added to your storage.") -- Add some flair here yadda yadda
	
	dpf.savejson(ujf,uj)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide not to prestige.")
  end
end
return reaction
