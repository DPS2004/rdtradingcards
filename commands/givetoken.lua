local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !givetoken")
  if #mt == 1 then
    mt[2] = 1
  end
  if #mt == 2  then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local uj2f = usernametojson(mt[1])
    if uj2f then
      local uj2 = dpf.loadjson(uj2f,defaultjson)
      if uj2.id ~= message.author.id then
        if not uj.tokens then
          uj.tokens = 0
        end
        
        if uj.tokens >= mt[2] then
          uj.tokens = uj.tokens - mt[2]
          if not uj2.tokens then
            uj2.tokens = 0
          end
          uj2.tokens = uj2.tokens + mt[2]
          
          if uj.timestokengiven == nil then
            uj.timestokengiven = mt[2]
          else
            uj.timestokengiven = uj.timestokengiven + mt[2]
          end
          if uj2.timestokenreceived == nil then
            uj2.timestokenreceived = mt[2]
          else
            uj2.timestokenreceived = uj2.timestokenreceived + mt[2]
          end
          
          
          
          
          dpf.savejson(ujf,uj)
          dpf.savejson(uj2f,uj2)
          local isplural = ""
          if mt[2] ~= 1 then
            isplural = "s"
          end
          message.channel:send {
            content = 'You have gifted ' .. numcards .. ' **Token' .. isplural ..'** to <@' .. uj2.id .. '>.'
          }
          
          
        else
          message.channel:send("Sorry, but you do not have enough tokens to do that!")
        end
        
      else
        message.channel:send("Sorry, but you cannot give something to yourself!")
      end
    else
      message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    end
  else
    message.channel:send("Sorry, but the c!give command expects 1 or 2 arguments. Please see c!help for more details.")
  end
end
return command
  