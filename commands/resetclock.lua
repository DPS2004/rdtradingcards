command = {}
privatestuff = require('privatestuff')
json = require('libs/json')
dpf = require('libs/dpf')
utils = require('libs/utils')
  print(prefix)
function command.run(message, mt)

  if message.member:hasRole(privatestuff.modroleid) then
    for i,v in ipairs(scandir("savedata")) do
      resetclocks()
    end
    message.channel:send('All user cooldowns have been reset.')
  else
    
    message.channel:send('Sorry but only moderators can use this command!')
  end
end
return command
  