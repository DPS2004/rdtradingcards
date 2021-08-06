
local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !help")
  message.channel:send('https://docs.google.com/document/d/1Za0DCHsQ0QPZastaILzquNqDJTHtloCnZcjn6lNdbHA/edit?usp=sharing')
end
return command
  