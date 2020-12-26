command = {}
function command.run(message, mt)

  if #mt == 1 then
    print(message.author.name .. " did !store")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.author.id .. ".json")

    local uj = dpf.loadjson(ujf, defaultjson)
    local item1 = texttofn(mt[1])
    if item1 then
      if uj.inventory[item1] then
        print("success!!!!!")
        local newmessage = message.channel:send("<@" .. uj.id .. ">, do you want to put your **" .. fntoname(item1) .. "** into storage? This cannot be undone. React to this post with :white_check_mark: to confirm and :x: to deny.")
        addreacts(newmessage)
        local tf = dpf.loadjson("savedata/events.json",{})
        tf[newmessage.id] ={ujf = ujf, item1=item1,etype = "store"}
        dpf.savejson("savedata/events.json",tf)
      else
        message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
      end
            
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
          
  else
    message.channel:send("Sorry, but the c!store command expects 1 argument. Please see c!help for more details.")
  end
  cmd.checkcollectors.run(message,mt)
end
return command
  