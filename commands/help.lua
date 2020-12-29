
local command = {}
function command.run(message, mt)
  message.channel:send('https://docs.google.com/document/d/1Za0DCHsQ0QPZastaILzquNqDJTHtloCnZcjn6lNdbHA/edit?usp=sharing')
  print(message.author.name .. " did !help")
end
return command
  