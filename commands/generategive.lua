local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !generategive")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    if #mt == 2 then
      local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
      local uj2f = usernametojson(mt[1])
      if uj2f then
        local uj2 = dpf.loadjson(uj2f,defaultjson)
  
        local curfilename = texttofn(mt[2])
        if curfilename ~= nil then

          if uj2.inventory[curfilename] == nil then
            uj2.inventory[curfilename] = 1
          else
            uj2.inventory[curfilename] = uj2.inventory[curfilename] + 1
          end
          dpf.savejson(uj2f,uj2)
          print("saved user2 json with new card")
          
          message.channel:send {
            content = 'You have given **' .. fntoname(curfilename) .. '** card to <@' .. uj2.id .. '> .'
          }

        else
          message.channel:send("Sorry, but I could not find the " .. mt[2] .. " card in the database. Make sure that you spelled it right!")
        end

      else
        message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      end
    else
      message.channel:send("Sorry, but the c!generategive command expects 2 arguments. Please see c!help for more details.")
    end
  else
    message.channel:send("haha no, nice try")
  end
  
end
return command
  