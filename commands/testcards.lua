local command = {}
function command.run(message, mt)
  if botdebug then
    message.channel:send('ok, testing. There are '.. table.count(cdb) ..' cards in the database.')
    print(message.author.name .. " did !testcards")
    for i,v in pairs(cdb) do
      local emb = v.embed or ""
	  if type(emb) == 'table' then
		emb = 'shade embed exception'
	  end
      message.channel:send {
        content = 'TESTCARDS: '.. v.name .. ' smells like ' .. cdb[v.filename].smell .. ', ' .. cdb[v.filename].description .. emb
      }
      message.channel:send{
        file = getcardthumb(v.filename)
      }
    end
  else
    message.channel:send('Not so fast, buckaroo.')
  end
end
return command
  