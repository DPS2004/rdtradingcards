local command = {}
function command.run(message, mt)
local time = sw:getTime()
  print(message.author.name .. " did !pray")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local cooldown = 3
  if uj.equipped == "faithfulnecklace" then
    cooldown = 2.5
  end
  if true then --ssss override

    if not uj.lastprayer then
      uj.lastprayer = -3
    end
    if uj.lastprayer + cooldown <= time:toDays()then
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
      message.channel:send('Please wait ' .. math.ceil((uj.lastprayer + cooldown - time:toDays())*10)/10 .. ' days before praying again.')
    end
  end
end
return command
  