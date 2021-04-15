local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pray")
  if message.guild then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local cooldown = 3
    if uj.equipped == "faithfulnecklace" then
      cooldown = 2.5
    end
    if true then --ssss override
  
      if not uj.lastprayer then
        uj.lastprayer = -3
      end
      if uj.lastprayer + cooldown <= time:toDays() then
        message.channel:send('The Card Gods have listened to your plight. A **Token** appears in your pocket.')
        
        
        local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
        if uj.tokens == nil then
          uj.tokens = 1
        else
          uj.tokens = uj.tokens + 1
        end
        if uj.timesprayed == nil then
          uj.timesprayed = 1
        else
          uj.timesprayed = uj.timesprayed + 1
        end
        uj.id = message.author.id
        uj.lastprayer = time:toDays()
        dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
      else
        --extremely jank implementation, please make this cleaner if possible
        local minutesleft = math.ceil(uj.lastprayer * 1440 - time:toMinutes() + cooldown * 1440)
        local durationtext = ""
        if math.floor(minutesleft / 60) > 0 then
          durationtext = math.floor(minutesleft / 60) .. " hour"
          if math.floor(minutesleft / 60) ~= 1 then
            durationtext = durationtext .. "s"
          end
        end
        if minutesleft % 60 > 0 then
          if durationtext ~= "" then
            durationtext = durationtext .. " and "
          end
          durationtext = durationtext .. minutesleft % 60 .. " minute"
          if minutesleft % 60 ~= 1 then
            durationtext = durationtext .. "s"
          end
        end
        message.channel:send('Please wait ' .. durationtext .. ' before praying again.')
      end
    end
  else
    message.channel:send("Sorry, but you cannot pray in DMs!")
  end
end
return command
  