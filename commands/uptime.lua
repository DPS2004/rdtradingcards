command = {}
function command.run(message, mt)
  local time = sw:getTime()
  message.channel:send('this bot has been running for ' .. math.floor(time:toMinutes()) .. ' minutes.')
  print(message.member.name .. " did !uptime")
end
return command
  