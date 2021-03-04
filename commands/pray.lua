local command = {}
function command.run(message, mt)
local time = sw:getTime()
  --message.channel:send('haha wowie! discord user '.. message.author.mentionString .. ' whos discord ID happens to be ' .. message.author.id ..' you got a card good job my broski')
  print(message.author.name .. " did !pull")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if true then --ssss override

    if not uj.lastprayer then
      uj.lastprayer = -7
    end
    if uj.lastprayer + 7 <= time:toDays()then
      message.channel:send('The card gods have listened to your plight. A token appears in your pocket.')
      
      
      local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
      if uj.tokens == nil then
        uj.tokens = 1
      else
        uj.tokens = uj.tokens + 1
      end
      uj.id = message.author.id
      uj.lastprayer = time:toDays()
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    else
      message.channel:send('Please wait ' .. math.ceil((uj.lastprayer + 7.00 - time:toDays())*10)/10 .. ' days before praying again.')
    end
  end
end
return command
  