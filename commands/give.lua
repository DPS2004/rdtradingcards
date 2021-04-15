local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !give")
  if message.guild then
    if #mt == 2 or #mt == 3 then
      if string.lower(mt[2]) == "token" then
        cmd.givetoken.run(message,{mt[1],mt[3]})
      else
        local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
        local uj2f = usernametojson(mt[1])
        if uj2f then
          local uj2 = dpf.loadjson(uj2f,defaultjson)
          if uj2.id ~= message.author.id then
            local numcards = 1
            if tonumber(mt[3]) then
              if tonumber(mt[3]) > 1 then
                numcards = math.floor(mt[3])
              end
            end
            local curfilename = texttofn(mt[2])
            if curfilename then
              if uj.inventory[curfilename] then
                if uj.inventory[curfilename] >= numcards then
                  print(uj.inventory[curfilename] .. "before")
                  uj.inventory[curfilename] = uj.inventory[curfilename] - numcards
                  print(uj.inventory[curfilename] .. "after")
                  if uj.inventory[curfilename] == 0 then
                    uj.inventory[curfilename] = nil
                  end
                  if uj.timescardgiven == nil then
                    uj.timescardgiven = numcards
                  else
                    uj.timescardgiven = uj.timescardgiven + numcards
                  end
                  if uj2.timescardreceived == nil then
                    uj2.timescardreceived = numcards
                  else
                    uj2.timescardreceived = uj2.timescardreceived + numcards
                  end
                  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
                  print("user had card, removed from original user")
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
                    content = 'You have gifted ' .. numcards .. ' **' .. fntoname(curfilename) .. '** card' .. isplural ..' to <@' .. uj2.id .. '>.'
                  }
                else
                  print("user doesn't have enough cards")
                  message.channel:send("Sorry, but you do not have enough **" .. fntoname(curfilename) .. "** cards in your inventory.")
                end
              else
                print("user doesnt have card")
                if nopeeking then
                  message.channel:send("Sorry, but I either could not find the " .. mt[2] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
                else
                  message.channel:send("Sorry, but you don't have the **" .. fntoname(mt[2]) .. "** card in your inventory.")
                end
              end
            else
              if nopeeking then
                message.channel:send("Sorry, but I either could not find the " .. mt[2] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
              else
                message.channel:send("Sorry, but I could not find the " .. mt[2] .. " card in the database. Make sure that you spelled it right!")
              end
            end
          else
            message.channel:send("Sorry, but you cannot give something to yourself!")
          end
        else
          message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
        end
      end
    else
      message.channel:send("Sorry, but the c!give command expects 2 or 3 arguments. Please see c!help for more details.")
    end
  else
    message.channel:send("Sorry, but you cannot give cards in DMs!")
  end
end
return command
  