local command = {}
function command.run(message, mt)
  local time = sw:getTime()
  if #mt == 1 then
    print(message.author.name .. " did !showitem")
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
    if uj.lastequip + 24 <= time:toHours()then
      local request = mt[1]
      local curfilename = itemtexttofn(request)
      if curfilename then
        if uj.items[curfilename] then
          --woo hoo
          print(uj.equipped)
          if uj.equipped ~= "brokenmouse" then
            
            local newmessage = message.channel:send("Would you like to changed your equipped item from **" .. itemfntoname(uj.equipped) .. "** to **" .. itemfntoname(curfilename) .. "**? This can be done once every 24 hours.")
            addreacts(newmessage)
            local tf = dpf.loadjson("savedata/events.json",{})
            tf[newmessage.id] ={ujf = ujf, newequip = curfilename ,etype = "equip",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
            dpf.savejson("savedata/events.json",tf)
          else
            uj.equipped = curfilename
            message.channel:send("<@" .. uj.id .. "> successfully set **" .. itemfntoname(curfilename) .. "** as their equipped item.")
            uj.lastequip = time:toHours()
            dpf.savejson(ujf,uj)
            print('saved equipped as ' .. curfilename)
          end
        else
          if nopeeking then
            message.channel:send("Sorry, but I either could not find the " .. request .. " item in the database, or you do not have it. Make sure that you spelled it right!")
          else
            message.channel:send("Sorry, but you don't have the **" .. itemfntoname(curfilename) .. "** item.")
          end
        end
        
      else
        if nopeeking then
          message.channel:send("Sorry, but I either could not find the " .. request .. " item in the database, or you do not have it. Make sure that you spelled it right!")
        else
          message.channel:send("Sorry, but I could not find the " .. request .. " item in the database. Make sure that you spelled it right!")
        end
      end
    else
      message.channel:send('Please wait ' .. math.ceil((uj.lastequip + 24.00 - time:toHours())*10)/10 .. ' hours before changing your equipped item.')
    end
          
  else
    message.channel:send("Sorry, but the c!showitem command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  