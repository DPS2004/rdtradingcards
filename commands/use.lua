local command = {}
function command.run(message, mt,bypass)
  print(message.author.name .. " did !use")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/nonroom.json","")
  local time = sw:getTime()
  local request = string.lower(mt[1])

  if not (message.guild or bypass or constexttofn(request)) then
    message.channel:send(lang.dm_message)
    return
  end
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if not uj.room then uj.room = 0 end
  
  if request == "shop" and uj.room == 2 then
  else
	  local newuj = automove(uj.room,request,message)
	  if newuj then
		  uj = newuj
	  end
  end
  
  local found = true

  ----------------------------PYROWMID------------------------
  if uj.room == 0 or bypass then
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/pyrowmid/pyrowmid.json","")
    if request == "strange machine" or request == "machine" or (uj.lang ~= "en" and request == lang.request_machine_1 or request == lang.request_machine_2 or request == lang.request_machine_3) then 
      lang = dpf.loadjson("langs/" .. uj.lang .. "/use/pyrowmid/machine.json","")
	  if not uj.tokens then uj.tokens = 0 end
      if not uj.items then uj.items = {nothing = true} end
      if wj.ws ~= 506 then
        local itempt = {}
        for k in pairs(itemdb) do
          if uj.items["fixedmouse"] then
            if not uj.items[k] and k ~= "brokenmouse" then table.insert(itempt, k) end
          else
            if not uj.items[k] and k ~= "fixedmouse" then table.insert(itempt, k) end
          end
        end
        if #itempt == 0 then
          message.channel:send(lang.allitems)
          return
        end
        if uj.tokens < 3 then
          message.channel:send(lang.notokens)
          return
        end
        if not uj.skipprompts then
          ynbuttons(message, {
            color = 0x85c5ff,
            title = lang.using_machine,
            description = lang.use_machine_1 .. uj.tokens .. lang.use_machine_2,
          },"usemachine",{}, uj.id, uj.lang)
          return
        else
          local newitem = itempt[math.random(#itempt)]
          uj.items[newitem] = true
          uj.tokens = uj.tokens - 3
          uj.timesused = uj.timesused and uj.timesused + 1 or 1
		  if uj.lang == "ko" then		    
		    local dep = {"삽입하고", "넣고", "슬롯에 집어넣고"}
			local cdep = math.random(1, #dep)
			local speen = {" 돌리", " 사용하", " 회전시키"}
			local cspeen = math.random(1, #speen)
			local size = {" 큰 ", " 작은 ", " ", " "}
			local csize = math.random(1, #size)
			local action = {"나옵니다", "떨어져 나옵니다", "튕겨져 나옵니다", "굴려 나옵니다"}
			local caction = math.random(1, #action)
			message.channel:send(lang.used_machine_1 .. dep[cdep] .. lang.used_machine_2 .. speen[cspeen] .. lang.used_machine_3 .. size[csize] .. lang.used_machine_4 .. action[caction] .. lang.used_machine_5 .. itemdb[newitem].name .. lang.used_machine_6 .. itemdb[newitem].name .. lang.used_machine_7)
		  else
		    message.channel:send(trf("crank") .. itemdb[newitem].name .. lang.used_machine_1 .. itemdb[newitem].name .. lang.used_machine_2)
		  end
		end
      else
        if uj.tokens >= 4 then
          ynbuttons(message, {
          color = 0x85c5ff,
          title = lang.using_machine,
          description = lang.use_machine_four_1 .. uj.tokens .. lang.use_machine_four_2, 
          },"getladder", {}, uj.id, uj.lang)
          return
        else
          message.channel:send(lang.notokens_four)
        end
      end
    elseif request == "hole" or (uj.lang ~= "en" and request == lang.request_hole) then
      if uj.tokens == nil then uj.tokens = 0 end
      if wj.ws >= 506 or wj.ws < 501 then
        message.channel:send(lang.hole_nodonations)
        return
      end
      if uj.tokens > 0 then
        ynbuttons(message, {
        color = 0x85c5ff,
        title = lang.using_hole,
        description = lang.use_hole_1 .. uj.tokens .. lang.use_hole_2, 
        },"usehole", {}, uj.id, uj.lang)
        return
      else
        message.channel:send(lang.hole_notokens)
      end
    elseif request == "panda" or (uj.lang ~= "en" and request == lang.request_panda) then    
      if uj.equipped == "coolhat" then
        if not uj.storage.ssss45 then
          message.channel:send(lang.panda_ssss45)
          uj.storage.ssss45 = 1
        else
          message.channel:send(':pensive:')
        end
      else
        message.channel:send(':flushed:')
      end
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif request == "throne" or (uj.lang ~= "en" and request == lang.request_throne) then       
      message.channel:send(lang.throne_by_panda)
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif (request == "necklace" or request == "faithfulnecklace" or request == "faithful necklace" or (uj.lang ~= "en" and request == lang.request_necklace)) and uj.items["faithfulnecklace"] then       
      message.channel:send(lang.wash_necklace)
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif request == "ladder" or (uj.lang ~= "en" and request == lang.request_ladder) then
      if wj.ws >= 507 then
        local embedtitle = lang.using_ladder
        if not wj.labdiscovered then
          embedtitle = lang.discovered_lab
          wj.labdiscovered = true
        end
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = embedtitle,
          description = lang.used_ladder,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
          }
        }}
        uj.room = 1
        dpf.savejson("savedata/worldsave.json", wj)
        dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
        return
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.using_ladder,
          description = lang.using_ladder_small,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831868583696269312/nowigglezone.png'
          }
        }}
      end
    else
      found = false
    end
  end
  
  ----------------------------LAB------------------------
  if (uj.room == 1 or bypass) and wj.labdiscovered then
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/lab/lab.json","")
    if request == "spider" or request == "spiderweb" or request == "web" or request == "spider web" or (uj.lang ~= "en" and request == lang.request_spider_1 or request == lang.request_spider_2) then       
      ynbuttons(message, lang.spider_alert,"spideruse",{},uj.id,uj.lang)
      return
    elseif request == "table" or (uj.lang ~= "en" and request == lang.request_table) then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.using_table,
        description = lang.use_table,
      }}
    elseif request == "poster" or request == "catposter" or request == "cat poster" or (uj.lang ~= "en" and request == lang.request_poster_1 or request == lang.request_poster_2 or request == lang.request_poster_3) then 
      if wj.ws ~= 801 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.using_poster_before801,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/838793078574809098/blankwall.png'
          }
        }}
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.using_poster,
          description = lang.use_poster,
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/862883805786144768/scanner.png'
          }
        }}
        wj.ws = 802
      end
    elseif request == "mouse hole" or request == "mouse" or request == "mousehole" or (uj.lang ~= "en" and request == lang.request_hole_1 or request == lang.request_hole_2 or request == lang.request_hole_3) then 
      if uj.equipped == "brokenmouse" then
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.using_hole,
          description = message.author.mentionString .. lang.use_hole_mouse,
        },"usemousehole",{},uj.id,uj.lang)
        return
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.using_hole,
          description = lang.use_hole,
        }}
      end
    elseif request == "peculiar box" or request == "box" or request == "peculiarbox" or (uj.lang ~= "en" and request == lang.request_box_1 or request == lang.request_box_2 or request == lang.request_box_3) then 
	  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/lab/box.json", "")
      if not uj.lastbox then 
        uj.lastbox = -24
      end
      local cooldown = (uj.equipped == "stainedgloves") and 8 or 11.5
      if uj.lastbox + cooldown > time:toHours() then
        local minutesleft = math.ceil(uj.lastbox * 60 - time:toMinutes() + cooldown * 60)
        local durationtext = ""
        if math.floor(minutesleft / 60) > 0 then
          durationtext = math.floor(minutesleft / 60) .. lang.time_hour
		  if lang.needs_plural_s == true then
            if math.floor(minutesleft / 60) ~= 1 then durationtext = durationtext .. lang.time_plural_s end
		  end
        end
        if minutesleft % 60 > 0 then
          if durationtext ~= "" then durationtext = durationtext .. lang.time_and end
          durationtext = durationtext .. minutesleft % 60 .. lang.time_minute
		  if lang.needs_plural_s == true then
            if minutesleft % 60 ~= 1 then durationtext = durationtext .. lang.time_plural_s end
		  end
        end
        message.channel:send(lang.wait_message_1 .. durationtext .. lang.wait_message_2)
        return
      end

      if not next(uj.inventory) then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = lang.embed_title,
          description = lang.embed_no_card,
        }}
        return
      end
      
      if not uj.skipprompts then
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.embed_title,
          description = message.author.mentionString .. lang.confirm_message,
        },"usebox",{}, uj.id, uj.lang)
        return
      else
        local iptable = {}
        for k, v in pairs(uj.inventory) do
          for i = 1, v do
            table.insert(iptable, k)
          end
        end

        local givecard = iptable[math.random(#iptable)]
        print("user giving " .. givecard)
        local boxpoolindex = math.random(#wj.boxpool)
        local getcard = wj.boxpool[boxpoolindex]
        print("user getting " .. getcard)
        
        uj.inventory[getcard] = uj.inventory[getcard] and uj.inventory[getcard] + 1 or 1
        uj.inventory[givecard] = uj.inventory[givecard] - 1
        if uj.inventory[givecard] == 0 then uj.inventory[givecard] = nil end
        
        wj.boxpool[boxpoolindex] = givecard
        
		if uj.lang == "ko" then
          message.channel:send(lang.boxed_message_1 .. uj.id .. lang.boxed_message_2 .. cdb[givecard].name .. lang.boxed_message_3 .. cdb[getcard].name .. lang.boxed_message_4 .. getcard .. lang.boxed_message_5)
		else
		  message.channel:send(lang.boxed_message_1 .. uj.id .. lang.boxed_message_2 .. cdb[givecard].name .. lang.boxed_message_3 .. uj.pronouns["their"] .. lang.boxed_message_4 .. cdb[getcard].name .. lang.boxed_message_5 .. uj.pronouns["their"] .. lang.boxed_message_6 .. getcard .. lang.boxed_message_7)
		end

         if not uj.storage[getcard] then
            if not uj.checkcard then
                message.channel:send(lang.not_in_storage_1 .. cdb[getcard].name .. lang.not_in_storage_2)
            end
        end
        uj.timesusedbox = uj.timesusedbox and uj.timesusedbox + 1 or 1
        uj.lastbox = time:toHours()
        if uj.sodapt then
          if uj.sodapt.box then
            uj.lastbox = uj.lastbox + uj.sodapt.box
            uj.sodapt.box = nil
            if uj.sodapt == {} then
              uj.sodapt = nil
            end
          end
        end
      end
    elseif request == "scanner" and wj.ws >= 802 then
      if wj.ws < 804 then -- lab not unlocked
        if uj.storage.key then
          --interact with key card and unlock hallway
          wj.ws = 804
        else
          -- no key card, but interacted with
        end
      else
        --hallway unlocked
      end
      
    elseif request == "terminal" or (uj.lang ~= "en" and request == lang.request_terminal) then 
	  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/lab/terminal.json", "")
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
      if not mt[2] then mt[2] = "" end
      local embedtitle = lang.using_terminal
      local embeddescription = nil
      local embedimage = nil
      local filename = nil
      if wj.ws < 508 then
        if string.lower(mt[2]) == "gnuthca" then
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838841498757234728/terminal3.png"
          wj.ws = 508
        else
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838841479698579587/terminal4.png"
        end
      else
        if string.lower(mt[2]) == "gnuthca" then
          embeddescription = lang.logged_in
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
        elseif string.lower(mt[2]) == "cat" then
          embeddescription = '`=^•_•^=`'
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838840001310752788/terminalcat.gif"
        elseif string.lower(mt[2]) == "dog" then
          embeddescription = [[```
   __
o-''|\\_____/)
 \\_/|_)     )
    \\  __  /
    (_/ (_/
          ```]]
        elseif string.lower(mt[2]) == "savedata" then
          local data = "savedata/" .. uj.id .. ".json"
          if not (mt[3] == "") then
            data = usernametojson(mt[3])
          end
          if not data then
            embeddescription = lang.savedata_not_found
          else
            embeddescription = lang.savedata_success
            filename = data
          end
        elseif string.lower(mt[2]) == "piss" then
          embeddescription = lang.piss_message
          embedimage = "https://cdn.discordapp.com/attachments/793993844789870603/880369620442304552/unknown.png"
        elseif string.lower(mt[2]) == "teikyou" then
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/849431570103664640/teikyou.png"
        elseif string.lower(mt[2]) == "help" or mt[2] == "" then
          embeddescription = lang.help_message .. "\nHELP\nSTATS\nUPGRADE\nCREDITS\nSAVEDATA" .. (wj.ws >= 701 and "\nLOGS" or "") .. "`"
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
        elseif string.lower(mt[2]) == "stats" then
          if not uj.timespulled then uj.timespulled = 0 end
          if not uj.timesshredded then uj.timesshredded = 0 end
          if not uj.timesused then uj.timesused = 0 end
          if not uj.timesitemused then uj.timesitemused = 0 end
          if not uj.timesprayed then uj.timesprayed = 0 end
          if not uj.timesstored then uj.timesstored = 0 end
          if not uj.timestraded then uj.timestraded = 0 end
          if not uj.timesusedbox then uj.timesusedbox = 0 end
          if not uj.timescardgiven then uj.timescardgiven = 0 end
          if not uj.tokensdonated then uj.tokensdonated = 0 end
          if not uj.timescardreceived then uj.timescardreceived = 0 end
          if not uj.timeslooked then uj.timeslooked = 0 end
          if not uj.timesdoubleclicked then uj.timesdoubleclicked = 0 end
          if not uj.timesthrown then uj.timesthrown = 0 end
          if not uj.timescaught then uj.timescaught = 0 end
          if not uj.timesitemgiven then uj.timesitemgiven = 0 end
          if not uj.timesitemreceived then uj.timesitemreceived = 0 end
          if not uj.timesprestiged then uj.timesprestiged = 0 end
          embeddescription = lang.stats_message .. "\n`" .. lang.stats_timespulled .. uj.timespulled .. "\n" .. lang.stats_timesused .. uj.timesused .. "\n" .. lang.stats_timesitemused .. uj.timesitemused .. "\n" .. lang.stats_timeslooked .. uj.timeslooked .. "\n" .. lang.stats_timesprayed .. uj.timesprayed .. "\n" .. lang.stats_timesshredded .. uj.timesshredded .. "\n" .. lang.stats_timesstored .. uj.timesstored .. "\n" .. lang.stats_timestraded .. uj.timestraded .. "\n" .. lang.stats_timesusedbox .. uj.timesusedbox .. "\n" .. lang.stats_timesdoubleclicked .. uj.timesdoubleclicked .. "\n" .. lang.stats_timesdonated .. uj.tokensdonated .. "\n" .. lang.stats_timesitemgiven .. uj.timesitemgiven .. "\n" .. lang.stats_timesitemreceived .. uj.timesitemreceived .. "\n" .. lang.stats_timescardgiven .. uj.timescardgiven .. "\n" .. lang.stats_timescardreceived .. uj.timescardreceived .. "\n" .. lang.stats_timesthrown .. uj.timesthrown .. "\n" .. lang.stats_timescaught .. uj.timescaught .. "\n" .. lang.stats_timesprestiged .. uj.timesprestiged ..(math.random(100) == 1 and "\n" .. lang.stats_factory or "") .. "`"
        elseif string.lower(mt[2]) == "credits" then
          embedtitle = lang.credits_title
          embeddescription = 'https://docs.google.com/document/d/1WgUqA8HNlBtjaM4Gpp4vTTEZf9t60EuJ34jl2TleThQ/edit?usp=sharing'
        elseif string.lower(mt[2]) == "logs" then
          embedtitle = lang.logs_title
          embeddescription = 'https://docs.google.com/document/d/1td9u_n-ou-yIKHKU766T-Ue4EdJGYThjcl-MRxRUA5E/edit?usp=sharing'
        elseif string.lower(mt[2]) == "laureladams" and wj.ws >= 701 then
          embedtitle = lang.emaillogs_title
          embeddescription = "https://docs.google.com/document/d/1_dXPtCVsvDOL_XHpQ6CzX8A2KcLtymPERV3MSEJ5eZo/edit?usp=sharing"
          if wj.ws == 701 then wj.ws = 702 end
        elseif string.lower(mt[2]) == "upgrade" then
          if uj.tokens > 0 then
            if not uj.skipprompts then
              ynbuttons(message, {
                color = 0x85c5ff,
                title = lang.using_terminal_upgrade,
                description = lang.upgrade_prompt_1 .. uj.tokens .. lang.upgrade_prompt_2,
                image = {
                  url = "https://cdn.discordapp.com/attachments/829197797789532181/838894186472275988/terminal5.png"
                },
                footer = {
                  text =  message.author.name,
                  icon_url = message.author.avatarURL
                }
              },"usehole",{},uj.id,uj.lang)
              return
            else
              uj.tokens = uj.tokens - 1
              uj.timesused = uj.timesused and uj.timesused + 1 or 1
              uj.tokensdonated = uj.tokensdonated and uj.tokensdonated + 1 or 1
              wj.tokensdonated = wj.tokensdonated + 1
			  
              embeddescription = lang.donated_terminal_1 .. wj.tokensdonated .. lang.donated_terminal_2
              embedimage = upgradeimages[math.random(#upgradeimages)]
            end
          else
            embeddescription = lang.upgrade_no_tokens
            embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838894186472275988/terminal5.png"
          end
        elseif string.lower(mt[2]) == "pull" then
          if (wj.ws >= 804)  then
            embedtitle = lang.pull_title
            embeddescription = '`message.author.mentionString .. \" got a **\" .. KEY .. \"** card! The **\" .. KEY ..\"** card has been added to \" .. uj.pronouns[\"their\"] .. \"STORAGE. The shorthand form of this card is **\" .. newcard .. \"**.\" uj.storage.key = 1 dpf.savejson(\"savedata/\" .. message.author.id .. \".json\", uj)`'
            embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/865792363167219722/key.png"
            uj.storage.key = 1
          else
            embeddescription = lang.pull_jammed
          end
        else
          embeddescription = lang.unknown_1 .. mt[2] ..  lang.unknown_2
        end
      end
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = embedtitle,
        description = embeddescription,
        image = {
          url = embedimage
        },
        footer = {
          text =  message.author.name,
          icon_url = message.author.avatarURL
        }
      }}
      if filename then 
        message.channel:send{
          file = filename
        }
      end
    else
      found = false
    end
  end
  ----------------------------------------------------------WINDY MOUNTAINS
  if uj.room == 2 then
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/mountains.json")
    if (request == "pyrowmid" or (uj.lang ~= "en" and request == lang.request_pyrowmid))  then 
	  message.channel:send(lang.use_pyrowmid)
      uj.room = 0
	  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
	  cmd.look.run(message, {"pyrowmid"})
      --TODO: find a way to show a location's main c!look?
    elseif (request == "bridge" or (uj.lang ~= "en" and request == lang.request_bridge))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.using_bridge,
        description = lang.use_bridge,
      }}
    elseif (request == "shop" or request == "quaintshop" or request == "quaint shop" or (uj.lang ~= "en" and request == lang.request_shop_1 or request == lang.request_shop_2 or request == lang.request_shop_3 or request == lang.request_shop_4))  then 
      message.channel:send(lang.use_shop)
      uj.room = 3
	  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    elseif (request == "barrels" or (uj.lang ~= "en" and request == lang.request_barrels))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.using_barrels,
        description = lang.use_barrels,
      }}
    elseif (request == "clouds" or (uj.lang ~= "en" and request == lang.request_clouds))  then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.using_clouds,
        description = lang.use_clouds,
      }}
       
    else
      found = false
    end
  end
  if (uj.room == 3) then ----------------------------------------------------------SHOP
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/shop/pet.json", "") -- fallback when request is not shop
    if request == "shop" or (uj.lang ~= "en" and request == lang.request_shop_1 or request == lang.request_shop_2 or request == lang.request_shop_3 or request == lang.request_shop_4) then
	  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/shop/buy.json", "")
      checkforreload(time:toDays())
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local sprice
      local srequest
      local sname
      local stock
      local sindex
      local numrequest = 1
      if tonumber(mt[3]) then
        if tonumber(mt[3]) > 1 then numrequest = math.floor(mt[3]) end
      end

      if (not mt[2]) or (mt[2] == "") then
        cmd.look.run(message, mt)
        mt[2] = ""
        return
      end

      --error handling
      local sendshoperror = {
        notenough = function()
			if uj.lang == "ko" then
				message.channel:send(lang.no_tokens_1 .. sname .. lang.no_tokens_2 .. sprice .. lang.no_tokens_3)
			else
				message.channel:send(lang.no_tokens_1 .. sprice .. lang.no_tokens_2 .. sname .. lang.no_tokens_3)
			end
        end,

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
            message.channel:send(lang.nopeeking_error_1 .. mt[2] .. lang.nopeeking_error_2)
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
            message.channel:send(lang.nopeeking_error_1 .. mt[2] .. lang.nopeeking_error_2)
          else
            message.channel:send(lang.unknownrequest_1 .. mt[2] .. lang.unknownrequest_2)
          end
        end
      }

      if constexttofn(mt[2]) then
        srequest = constexttofn(mt[2])
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

        stock = sj.consumables[sindex].stock
        if stock <= 0 then
          sendshoperror["outofstock"]()
          return
        end

        if numrequest > stock then
          sendshoperror["toomanyrequested"]()
          return
        end

        sprice = sj.consumables[sindex].price * numrequest
        if uj.tokens < sprice then
          sendshoperror["notenough"]()
          return
        end

        --can buy consumable
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.buying_item_1 .. sname .. lang.buying_item_2,
          description = lang.consumable_desc .. "\n`".. consdb[srequest].description .."`\n" .. lang.consumable_buy_1 .. message.author.id .. lang.consumable_buy_2 .. numrequest .. lang.consumable_buy_3 .. sprice .. lang.consumable_buy_4 .. (sprice ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.consumable_buy_5,
        },"buy",{itemtype = "consumable",sname=sname,sprice=sprice,sindex=sindex,srequest=srequest,numrequest=numrequest}, message.author.id, uj.lang)
        return
      end

      if itemtexttofn(mt[2]) then
        srequest = itemtexttofn(mt[2])
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

        if uj.tokens < sprice then
          sendshoperror["notenough"]()
          return
        end

        --can buy item
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.buying_item_1 .. sname .. lang.buying_item_2,
          description = lang.item_desc .. "\n`".. itemdb[srequest].description .."`\n" .. lang.item_buy_1 .. message.author.id .. lang.item_buy_2 .. sprice .. lang.item_buy_3,
        },"buy",{itemtype = "item",sname=sname,sprice=sprice,sindex=sindex,srequest=srequest,numrequest=1}, message.author.id, uj.lang)
        return
      end

      if texttofn(mt[2]) then
        print("card!")
        srequest = texttofn(mt[2])
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

        sprice = sj.cards[sindex].price * numrequest
        if uj.tokens< sprice then
          sendshoperror["notenough"]()
          return
        end

        --can buy card
        ynbuttons(message,{
          color = 0x85c5ff,
          title = lang.buying_card_1 .. sname .. lang.buying_card_2,
          description = lang.card_desc .. "\n`".. cdb[srequest].description .."`\n" .. lang.card_buy_1 .. message.author.id .. lang.card_buy_2 .. numrequest .. lang.card_buy_3 .. sprice .. lang.card_buy_4 .. (sprice ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.card_buy_5,
        },"buy",{itemtype = "card",sname=sname,sprice=sprice,sindex=sindex,srequest=srequest,numrequest=numrequest}, message.author.id, uj.lang)
        return
      end

      -- for c!shop -s
      if mt[2] == "-s" then
        cmd.look.run(message, { "shop -s" }) 
      elseif mt[2] == "-season" then
        cmd.look.run(message, { "shop -season"})
      else
        sendshoperror["unknownrequest"]()
      end
      return
    elseif request == "wolf" or (uj.lang ~= "en" and request == lang.request_wolf) then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.petting_wolf,
        description = lang.petted_wolf,
        image = {url = "https://cdn.discordapp.com/attachments/829197797789532181/882289357128618034/petwolf.gif"}
      }}
    elseif request == "ghost" or (uj.lang ~= "en" and request == lang.request_ghost) then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.petting_ghost,
        description = lang.petted_ghost
      }}
    elseif request == "photo" or request == "dog" or (uj.lang ~= "en" and request == lang.request_photo or request == lang.request_dog) then
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = lang.petting_dog,
        description = lang.petted_dog,
        image = {url = "https://cdn.discordapp.com/attachments/829197797789532181/882287705638203443/okamii_triangle_frame_4.png"}
      }}
    else
      found = false
    end
  end
  if (not found) and (not bypass) then ----------------------------------NON-ROOM ITEMS GO HERE!-------------------------------------------------
    local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/nonroom.json","")
    if request == "token" or (uj.lang ~= "en" and request == lang.request_token) then
      if uj.tokens > 0 then
        message.channel:send(lang.tokenflip_1 .. (math.random(2) == 1 and lang.token_heads or lang.token_tails) .. lang.tokenflip_2)
      else
        message.channel:send(lang.no_tokens)
      end
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif constexttofn(request) then
      print("using consumable")
      if not uj.consumables then uj.consumables = {} end
      request = constexttofn(request)
      if uj.consumables[request] then
        if not uj.skipprompts then
          ynbuttons(message,{
            color = 0x85c5ff,
            title = lang.using_1 .. consdb[request].name .. lang.using_2,
            description = lang.use_confirm_1 .. consdb[request].name .. lang.use_confirm_2,
          },"useconsumable",{crequest=request,mt=mt},uj.id,uj.lang)
          return
        else
          local fn = request
          if consdb[request].command then
            request = consdb[request].command
          end
          cmdcons[request].run(uj, "savedata/" .. message.author.id .. ".json", message, mt, nil , fn)
          return
        end
      else
        message.channel:send(lang.donthave_1 .. consdb[request].name .. lang.donthave_2)
      end
      
    else
      message.channel:send(lang.unknown_1 .. mt[1] .. lang.unknown_2)
    end
  end
  dpf.savejson("savedata/worldsave.json", wj)
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
