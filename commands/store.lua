local command = {}
function command.run(message, mt)

  if #mt == 1 or #mt == 2 then
    print(message.author.name .. " did !store")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.author.id .. ".json")

    local uj = dpf.loadjson(ujf, defaultjson)
    
    if not uj.items then
      uj.items = {nothing=true}
      uj.equipped = "nothing"
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    end
    
    local item1 = texttofn(mt[1])
    if item1 then
      if uj.inventory[item1] then
        print("success!!!!!")
        local numcards = 1
        if tonumber(mt[2]) then
          if tonumber(mt[2]) > 1 then
            numcards = math.floor(mt[2])
          end
        end
        if uj.inventory[item1] >= numcards then
          if not uj.skipprompts then
            local newmessage = message.channel:send("<@" .. uj.id .. ">, do you want to put your " .. numcards .. " **" .. fntoname(item1) .. "** into storage? This cannot be undone. React to this post with :white_check_mark: to confirm and :x: to deny.")
            addreacts(newmessage)
            local tf = dpf.loadjson("savedata/events.json",{})
            tf[newmessage.id] ={numcards = numcards, ujf = ujf, item1=item1,etype = "store",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
            dpf.savejson("savedata/events.json",tf)
            
          else
            uj.inventory[item1] = uj.inventory[item1] - numcards
            if uj.inventory[item1] == 0 then
              uj.inventory[item1] = nil
            end     
            print("giving item1 to user1 storage")
            if uj.storage[item1] == nil then
              uj.storage[item1] = numcards
            else
              uj.storage[item1] = uj.storage[item1] + numcards
            end
            if uj.timesstored == nil then
              uj.timesstored = numcards
            else
              uj.timesstored = uj.timesstored + numcards
            end
            local isplural = ""
            if numcards ~= 1 then
              isplural = "s"
            end
            message.channel:send("<@" .. uj.id .. "> successfully put their " .. numcards .. " **" .. fntoname(item1) .. "** card" .. isplural .. " into storage.")
            dpf.savejson(ujf,uj)
            cmd.checkcollectors.run(message,mt)
            cmd.checkmedals.run(message,mt)
          end
        else
          message.channel:send("Sorry, but you do not have enough **" .. fntoname(item1) .. "** cards in your inventory.")
        end
      else
        if nopeeking then
          message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
        else
          message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
        end
      end
            
    else
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
      end
    end
          
  else
    message.channel:send("Sorry, but the c!store command expects 1 or 2 arguments. Please see c!help for more details.")
  end
end
return command
  