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
		message.channel:send('haha wowie! discord user '.. message.member.mentionString .. ' whos discord ID happens to be ' .. message.member.user.id ..' you got a card good job my broski')
    if message.member.user.id == '300050030923087872' then
      message.channel:send('also since you are huantian (i think?) h e r e  a r e  s  o  m  e   e   x   t   r   a        s    p    a    c    e    s')
    end
    print("someone did !pull")
	end
end)

client:run(privatestuff.botid)