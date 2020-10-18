local discordia = require('discordia')
local client = discordia.Client()
local prefix = "c!"
local privatestuff = require('privatestuff')



json = require('libs/json')
cj =  io.open("cards.json", "r")
cdata = json.decode(cj:read("*a"))
--generate pull table
ptable = {}
for i,v in ipairs(cdata.groups) do
  for w,x in ipairs(v.cards) do
    print(x.name.. "loaded")
    for y=1,(cdata.basemult*v.basechance*x.chance) do
      table.insert(ptable,x.name)
    end
  end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == prefix..'ping' then
		message.channel:send('pong')
    print("someone did !ping")
	end
	if message.content == prefix..'pull' then
		--message.channel:send('haha wowie! discord user '.. message.member.mentionString .. ' whos discord ID happens to be ' .. message.member.user.id ..' you got a card good job my broski')
    print("someone did !pull")
    message.channel:send('Pulling card...')
    local newcard = ptable[math.random(#ptable)]
    message.channel:send('Woah! '.. message.member.mentionString ..' got a **'.. newcard ..'!** The **'.. newcard ..'** has been added to their inventory.')

    
	end
end)

client:run(privatestuff.botid)