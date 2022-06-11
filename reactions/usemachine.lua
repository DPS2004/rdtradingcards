local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    if uj.tokens < 3 then
      interaction:reply("An error has occured. Please make sure that you have enough tokens!")
      return
    end

    local itempt = {}
    for k in pairs(itemdb) do
      if uj.items["fixedmouse"] then
        if not uj.items[k] and k ~= "brokenmouse" then table.insert(itempt, k) end
      else
        if not uj.items[k] and k ~= "fixedmouse" then table.insert(itempt, k) end
      end
    end
    print(inspect(itempt))

    if #itempt == 0 then
      interaction:reply("An error has occured. You already have every item that is currently available.")
      return
    end

    local newitem = itempt[math.random(#itempt)]
    uj.items[newitem] = true
    uj.tokens = uj.tokens - 3
    interaction:reply(trf("crank") .. itemdb[newitem].name .. '**! You put the **'.. itemdb[newitem].name ..'** with your items.')
    dpf.savejson(ujf,uj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("You decide to not use the **Strange Machine**.")
  end
end
return reaction
