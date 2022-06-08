local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !prat")
  message.channel:send('https://cdn.discordapp.com/attachments/829197797789532181/984068096190996510/prat.png')
end
return command
