local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !givetoken")
  if message.guild then
    if #mt == 1 or #mt == 2  then
      local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
      local uj2f = usernametojson(mt[1])
      if uj2f then
        local uj2 = dpf.loadjson(uj2f,defaultjson)
        if uj2.id ~= message.author.id then
          local numtokens = 1
          if tonumber(mt[2]) then
            if tonumber(mt[2]) > 1 then
              numtokens = math.floor(tonumber(mt[2]))
            end
          end
          if not uj.tokens then
            uj.tokens = 0
          end
          if uj.tokens >= numtokens then
            uj.tokens = uj.tokens - numtokens
            if not uj2.tokens then
              uj2.tokens = 0
            end
            uj2.tokens = uj2.tokens + numtokens
            
            if uj.timestokengiven == nil then
              uj.timestokengiven = numtokens
            else
              uj.timestokengiven = uj.timestokengiven + numtokens
            end
            if uj2.timestokenreceived == nil then
              uj2.timestokenreceived = numtokens
            else
              uj2.timestokenreceived = uj2.timestokenreceived + numtokens
            end
            dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
            dpf.savejson(uj2f,uj2)
            local isplural = ""
            if numtokens ~= 1 then
              isplural = "s"
            end
            message.channel:send {
              content = 'You have gifted ' .. numtokens .. ' **Token' .. isplural ..'** to <@' .. uj2.id .. '>.'
            }
          else
            message.channel:send("Sorry, but you do not have enough tokens to do that!")
          end
        else
          message.channel:send("Sorry, but you cannot give tokens to yourself!")
        end
      else
        message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      end
    else
      message.channel:send("Sorry, but the c!givetoken command expects 1 or 2 arguments. Please see c!help for more details.")
    end
  else
    message.channel:send("Sorry, but you cannot give tokens in DMs!")
  end
end
return command
  