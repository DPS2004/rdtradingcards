local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson(filename, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/uptime.json", "")
  local time = sw:getTime()
  message.channel:send(lang.uptime_message_1 .. math.floor(time:toMinutes()) .. lang.uptime_message_2)
  print(message.author.name .. " did !uptime")
end
return command
  