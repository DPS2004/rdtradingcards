command = {}
function command.run(message, mt)

  if #mt == 3 then
    print(message.member.name .. " did !trade")
    local mt = string.split(string.sub(message.content, 9),"/")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.member.user.id .. ".json")
    
    local uj2f = usernametojson(mt[2])
    --print(ujf2 .. "bleh")
    print("checking if user 2 exists")
    if uj2f then
      print("check if users are different people")
      if uj2f ~= ujf then
        --check if the items exist
        print("checking if item 1 exists")
        local uj = dpf.loadjson(ujf, defaultjson)
        local uj2 = dpf.loadjson(uj2f, defaultjson)
        local item1 = texttofn(mt[1])
        if item1 then
          print("checking if item 2 exists")
          local item2 = texttofn(mt[3])
          if item2 then
            --check if items are in the players inventories
            print("checking if u1 has i1")
            if uj.inventory[item1] then
              print("checking if u2 has i2")
              if uj2.inventory[item2] then
                --BOTH ITEMS EXIST, AND ARE IN THE RIGHT PLACES.
                print("success!!!!!")
                local newmessage = message.channel:send("<@".. uj2.id ..">, <@" .. uj.id .. "> wants to trade their **" .. fntoname(item1) .. "** for your **" .. fntoname(item2) .. "**. React to this post with :white_check_mark: to accept and :x: to deny.")
                local tf = dpf.loadjson("savedata/events.json",{})
                tf[newmessage.id] ={ujf = ujf, uj2f=uj2f,item1=item1, item2=item2,etype = "trade"}
                dpf.savejson("savedata/events.json",tf)
                
                
              else
                message.channel:send("Sorry, but ".. uj2.name .. "doesn't have the **" .. fntoname(item2) .. "** card in their inventory.")
              end
              
              
              
            else
              message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
            end
            
            
            
          else
          
            message.channel:send("Sorry, but I could not find the " .. mt[3] .. " card in the database. Make sure that you spelled it right!")
          end
          
          
        else
          message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
        end
      else
        message.channel:send("Sorry, you cannot trade with yourself!")
      end
    else
      message.channel:send("Sorry, but I could not find a user named " .. mt[2] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    end
  else
    message.channel:send("Sorry, but the c!trade command expects 3 argument. Please see c!help for more details.")
  end
end
return command
  