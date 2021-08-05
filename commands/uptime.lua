local command = {}
function command.run(message, mt)
  local time = sw:getTime()
  message.channel:send('This bot has been running for ' .. math.floor(time:toMinutes()) .. ' minutes.')
  print(message.author.name .. " did !uptime")
end
return command
  