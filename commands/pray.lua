local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pray")
  if not message.guild then
    message.channel:send("Sorry, but you cannot pray in DMs!")
    return
  end
  
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local cooldown = 23/24
  if uj.equipped == "faithfulnecklace" then
    cooldown = 20/24
  end

  if not uj.lastprayer then
    uj.lastprayer = -3
  end

  if uj.lastprayer + cooldown > time:toDays() then
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
    return
  end
  
  uj.tokens = uj.tokens and uj.tokens + 1 or 1
  uj.timesprayed = uj.timesprayed and uj.timesprayed + 1 or 1
  uj.lastprayer = time:toDays()
  
  if uj.sodapt then
    if uj.sodapt.pray then
      uj.lastprayer = uj.lastprayer + uj.sodapt.pray
      uj.sodapt.pray = nil
      if uj.sodapt == {} then
        uj.sodapt = nil
      end
    end
  end
  
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)

  message.channel:send('The Card Gods have listened to your plight. A **Token** appears in your pocket.')
  if not uj.checktoken then
    message.channel:send('You currently have ' .. uj.tokens .. ' **Token' .. (uj.tokens == 1 and "" or "s") .. '**.')
  end
end
return command
