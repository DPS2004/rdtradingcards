local command = {}
function command.run(message, mt)
  if debug then
    message.channel:send('ok, testing. There are '.. #cdb ..'cards in the database.')
    print(message.author.name .. " did !testcards")
    for i,v in ipairs(cdb) do
      message.channel:send {
        content = 'TESTCARDS: '.. v.name .. ' smells like ' getcardsmell(v.filename)
      }
      message.channel:send {
        file = "card_images/" .. v.filename .. ".png"
      }
    end
  else
    message.channel:send('Not so fast, buckaroo.')
  end
end
return command
  