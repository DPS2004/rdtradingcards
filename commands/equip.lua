local command = {}
function command.run(message, mt)
  local time = sw:getTime()
  if #mt == 1 then
    print(message.author.name .. " did !equip")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.author.id .. ".json")

    local uj = dpf.loadjson(ujf, defaultjson)
	local lang = dpf.loadjson("langs/" .. uj.lang .. "/equip.json", "")
    if not uj.equipped then
      uj.equipped = "nothing"
    end
    if not uj.items then
      uj.items = {nothing=true}
      uj.equipped = "nothing"
      
    end
    
    if not uj.lastequip then
      uj.lastequip = -24
    end
    
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)

    if uj.lastequip + 6 > time:toHours() then
      --extremely jank implementation, please make this cleaner if possible
      local minutesleft = math.ceil(uj.lastequip * 60 - time:toMinutes() + 360.00)
      local durationtext = ""
      if math.floor(minutesleft / 60) > 0 then
        durationtext = math.floor(minutesleft / 60) .. lang.time_hour
        if lang.needs_plural_s == true then
		  if math.floor(minutesleft / 60) ~= 1 then
            durationtext = durationtext .. lang.time_plural_s
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
            durationtext = durationtext .. time_plural_s
          end
		end
      end
      message.channel:send(lang.wait_message_1 .. durationtext .. lang.wait_message_2)
      return
    end

    local request = mt[1]
    local curfilename = itemtexttofn(request)
    
    if not curfilename then
      if nopeeking then
        message.channel:send(lang.nopeeking_1 .. request .. lang.nopeeking_2)
      else
        message.channel:send(lang.nodatabase_1 .. request .. lang.nodatabase_2)
      end
      return
    end

    if not uj.items[curfilename] then
      if nopeeking then
        message.channel:send(lang.nopeeking_1 .. request .. lang.nopeeking_2)
      else
        message.channel:send(lang.donthave_1 .. itemdb[curfilename].name .. lang.donthave_2)
      end
      return
    end

    if uj.equipped == curfilename then
      message.channel:send(lang.already_equipped_1 .. itemdb[curfilename].name .. lang.already_equipped_2)
      return
    end

    --woo hoo
    print(uj.equipped)
    if not uj.skipprompts then
      ynbuttons(message,lang.prompt_1 .. itemdb[uj.equipped].name .. lang.prompt_2 .. itemdb[curfilename].name .. lang.prompt_3,"equip",{newequip = curfilename}, uj.id, uj.lang)
    else
      uj.equipped = curfilename
	  if uj.lang == "ko" then
	    message.channel:send("<@" .. uj.id .. "> " .. lang.equipped_1 .. itemdb[curfilename].name .. lang.equipped_2 .. lang.equipped_3)
      else
	    message.channel:send("<@" .. uj.id .. "> " .. lang.equipped_1 .. itemdb[curfilename].name .. lang.equipped_2 ..uj.pronouns["their"].. lang.equipped_3)
	  end
	  uj.lastequip = time:toHours()
	  
	  if uj.sodapt and uj.sodapt.equip then
        uj.lastequip = uj.lastequip + uj.sodapt.equip
        uj.sodapt.equip = nil
        if uj.sodapt == {} then uj.sodapt = nil end
      end
	  
      dpf.savejson(ujf,uj)
      print('saved equipped as ' .. curfilename)
    end
          
  else
    message.channel:send(lang.no_arguments)
  end
end
return command
  
