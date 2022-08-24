local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/shop/buy.json","")
  local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    --sanity check
    local checked = false
    if data.itemtype == "consumable" then
      checked = (sj.consumables[data.sindex].name == data.srequest) and (sj.consumables[data.sindex].stock >= data.numrequest)
    end --other types also go up here
    
    if data.itemtype == "card" then
      checked = (sj.cards[data.sindex].name == data.srequest) and (sj.cards[data.sindex].stock >= data.numrequest)
    end

    if data.itemtype == "item" then
      checked = (sj.item == data.srequest) and (sj.itemstock ~= 0)
    end
    
    if not checked then
      interaction:reply(lang.error_not_in_stock)
      return
    end
    
    
    if uj.tokens < data.sprice then
      interaction:reply(lang.error_not_enough_tokens)
      return
    end

    --do the fucking thing here
    
    if data.itemtype == "consumable" then
      sj.consumables[data.sindex].stock = sj.consumables[data.sindex].stock - data.numrequest
      if not uj.consumables then uj.consumables = {} end
      local adding = (consdb[data.srequest].quantity or 1) * data.numrequest
      if not uj.consumables[data.srequest] then
        uj.consumables[data.srequest] = adding
      else
        uj.consumables[data.srequest] = uj.consumables[data.srequest] + adding
      end
    end 
    if data.itemtype == "card" then
      sj.cards[data.sindex].stock = sj.cards[data.sindex].stock - data.numrequest
      if not uj.inventory then uj.inventory = {} end
      if not uj.inventory[data.srequest] then
        uj.inventory[data.srequest] = data.numrequest
      else
        uj.inventory[data.srequest] = uj.inventory[data.srequest] + data.numrequest
      end
    end 
    if data.itemtype == "item" then
      sj.itemstock = sj.itemstock - 1
      uj.items[data.srequest] = true
    end
    uj.tokens = uj.tokens - data.sprice
    
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/shop.json", sj)
    interaction:reply(lang.bought_message_1 .. uj.id .. lang.bought_message_2 .. data.sname .. lang.bought_message_3)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.denied_message_1 .. data.sname .. lang.denied_message_2)
  end
end
return reaction
