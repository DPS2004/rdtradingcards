local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !give")
  if #mt == 2 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local uj2f = usernametojson(mt[1])
    if uj2f then
      local uj2 = dpf.loadjson(uj2f,defaultjson)
      if uj2.id ~= message.author.id then
        local curfilename = texttofn(mt[2])
        if curfilename ~= nil then
          if uj.inventory[curfilename] ~= nil then
            print(uj.inventory[curfilename] .. "before")
            uj.inventory[curfilename] = uj.inventory[curfilename] - 1
            print(uj.inventory[curfilename] .. "after")
            if uj.inventory[curfilename] == 0 then
              uj.inventory[curfilename] = nil
            end
            dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
            print("user had card, removed from original user")
            if uj2.inventory[curfilename] == nil then
              uj2.inventory[curfilename] = 1
            else
              uj2.inventory[curfilename] = uj2.inventory[curfilename] + 1
            end
            dpf.savejson(uj2f,uj2)
            print("saved user2 json with new card")
            
            message.channel:send {
              content = 'You have gifted your **' .. fntoname(curfilename) .. '** card to @' .. uj2.name .. ' .'
            }
          else
            print("user doesnt have card")
            message.channel:send("Sorry, but you don't have the **" .. mt[2] .. "** card in your inventory.")
          end
        else
          message.channel:send("Sorry, but I could not find the " .. mt[2] .. " card in the database. Make sure that you spelled it right!")
        end
      else
        message.channel:send("Sorry, but you cannot give something to yourself!")
      end
    else
      message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    end
  else
    message.channel:send("Sorry, but the c!give command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  