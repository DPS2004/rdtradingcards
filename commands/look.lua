local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !look")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if not wj.ws then
    wj.ws = 508
    dpf.savejson("savedata/worldsave.json", wj)
  end
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  
  if uj.room == nil then
    uj.room = 0
  end
  
  if uj.timeslooked == nil then
    uj.timeslooked = 1
  else
    uj.timeslooked = uj.timeslooked + 1
  end
  
  if not mt[1] then
    mt[1] = ""
  end
  
  if texttofn(mt[1]) or itemtexttofn(mt[1]) or constexttofn(mt[1]) or medaltexttofn(mt[1]) then
    if (nopeeking and (uj.inventory[texttofn(mt[1])] or uj.storage[texttofn(mt[1])] or uj.items[itemtexttofn(mt[1])] or uj.medals[medaltexttofn(mt[1])])) or not nopeeking then
      if texttofn(mt[1]) then
        cmd.show.run(message, mt)
      elseif itemtexttofn(mt[1]) or constexttofn(mt[1]) then
        cmd.showitem.run(message, mt)
      elseif medaltexttofn(mt[1]) then
        cmd.showmedal.run(message, mt)
      end
      return
    end
  end

  local found = true
  if uj.room == 0 then  -----------------PYROWMID--------------------------
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/pyrowmid.json", "")
    
    if string.lower(mt[1]) == "pyrowmid" or mt[1] == "" or mt[1] == lang.request_pyrowmid then 
      if wj.ws < 501 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_pre_501,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/829255814169493535/pyr7.png'
          }
        }}
      elseif wj.ws == 501 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_501,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831189023426478170/pyrhole.png'
          }
        }}
      elseif wj.ws == 502 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_502,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831191711917146183/pyrhole2.png'
          }
        }}
      elseif wj.ws == 503 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_503,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831192398524710982/pyrhole3.png'
          }
        }}
      elseif wj.ws == 504 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_504,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831263091470630922/pyrhole4.png'
          }
        }}
      elseif wj.ws == 505 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_505,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831223296112066560/pyrhole5.png'
          }
        }}
      elseif wj.ws == 506 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_506,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831225534834802769/pyrhole6.png'
          }
        }}
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_pyrowmid,
          description = lang.looking_507,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831291533915324436/pyrholefinal.png'
          }
        }}
      end

    elseif string.lower(mt[1]) == "panda" or string.lower(mt[1]) == "het" or (uj.lang ~= "en" and mt[1] == lang.request_panda) then 
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_panda,
          description = lang.looking_panda,
        }}
        
    elseif string.lower(mt[1]) == "throne" or (uj.lang ~= "en" and mt[1] == lang.request_throne) then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_throne,
          description = lang.looking_throne,
        }}
        
    elseif string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" or (uj.lang ~= "en" and mt[1] == lang.request_machine_1 or mt[1] == lang.request_machine_2 or mt[1] == lang.request_machine_3) then 
      if wj.ws == 506 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_machine,
          description = lang.looking_machine_506,
        }}       
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_machine,
          description = lang.looking_machine,
        }}
      end
    
    elseif string.lower(mt[1]) == "hole" or (uj.lang ~= "en" and mt[1] == lang.request_hole) then
      if wj.ws < 501 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_pre_501,
        }}
      elseif wj.ws == 501 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_501,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279975153754/holeclose.png'
          }
        }}
      elseif wj.ws == 502 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_502,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507280905633812/holeclose2.png'
          }
        }}
      elseif wj.ws == 503 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_503,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507281941495948/holeclose3.png'
          }
        }}
      elseif wj.ws == 504 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_504,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507283624198174/holeclose4.png'
          }
        }}
      elseif wj.ws == 505 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_505,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507285242150922/holeclose5.png'
          }
        }}
      elseif wj.ws == 506 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_506,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507288165449728/holeclose6.png'
          }
        }}
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_hole,
          description = lang.looking_hole_507,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279164997642/holeclosefinal.png'
          }
        }}
      end
      
    elseif (string.lower(mt[1]) == "ladder" or (uj.lang ~= "en" and mt[1] == lang.request_ladder)) and wj.labdiscovered  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_ladder,
        description = lang.looking_ladder,
        image = {
          url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279164997642/holeclosefinal.png'
        }
      }}
      
    else
      found = false
    end
  end -------------------------------------END PYROWMID------------------------------------------------
  
  if uj.room == 1 then     --------------------------------------------------LAB--------------------------------------------------------------------------   
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/lab.json", "")
	  
    if (string.lower(mt[1]) == "lab" or string.lower(mt[1]) == "abandoned lab" or mt[1] == "" or (uj.lang ~= "en" and mt[1] == lang.request_lab_1 or mt[1] == lang.request_lab_2 or mt[1] == lang.request_lab_3)) and wj.labdiscovered  then 
      local laburl = "https://cdn.discordapp.com/attachments/829197797789532181/862885457854726154/lab_scanner.png"
      local labdesc = lang.looking_lab_post_901
      if wj.ws <= 901 then
        laburl = labimages[getletterindex(string.sub(wj.lablooktext, wj.lablookindex + 1, wj.lablookindex + 1))]
        labdesc = lang.looking_lab
      end
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_lab,
        description = labdesc,
        image = {
          url = laburl
        }
      }}
      wj.lablookindex = wj.lablookindex + 1
      wj.lablookindex = wj.lablookindex % string.len(wj.lablooktext)
      dpf.savejson("savedata/worldsave.json", wj)
      
    elseif (string.lower(mt[1]) == "spider" or string.lower(mt[1]) == "spiderweb" or string.lower(mt[1]) == "web" or string.lower(mt[1]) == "spider web" or (uj.lang ~= "en" and mt[1] == lang.request_spider_1 or mt[1] == lang.request_spider_2)) and wj.labdiscovered then       
      local newmessage = ynbuttons(message,lang.spider_alert,"spiderlook",{},uj.id,uj.lang)
      
    elseif (string.lower(mt[1]) == "terminal" or (uj.lang ~= "en" and mt[1] == lang.request_terminal)) and wj.labdiscovered  then  --FONT IS MS GOTHIC AT 24PX, 8PX FOR SMALL FONT
      if wj.ws < 508 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_terminal,
          description = lang.looking_terminal_pre_508,
          image = {
            url = "https://cdn.discordapp.com/attachments/829197797789532181/838832581147361310/terminal1.png"
          }
        }}
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_terminal,
          description = lang.looking_terminal,
          image = {
            url = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
          }
        }}
      end
    
    elseif (string.lower(mt[1]) == "database" or (uj.lang ~= "en" and mt[1] == lang.request_database)) and wj.labdiscovered  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_database,
        description = lang.looking_database,
        image = {
          url = labimages[getletterindex(string.sub(wj.lablooktext, wj.lablookindex + 1, wj.lablookindex + 1))]
        }
      }}
      wj.lablookindex = wj.lablookindex + 1
      
      wj.lablookindex = wj.lablookindex % string.len(wj.lablooktext)
      dpf.savejson("savedata/worldsave.json", wj)
    
    elseif (string.lower(mt[1]) == "table" or (uj.lang ~= "en" and mt[1] == lang.request_table)) and wj.labdiscovered  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_table,
        description = lang.looking_table,
      }}
    
    elseif (string.lower(mt[1]) == "poster" or string.lower(mt[1]) == "catposter" or string.lower(mt[1]) == "cat poster" or (uj.lang ~= "en" and mt[1] == lang.request_poster_1 or mt[1] == lang.request_poster_2 or mt[1] == lang.request_poster_3)) and wj.labdiscovered  then 
      if tonumber(wj.ws) ~= 901 then --normal cat poster
        local postermessage = {lang.looking_poster_1, lang.looking_poster_2, lang.looking_poster_3, lang.looking_poster_4, lang.looking_poster_5, lang.looking_poster_6, lang.looking_poster_7, lang.looking_poster_8, lang.looking_poster_9, lang.looking_poster_10, lang.looking_poster_11 }
        local posterimage = {"https://cdn.discordapp.com/attachments/829197797789532181/838962876751675412/poster1.png","https://cdn.discordapp.com/attachments/829197797789532181/839214962786172928/poster3.png","https://cdn.discordapp.com/attachments/829197797789532181/838791958905618462/poster4.png","https://cdn.discordapp.com/attachments/829197797789532181/838799811813441607/poster6.png","https://cdn.discordapp.com/attachments/829197797789532181/838937070616444949/poster7.png","https://cdn.discordapp.com/attachments/829197797789532181/838819064884232233/poster8.png","https://cdn.discordapp.com/attachments/829197797789532181/838799792267067462/poster9.png","https://cdn.discordapp.com/attachments/829197797789532181/838864622878588989/poster10.png","https://cdn.discordapp.com/attachments/829197797789532181/838870206687346768/poster11.png","https://cdn.discordapp.com/attachments/829197797789532181/839214999884398612/poster12.png","https://cdn.discordapp.com/attachments/829197797789532181/839215023662039060/poster13.png"}
        local cposter = math.random(1, #postermessage)
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_poster,
          description = postermessage[cposter],
          image = {
            url = posterimage[cposter]
          }
        }}
      else -- pull away cat poster
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.looking_at_poster,
          description = lang.looking_poster_901,
          image = {
            url = "https://cdn.discordapp.com/attachments/829197797789532181/860703201224949780/posterpeeling.png"
          }
        }}
      end
    
    elseif (string.lower(mt[1]) == "mouse hole" or string.lower(mt[1]) == "mouse" or string.lower(mt[1]) == "mousehole" or (uj.lang ~= "en" and mt[1] == lang.request_mousehole_1 or mt[1] == lang.request_mousehole_2 or mt[1] == lang.request_mousehole_3)) and wj.labdiscovered  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_mousehole,
        description = lang.looking_mousehole,
      }}
      
    elseif (string.lower(mt[1]) == "peculiar box" or string.lower(mt[1]) == "box" or string.lower(mt[1]) == "peculiarbox" or (uj.lang ~= "en" and mt[1] == lang.request_box_1 or mt[1] == lang.request_box_2 or mt[1] == lang.request_box_3)) and wj.labdiscovered  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_box,
        description = lang.looking_box,
      }}
      
    elseif (string.lower(mt[1]) == "scanner") and wj.ws >= 902 then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = "Looking at scanner...",
        description = 'TODO: scanner look text',
      }}
      
    else
      found = false
    end
  end
  
  if uj.room == 2 then     --------------------------------------------------MOUNTAINS--------------------------------------------------------------------------   
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/mountains.json", "")
    local request = string.lower(mt[1]) --why tf didint i do this for all the other ones?????????????????
    if (request == "mountains" or request == "mountain" or request == "windymountains" or request == "the windy mountains" or request == "windy mountains" or mt[1] == "" or (uj.lang ~= "en" and mt[1] == lang.request_mountains_1 or mt[1] == lang.request_mountains_2 or mt[1] == lang.request_mountains_3)) then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_mountains,
        description = lang.looking_mountains,
        image = {
          url = "https://cdn.discordapp.com/attachments/829197797789532181/871433038280675348/windymountains.png"
        }
      }}

    elseif (string.lower(mt[1]) == "pyrowmid" or (uj.lang ~= "en" and mt[1] == lang.request_pyrowmid))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_pyrowmid,
        description = lang.looking_pyrowmid,
      }}
      
    elseif (string.lower(mt[1]) == "bridge" or (uj.lang ~= "en" and mt[1] == lang.request_bridge))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_bridge,
        description = lang.looking_bridge,
      }}
      
    elseif (request == "shop" or request == "quaintshop" or request == "quaint shop" or (uj.lang ~= "en" and mt[1] == lang.request_shop_1 or mt[1] == lang.request_shop_2 or mt[1] == lang.request_shop_3 or mt[1] == lang.request_shop_4)) then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_shop,
        description = lang.looking_shop,
      }}
      
    elseif (request == "barrels" or (uj.lang ~= "en" and mt[1] == lang.request_barrels))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_barrels,
        description = lang.looking_barrels,
      }}
      
    elseif (request == "clouds" or (uj.lang ~= "en" and mt[1] == lang.request_clouds))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_clouds,
        description = lang.looking_clouds,
      }}

    else
      found = false
    end
  end
  
  if uj.room == 3 then  --------------------------------------------------SHOP--------------------------------------------------------------------------   
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/shop.json")
    local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
    if uj.lastrob + 4 > sj.stocknum and uj.lastrob ~= 0 then
      --lang = dpf.loadjson("langs/" .. uj.lang .. "/rob.json")
      lang = dpf.loadjson("langs/en/rob.json")
      local stocksleft = uj.lastrob + 3 - sj.stocknum
      local stockstring = lang.more_restock_1 .. stocksleft .. lang.more_restock_2
      if lang.needs_plural_s == true then
        if stocksleft > 1 then
          stockstring = stockstring .. lang.plural_s
        end
      end
      if uj.lastrob + 3 == sj.stocknum then
        local minutesleft = math.ceil((26/24 - time:toDays() + sj.lastrefresh) * 24 * 60)
        print(minutesleft)
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
        message.channel:send(lang.blacklist_next_1 .. durationtext .. lang.blacklist_next_2)
      else
        message.channel:send(lang.blacklist_1 .. stockstring .. lang.blacklist_2)
      end
      uj.room = 2
      return
    end
    args = {}
    for substring in mt[1]:gmatch("%S+") do
      table.insert(args, substring)
    end
      
    if args[1] == nil or args[1] == "-s" or args[1] == "-season" then
	  _G["request"] = ""
    else
	  _G["request"] = string.lower(args[1]) --why tf didint i do this for all the other ones?????????????????
    end
    
    if (request == "shop" or request == "quaintshop" or request == "quaint shop" or request == "" or (uj.lang ~= "en" and request == lang.request_shop_1 or request == lang.request_shop_2 or mt[1] == lang.request_shop_3 or mt[1] == lang.request_shop_4))  then
      local time = sw:getTime()
      checkforreload(time:toDays())
      local showShortHandForm = false
      local showSeasons = false

      if args[#args] == "-s" then
        showShortHandForm = true
        table.remove(args, #args)
      elseif args[#args] == "-season" then
        showSeasons = true
        table.remove(args, #args)
      end

      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local shopstr = ""
      for i,v in ipairs(sj.cards) do
        if uj.lang == "ko" then
        _G['tokentext'] = lang.shop_token_1 .. v.price .. lang.shop_token_2
        else
        _G['tokentext'] = v.price .. lang.shop_token_1 .. (v.price ~= 1 and lang.needs_plural_s == true and lang.plural_s or "")
        end
        if showShortHandForm == true then
          shopstr = shopstr .. "\n**"..cdb[v.name].name.."** (".. tokentext .. ") x"..v.stock .. " | ("..v.name..")"
        elseif showSeasons == true then
          shopstr = shopstr .. "\n**"..cdb[v.name].name.."** (".. tokentext .. ") x"..v.stock .. " | (Season "..cdb[v.name].season..")"
        else
          shopstr = shopstr .. "\n**"..cdb[v.name].name.."** (".. tokentext .. ") x"..v.stock
        end
      end
      for i,v in ipairs(sj.consumables) do
        if uj.lang == "ko" then
        _G['tokentext'] = lang.shop_token_1 .. v.price .. lang.shop_token_2
        else
        _G['tokentext'] = v.price .. lang.shop_token_1 .. (v.price ~= 1 and lang.needs_plural_s == true and lang.plural_s or "")
        end
        if showShortHandForm == true then
          shopstr = shopstr .. "\n**"..consdb[v.name].name.."** (".. tokentext .. ") x"..v.stock .. " | ("..v.name..")"
        else
          shopstr = shopstr .. "\n**"..consdb[v.name].name.."** (".. tokentext .. ") x"..v.stock
        end
      end

      if showShortHandForm == true then
        if uj.lang == "ko" then
        _G['tokentext'] = lang.shop_token_1 .. sj.itemprice .. lang.shop_token_2
        else
        _G['tokentext'] = sj.itemprice .. lang.shop_token_1 .. (sj.itemprice ~= 1 and lang.needs_plural_s == true and lang.plural_s or "")
        end
        shopstr = shopstr .. "\n**"..itemdb[sj.item].name.."** (" .. tokentext ..") x"..sj.itemstock.." | ("..sj.item..")"
      else
        if uj.lang == "ko" then
        _G['tokentext'] = lang.shop_token_1 .. sj.itemprice .. lang.shop_token_2
        else
        _G['tokentext'] = sj.itemprice .. lang.shop_token_1 .. (sj.itemprice ~= 1 and lang.needs_plural_s == true and lang.plural_s or "")
        end
        shopstr = shopstr .. "\n**"..itemdb[sj.item].name.."** (" .. tokentext ..") x"..sj.itemstock
      end

      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_shop,
        description = lang.looking_shop,
        fields = {{
          name = lang.shop_selling,
          value = shopstr,
          inline = true
        }},
        image = {url = "attachment://shop.png"}},
        files = {getshopimage()}}
      if not uj.togglechecktoken then
        message.channel:send(lang.checktoken_1 .. uj.tokens .. lang.checktoken_2 .. (uj.tokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.checktoken_3)
      end
      
    elseif (request == "wolf" or (uj.lang ~= "en" and request == lang.request_wolf))  then
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local time = sw:getTime()
      checkforreload(time:toDays())
      --extremely jank implementation, please make this cleaner if possible
      local minutesleft = math.ceil((26/24 - time:toDays() + sj.lastrefresh) * 24 * 60)
      print(minutesleft)
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
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_wolf,
        description = lang.looking_wolf_1 .. durationtext .. lang.looking_wolf_2,
      }}
      
    elseif (request == "ghost" or (uj.lang ~= "en" and request == lang.request_ghost))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_ghost,
        description = lang.looking_ghost,
      }}
      
    elseif (request == "photo" or request == "framed photo" or (uj.lang ~= "en" and request == lang.request_photo)) then
      local randomimages = {
        "https://cdn.discordapp.com/attachments/829197797789532181/880110700989673472/okamii_triangle_frame.png",
        "https://cdn.discordapp.com/attachments/829197797789532181/880302232338333747/okamii_triangle_frame_2.png",
        "https://cdn.discordapp.com/attachments/829197797789532181/880302252278034442/okamii_triangle_frame_3.png"
      }
      local imageindex = (uj.equipped == "okamiiscollar" and math.random(#randomimages) or 1)
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_photo,
        description = lang.looking_photo .. (imageindex ~= 1 and lang.looking_photo_ookami or ""),
        image = {url = randomimages[imageindex]}
      }}
      
    else
      found = false
    end
  end
  
  if not found then ----------------------------------NON-ROOM ITEMS GO HERE!--------------------------------------------------
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/nonrooms.json","")
    if string.lower(mt[1]) == "card factory" or string.lower(mt[1]) == "factory" or string.lower(mt[1]) == "cardfactory" or string.lower(mt[1]) == "the card factory" or (uj.lang ~= "en" and mt[1] == lang.request_factory_1 or mt[1] == lang.request_factory_2 or mt[1] == lang.request_factory_3) then --TODO: move these to not found
      message.channel:send {
        content = lang.looking_factory
      }
      
    elseif string.lower(mt[1]) == "token" or (uj.lang ~= "en" and mt[1] == lang.request_token) then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.looking_at_token,
        description = lang.looking_token,
        image = {
          url = 'https://cdn.discordapp.com/attachments/829197797789532181/829255830485598258/token.png'
        }
      }}
    
    else
      message.channel:send(lang.not_found_1 .. mt[1] .. lang.not_found_2)
      uj.timeslooked = uj.timeslooked - 1
    end
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command