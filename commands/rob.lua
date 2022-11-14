local command = {}
function command.run(message, mt)
  local time = sw:getTime()
  checkforreload(time:toDays())
  print(message.author.name .. " did !rob")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/rob.json", "")
  
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end
  
  local srequest
  local sname
  local stock
  local sindex
  local numrequest = 1

  if tonumber(mt[2]) then
    if tonumber(mt[2]) > 1 then
      numrequest = math.floor(mt[2])
    end
  end
  
  if not uj.lastrob then
    uj.lastrob = 0
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end

  if not wj.skiprob then
    wj.skiprob = false
    dpf.savejson("savedata/worldsave.json",wj)
  end

  if uj.lastrob + 4 > sj.stocknum and uj.lastrob ~= 0 then
    local stocksleft = uj.lastrob + 4 - sj.stocknum
    local stockstring = lang.more_restock_1 .. stocksleft .. lang.more_restock_2
    if lang.needs_plural_s == true then
      if stocksleft > 1 then
        stockstring = stockstring .. lang.plural_s
      end
    end
    local minutesleft = math.ceil((26/24 - time:toDays() + sj.lastrefresh) * 24 * 60)
    
    local durationtext = ""
    if math.floor(minutesleft / 60) > 0 then
      durationtext = math.floor(minutesleft / 60) .. lang.time_hour
      if lang.needs_plural_s == true then
        if math.floor(minutesleft / 60) ~= 1 then 
          durationtext = durationtext .. lang.plural_s 
        end
      end
    end
    if minutesleft % 60 > 0 then
      if durationtext ~= "" then
        durationtext = durationtext .. lang.time_and
      end
      durationtext = durationtext .. minutesleft % 60 .. lang.time_minute
      if lang.needs_plural_s == true then
        if minutesleft % 60 ~= 1 then
          durationtext = durationtext .. lang.plural_s 
        end
      end
    end
    if uj.lastrob + 3 == sj.stocknum then
      message.channel:send(lang.blacklist_next_1 .. durationtext .. lang.blacklist_next_2)
    else
      message.channel:send(lang.blacklist_1 .. stockstring .. lang.blacklist_2 .. durationtext .. lang.blacklist_3)
    end
    return
  end

  local newuj = automove(uj.room,"rob",message)
	  if newuj then
		  uj = newuj
	end

  --error handling
  local sendshoperror = {
    outofstock = function()
      message.channel:send(lang.out_of_stock_1 .. sname .. lang.out_of_stock_2)
    end,

    toomanyrequested = function()
      if uj.lang == "ko" then
        message.channel:send(lang.too_many_requested_1 .. sname .. lang.too_many_requested_2 .. stock .. lang.too_many_requested_3)
      else
        message.channel:send(lang.too_many_requested_1 .. stock .. lang.too_many_requested_2 .. sname .. lang.too_many_requested_3)
      end
    end,

    donthave = function()
      if nopeeking then
        message.channel:send(lang.nopeeking_error_1 .. mt[1] .. lang.nopeeking_error_2)
      else
        message.channel:send(lang.donthave_1 .. sname .. lang.donthave_2)
      end
    end,

    alreadyhave = function()
      message.channel:send(lang.alreadyhave_1 .. sname .. lang.alreadyhave_2)
    end,
      
    hasfixedmouse = function()
      message.channel:send(lang.hasfixedmouse)
    end,

    oneitemonly = function()
      message.channel:send(lang.oneitemonly)
    end,

    unknownrequest = function()
      if nopeeking then
        message.channel:send(lang.nopeeking_error_1 .. mt[1] .. lang.nopeeking_error_2)
      else
        message.channel:send(lang.unknownrequest_1 .. mt[1] .. lang.unknownrequest_2)
      end
    end
  }

  if not mt[1] or mt[1] == "" then
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

    if #itemtypes == 0 then
      message.channel:send(lang.rob_random_nothing)
      return
    end
    if uj.skipprompts and wj.skiprob then
      cmdre["rob"].run(message, nil, {random=true}, "yes")
    else
      ynbuttons(message,{
        color = 0x85c5ff,
        title = lang.robbing_shop_random,
        description = lang.rob_shop_random
      },"rob",{random=true}, uj.id, uj.lang)
    end
    return
  else
    if constexttofn(mt[1]) then
      srequest = constexttofn(mt[1])
      sname = consdb[srequest].name

      for i,v in ipairs(sj.consumables) do
        if v.name == srequest then
          sindex = i
          break
        end
      end

      if not sindex then
        sendshoperror["donthave"]()
        return
      end

      sprice = sj.consumables[sindex].price
      stock = sj.consumables[sindex].stock
      if stock <= 0 then
        sendshoperror["outofstock"]()
        return
      end

      if numrequest > stock then
        sendshoperror["toomanyrequested"]()
        return
      end
    
      -- can rob consumable
      if uj.skipprompts and wj.skiprob then
        cmdre["rob"].run(message, nil, {itemtype = "consumable",sname=sname,sindex=sindex,srequest=srequest,sprice=sprice,numrequest=numrequest, random=false}, "yes")
      else
        if uj.lang == "ko" then
          ynbuttons(message,{
            color = 0x85c5ff,
            title = lang.robbing_shop_1 .. sname .. lang.robbing_shop_2,
            description = "_" .. lang.rob_shop_desc .. "_\n`" .. consdb[srequest].description .. "`\n" .. lang.rob_shop_1 ..sname .. lang.rob_shop_2 .. numrequest .. lang.cons_unit .. lang.rob_shop_3 .. "\n"
          },"rob",{itemtype = "consumable",sname=sname,sindex=sindex,srequest=srequest,sprice=sprice,numrequest=numrequest, random=false}, uj.id, uj.lang)
        else
          ynbuttons(message,{
            color = 0x85c5ff,
            title = lang.robbing_shop_1 .. sname .. lang.robbing_shop_2,
            description = "_" .. lang.rob_shop_desc .. "_\n`" .. consdb[srequest].description .. "`\n" .. lang.rob_shop_1 .. numrequest .. lang.rob_shop_2 .. sname .. lang.rob_shop_3
          },"rob",{itemtype = "consumable",sname=sname,sindex=sindex,srequest=srequest,sprice=sprice,numrequest=numrequest, random=false}, uj.id, uj.lang)
        end
      end
      return
    end

    if itemtexttofn(mt[1]) then
      srequest = itemtexttofn(mt[1])
      sname = itemdb[srequest].name
      sprice = sj.itemprice

      if srequest ~= sj.item then
        sendshoperror["donthave"]()
        return
      end

      if uj.items[srequest] then
        sendshoperror["alreadyhave"]()
        return
      end

      if sj.item == "brokenmouse" and uj.items["fixedmouse"] then
        sendshoperror["hasfixedmouse"]()
        return
      end

      if sj.itemstock <= 0 then
        sendshoperror["outofstock"]()
        return
      end

      if numrequest > 1 then
        sendshoperror["oneitemonly"]()
        return
      end

      --can buy item
      if uj.skipprompts and wj.skiprob then
        cmdre["rob"].run(message, nil, {itemtype = "item",sname=sname,srequest=srequest,sprice=sprice,random=false}, "yes")
      else
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.robbing_shop_1 .. sname .. lang.robbing_shop_2,
          description = "_" .. lang.rob_shop_desc .. "_\n`" .. itemdb[srequest].description .. "`\n" .. lang.rob_shop_item_1 .. sname .. lang.rob_shop_item_2
        },"rob",{itemtype = "item",sname=sname,srequest=srequest,sprice=sprice,random=false}, uj.id, uj.lang)
      end
      return
    end

    if texttofn(mt[1]) then
      print("card!")
      srequest = texttofn(mt[1])
      sname = cdb[srequest].name

      for i,v in ipairs(sj.cards) do
        if v.name == srequest then
          sindex = i
          break
        end
      end

      if not sindex then
        sendshoperror["donthave"]()
        return
      end

      stock = sj.cards[sindex].stock
      if stock <= 0 then
        sendshoperror["outofstock"]()
        return
      end

      if numrequest > stock then
        sendshoperror["toomanyrequested"]()
        return
      end

      --can buy card
      if uj.skipprompts and wj.skiprob then
        cmdre["rob"].run(message, nil, {itemtype = "card",sname=sname,sindex=sindex,srequest=srequest,numrequest=numrequest, random=false}, "yes")
      else
        if uj.lang == "ko" then
          ynbuttons(message,{
            color = 0x85c5ff,
            title = lang.robbing_shop_1 .. sname .. lang.robbing_shop_2,
            description = "_" .. lang.rob_shop_desc .. "_\n`" .. cdb[srequest].description  .. "`\n" .. lang.rob_shop_1 .. sname .. lang.rob_shop_2 .. numrequest .. lang.card_unit .. lang.rob_shop_3
          },"rob",{itemtype = "card",sname=sname,sindex=sindex,srequest=srequest,numrequest=numrequest, random=false}, uj.id, uj.lang)
        else
          ynbuttons(message,{
            color = 0x85c5ff,
            title = lang.robbing_shop_1 .. sname .. lang.robbing_shop_2,
            description = "_" .. lang.rob_shop_desc .. "_\n`" .. cdb[srequest].description  .. "`\n" .. lang.rob_shop_1 .. numrequest .. lang.rob_shop_2 .. sname .. lang.rob_shop_3
          },"rob",{itemtype = "card",sname=sname,sindex=sindex,srequest=srequest,numrequest=numrequest, random=false}, uj.id, uj.lang)
        end
      end
      return
    end
    sendshoperror["unknownrequest"]()
  end
end
return command
