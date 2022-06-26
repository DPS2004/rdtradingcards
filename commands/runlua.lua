local command = {}
function command.run(message, mt)
  print("c!runlua!!!!!")
  local cmember = message.guild:getMember(message.author)
  print(mt[1])
  if cmember:hasRole(privatestuff.modroleid) then
    message.channel:send('Ok, running!')
    local request = table.concat(mt, "/")

    local status, err = pcall(function()
      local rfunc = assert(load(request))
      rfunc()
    end)

    if not status then
      message.channel:send('Oops! An error has occured. Error message: ```' .. err .. '```')
    else
      message.channel:send('Success!')
    end
  else
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  