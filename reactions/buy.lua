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
    end --other types also go up here
    
    if eom.itemtype == "card" then
      checked = (sj.cards[eom.sindex].name == eom.srequest) and (sj.cards[eom.sindex].stock ~= 0)
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
    
    if eom.itemtype == "consumable" then
      sj.consumables[eom.sindex].stock = sj.consumables[eom.sindex].stock - 1
      if not uj.consumables then uj.consumables = {} end
      local adding = consumabledb[eom.srequest].quantity or 1
      if not uj.consumables[eom.srequest] then
        uj.consumables[eom.srequest] = adding
      else
        uj.consumables[eom.srequest] = uj.consumables[eom.srequest] + adding
      end
    end 
    if eom.itemtype == "card" then
      sj.cards[eom.sindex].stock = sj.cards[eom.sindex].stock - 1
      if not uj.inventory then uj.inventory = {} end
      if not uj.inventory[eom.srequest] then
        uj.inventory[eom.srequest] = 1
      else
        uj.inventory[eom.srequest] = uj.inventory[eom.srequest] + 1
      end
    end 
    if eom.itemtype == "item" then
      sj.itemstock = sj.itemstock - 1
      uj.items[eom.srequest] = true
    end
    uj.tokens = uj.tokens - eom.sprice
    
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/shop.json", sj)
    reaction.message.channel:send("<@" .. uj.id .. "> successfully bought **" .. eom.sname .. "** from the shop.")
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not buy the **".. eom.sname .."**.")
  end
end
return reaction
