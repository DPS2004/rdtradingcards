local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
  print("Loaded uj")
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    --sanity check
    local checked = false
    if eom.itemtype == "consumable" then
      checked = (sj.consumables[eom.sindex].name == eom.srequest) and (sj.consumables[eom.sindex].stock ~= 0)
    end
    
    if not checked then
      reaction.message.channel:send("An error has occured. Please make sure that the thing you want is still in stock!")
      return
    end
    
    
    if uj.tokens < eom.sprice then
      reaction.message.channel:send("An error has occured. Please make sure that you have enough tokens!")
      return
    end

    --do the fucking thing here
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/shop.json", sj)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not buy the **".. eom.sname .."**.")
  end
end
return reaction
