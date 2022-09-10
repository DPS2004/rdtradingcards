local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/rob.json", "")
  local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    if uj.lastrob + 3 > sj.stocknum and uj.lastrob ~= 0 then
      interaction:reply(lang.error_already_robbed)
      return
    end

    if not uj.timesrobbed then uj.timesrobbed = 1 else uj.timesrobbed = uj.timesrobbed + 1 end

    if data.random == true then
      local itemtypes = {}
      if sj.itemstock > 0 then
        if not uj.items[sj.item] then
          itemtypes[1] = "item"
        end
      end
      for i,v in ipairs(sj.cards) do
        if v.stock > 0 then
          itemtypes[#itemtypes + 1] = "card"
          break
        end
      end
      for i,v in ipairs(sj.consumables) do
        if v.stock > 0 then
          itemtypes[#itemtypes + 1] = "consumable"
          break
        end
      end

      if #itemtypes ~= 0 then -- and math.random(1,100) ~= 1
        data.itemtype = itemtypes[math.random(1,#itemtypes)]

        if data.itemtype == "item" then
          data.srequest = sj.item
          data.sname = itemdb[data.srequest].name
          data.sprice = sj.itemprice
        end

        if data.itemtype == "consumable" then
          local conslist = {}
          for i,v in ipairs(sj.consumables) do
            if v.stock > 0 then
              conslist[#conslist+1] = v.name 
            end
          end
          data.srequest = conslist[math.random(1,#conslist)]
          data.sname = consdb[data.srequest].name
          data.numrequest = 1
          for i,v in ipairs(sj.consumables) do
            if v.name == data.srequest then
              data.sindex = i
              break
            end
          end
          data.sprice = sj.consumables[data.sindex].price
        end

        if data.itemtype == "card" then
          local cardlist = {}
          for i,v in ipairs(sj.cards) do
            if v.stock > 0 then
              cardlist[#cardlist+1] = v.name 
            end
          end
          data.srequest = cardlist[math.random(1,#cardlist)]
          data.sname = cdb[data.srequest].name
          data.numrequest = 1
          for i,v in ipairs(sj.cards) do
            if v.name == data.srequest then
              data.sindex = i
              break
            end
          end
          data.sprice = sj.cards[data.sindex].price
        end
      --else
        --print("shoprobtime")
      end
    end

    if data.itemtype == "consumable" then
      local robchance = math.random(1,2*(data.sprice+data.numrequest))
      if robchance < 4 then
        print("rob succeeded")
        sj.consumables[data.sindex].stock = sj.consumables[data.sindex].stock - data.numrequest
        if not uj.consumables then uj.consumables = {} end
        local adding = (consdb[data.srequest].quantity or 1) * data.numrequest
        if not uj.consumables[data.srequest] then
          uj.consumables[data.srequest] = adding
        else
          uj.consumables[data.srequest] = uj.consumables[data.srequest] + adding
        end
        if uj.lang == "ko" then
          interaction:reply(lang.rob_succeeded_1 .. data.sname .. lang.rob_succeeded_2 .. data.numrequest .. lang.cons_unit .. lang.rob_succeeded_3)
        else
          interaction:reply(lang.rob_succeeded_1 .. data.numrequest .. lang.rob_succeeded_2 .. data.sname .. lang.rob_succeeded_3)
        end
        if not uj.timesrobsucceeded then uj.timesrobsucceeded = 1 else uj.timesrobsucceeded = uj.timesrobsucceeded + 1 end
      else
        print("rob failed")
        if uj.lang == "ko" then
          interaction:reply(lang.rob_failed_1 .. data.sname .. lang.rob_failed_2 .. data.numrequest .. lang.cons_unit .. lang.rob_failed_3)
        else
          interaction:reply(lang.rob_failed_1 .. data.numrequest .. lang.rob_failed_2 .. data.sname .. lang.rob_failed_3)
        end
        uj.lastrob = sj.stocknum
        uj.room = 2
        if not uj.timesrobfailed then uj.timesrobfailed = 1 else uj.timesrobfailed = uj.timesrobfailed + 1 end
      end
    end
    if data.itemtype == "card" then
      local robsucceed = false
      if cdb[data.srequest].type == "Rare" then
        local robchance = math.random(1,100)
        if robchance < 90 - 5 * (data.numrequest > 18 and 17 or data.numrequest - 1) then
          robsucceed = true
        end
      elseif cdb[data.srequest].type == "Super Rare" then
        local robchance = math.random(1,100)
        if robchance < 70 - 5 * (data.numrequest > 14 and 13 or data.numrequest - 1) then
          robsucceed = true
        end
      elseif cdb[data.srequest].type == "Ultra Rare" then
        local robchance = math.random(1,100)
        if robchance < 50 - 5 * (data.numrequest > 10 and 9 or data.numrequest - 1) then
          robsucceed = true
        end
      elseif cdb[data.srequest].type == "Alternate" or cdb[data.srequest].type == "Discontinued" then
        local robchance = math.random(1,100)
        if robchance < 30 - 3 * (data.numrequest > 10 and 9 or data.numrequest - 1) then
          robsucceed = true
        end
      elseif cdb[data.srequest].type == "Discontinued Rare" then
        local robchance = math.random(1,100)
        if robchance < 20 - 3 * (data.numrequest > 7 and 6 or data.numrequest - 1) then
            robsucceed = true
        end
      elseif cdb[data.srequest].type == "Discontinued Super Rare" then
        local robchance = math.random(1,100)
        if robchance < 15 - 2 * (data.numrequest > 8 and 7 or data.numrequest - 1) then
          robsucceed = true
        end
      elseif cdb[data.srequest].type == "Discontinued Ultra Rare" or cdb[data.srequest].type == "Discontinued Alternate" or cdb[data.srequest].type == "Alternate Alternate" then
        local robchance = math.random(1,100)
        if robchance < 10 - 1 * (data.numrequest > 10 and 9 or data.numrequest - 1) then
          robsucceed = true
        end
      end
      if robsucceed == true then
        print("rob succeded")
        sj.cards[data.sindex].stock = sj.cards[data.sindex].stock - data.numrequest
        if not uj.inventory then uj.inventory = {} end
        if not uj.inventory[data.srequest] then
          uj.inventory[data.srequest] = data.numrequest
        else
          uj.inventory[data.srequest] = uj.inventory[data.srequest] + data.numrequest
        end
        if uj.lang == "ko" then
          interaction:reply(lang.rob_succeeded_1 .. data.sname .. lang.rob_succeeded_2 .. data.numrequest .. lang.card_unit .. lang.rob_succeeded_3)
        else
          interaction:reply(lang.rob_succeeded_1 .. data.numrequest .. lang.rob_succeeded_2 .. data.sname .. lang.rob_succeeded_3)
        end
        if not uj.timesrobsucceeded then uj.timesrobsucceeded = 1 else uj.timesrobsucceeded = uj.timesrobsucceeded + 1 end
      else
        print("rob failed")
        if uj.lang == "ko" then
          interaction:reply(lang.rob_failed_1 .. data.sname .. lang.rob_failed_2 .. data.numrequest .. lang.card_unit .. lang.rob_failed_3)
        else
          interaction:reply(lang.rob_failed_1 .. data.numrequest .. lang.rob_failed_2 .. data.sname .. lang.rob_failed_3)
        end
        uj.lastrob = sj.stocknum
        uj.room = 2
        if not uj.timesrobfailed then uj.timesrobfailed = 1 else uj.timesrobfailed = uj.timesrobfailed + 1 end
      end
    end
    if data.itemtype == "item" then
      local robchance = math.random(1,2*data.sprice)
      if robchance < 4 then
        print("rob succeded")
        sj.itemstock = sj.itemstock - 1
        uj.items[data.srequest] = true
        interaction:reply(lang.rob_succeeded_item_1 .. data.sname .. lang.rob_succeeded_item_2)
        if not uj.timesrobsucceeded then uj.timesrobsucceeded = 1 else uj.timesrobsucceeded = uj.timesrobsucceeded + 1 end
      else
        print("rob failed")
        interaction:reply(lang.rob_failed_item_1 .. data.sname .. lang.rob_failed_item_2)
        uj.lastrob = sj.stocknum
        uj.room = 2
        if not uj.timesrobfailed then uj.timesrobfailed = 1 else uj.timesrobfailed = uj.timesrobfailed + 1 end
      end
    end
    
    dpf.savejson(ujf, uj)
    dpf.savejson("savedata/shop.json", sj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.rob_cancelled_1 .. uj.id .. lang.rob_cancelled_2)
  end
end
return reaction
