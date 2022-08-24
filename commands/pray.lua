local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pray")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/pray.json", "")
  
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end
  
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
    message.channel:send(lang.wait_message_1 .. durationtext .. lang.wait_message_2)
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

  message.channel:send(lang.prayed_message)
  if not uj.togglechecktoken then
    message.channel:send(lang.checktoken_1 .. uj.tokens .. lang.checktoken_2 .. (uj.tokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.checktoken_3)
  end
end
return command
