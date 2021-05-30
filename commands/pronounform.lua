local command = {}
function command.run(message, mt)
  message.channel:send('https://forms.gle/nG57xLc8DPHc5G8m9')
  print(message.author.name .. " did !pronounform")
end
return command
