local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !generategive")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    if #mt == 2 or #mt == 3 then
      local uj2f = usernametojson(mt[1])
      if uj2f then
        local uj2 = dpf.loadjson(uj2f,defaultjson)
  
        local curfilename = texttofn(mt[2])
        if curfilename ~= nil then
          local numcards = 1
          if tonumber(mt[3]) then
            if tonumber(mt[3]) > 1 then
              numcards = math.floor(mt[3])
            end
          end
          if uj2.inventory[curfilename] == nil then
            uj2.inventory[curfilename] = numcards
          else
            uj2.inventory[curfilename] = uj2.inventory[curfilename] + numcards
          end
          dpf.savejson(uj2f,uj2)
          print("saved user2 json with new card")
          local isplural = ""
          if numcards ~= 1 then
            isplural = "s"
          end
          message.channel:send {
            content = 'You have given ' .. numcards .. ' **' .. fntoname(curfilename) .. '** card' .. isplural .. ' to <@' .. uj2.id .. '> .'
          }

        else
          message.channel:send("Sorry, but I could not find the " .. mt[2] .. " card in the database. Make sure that you spelled it right!")
        end

      else
        message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      end
    else
      message.channel:send("Sorry, but the c!generategive command expects 2 or 3 arguments. Please see c!help for more details.")
    end
  else
    message.channel:send("haha no, nice try")
  end
  
end
return command
  