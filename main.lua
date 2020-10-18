local discordia = require('discordia')
local client = discordia.Client()
local prefix = "c!"
local privatestuff = require('privatestuff')

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == prefix..'ping' then
		message.channel:send('pong')
    print("someone did !ping")
	end
	if message.content == prefix..'pull' then
		message.channel:send('haha wowie you got a card good job my broski')
    print("someone did !ping")
	end
end)

client:run(privatestuff.botid)