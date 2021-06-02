local command = {}
function command.run(message, mt)
  message.channel:send('Your pronouns not on the RDCard bot? Put your pronouns in this google form and we will look over them!\n**https://forms.gle/nG57xLc8DPHc5G8m9**')
  print(message.author.name .. " did !pronounform")
end
return command
