local command = {}
function command.run(message, mt)

  if #mt == 1 then
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
        if not uj.equipped == "brokenmouse" then
          local newmessage = message.channel:send("<@" .. uj.id .. ">, do you want to put your **" .. fntoname(item1) .. "** into storage? This cannot be undone. React to this post with :white_check_mark: to confirm and :x: to deny.")
          addreacts(newmessage)
          local tf = dpf.loadjson("savedata/events.json",{})
          tf[newmessage.id] ={ujf = ujf, item1=item1,etype = "store",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
          dpf.savejson("savedata/events.json",tf)
          
        else
          
          uj.inventory[item1] = uj.inventory[item1] - 1
          if uj.inventory[item1] == 0 then
            uj.inventory[item1] = nil
          end     
          print("giving item1 to user1 storage")
          if uj.storage[item1] == nil then
            uj.storage[item1] = 1
          else
            uj.storage[item1] = uj.storage[item1] + 1
          end
          
          
          message.channel:send("<@" .. uj.id .. "> successfully put their **" .. fntoname(item1) .. "** card in storage.")
          dpf.savejson(ujf,uj)
        end
      else
        message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
      end
            
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
          
  else
    message.channel:send("Sorry, but the c!store command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  