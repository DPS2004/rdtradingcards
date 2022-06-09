local command = {}
function command.run(message, mt)
  local time = sw:getTime()
  if #mt == 1 then
    print(message.author.name .. " did !equip")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.author.id .. ".json")

    local uj = dpf.loadjson(ujf, defaultjson)
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
        durationtext = math.floor(minutesleft / 60) .. " hour"
        if math.floor(minutesleft / 60) ~= 1 then
          durationtext = durationtext .. "s"
        end
      end
      if minutesleft % 60 > 0 then
        if durationtext ~= "" then
          durationtext = durationtext .. " and "
        end
        durationtext = durationtext .. minutesleft % 60 .. " minute"
        if minutesleft % 60 ~= 1 then
          durationtext = durationtext .. "s"
        end
      end
      message.channel:send('Please wait ' .. durationtext .. ' before changing your equipped item. ')
      return
    end

    local request = mt[1]
    local curfilename = itemtexttofn(request)
    
    if not curfilename then
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. request .. " item in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but I could not find the " .. request .. " item in the database. Make sure that you spelled it right!")
      end
      return
    end

    if not uj.items[curfilename] then
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. request .. " item in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but you don't have the **" .. itemdb[curfilename].name .. "** item.")
      end
      return
    end

    if uj.equipped == curfilename then
      message.channel:send("You already have the **" .. itemdb[curfilename].name .. "** item equipped!")
      return
    end

    --woo hoo
    print(uj.equipped)
    if not uj.skipprompts then
      ynbuttons(message,"Would you like to change your equipped item from **" .. itemdb[uj.equipped].name .. "** to **" .. itemdb[curfilename].name .. "**? This can be done once every 6 hours.","equip",{newequip = curfilename})
    else
      uj.equipped = curfilename
      message.channel:send("<@" .. uj.id .. "> successfully set **" .. itemdb[curfilename].name .. "** as "..uj.pronouns["their"].." equipped item.")
      uj.lastequip = time:toHours()
      dpf.savejson(ujf,uj)
      print('saved equipped as ' .. curfilename)

      if uj.sodapt and uj.sodapt.equip then
        uj.lastequip = uj.lastequip + uj.sodapt.equip
        uj.sodapt.equip = nil
        if uj.sodapt == {} then uj.sodapt = nil end
      end
    end
          
  else
    message.channel:send("Sorry, but the c!equip command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  
