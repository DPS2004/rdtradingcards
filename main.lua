local discordia = require('discordia')
local client = discordia.Client()
local prefix = "c!"
local privatestuff = require('privatestuff')
json = require('libs/json')
dpf = require('libs/dpf')


cj =  io.open("cards.json", "r")



cdata = json.decode(cj:read("*a"))
cj:close()
--generate pull table
ptable = {}
for i,v in ipairs(cdata.groups) do
  for w,x in ipairs(v.cards) do
    print(x.name.. " loaded")
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
    message.channel:send {
        content = 'Woah! '.. message.member.mentionString ..' got a **'.. newcard ..'!** The **'.. newcard ..'** card has been added to their inventory.',
        file = "card_images/" .. newcard .. ".png"
      }

    uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",{inventory={}})
    if uj.inventory[newcard] == nil then
      uj.inventory[newcard] = 1
    else
      uj.inventory[newcard] = uj.inventory[newcard] + 1
    end
    uj.name = message.member.name
    print("number of cards is " .. uj.inventory[newcard])
    dpf.savejson("savedata/" .. message.member.user.id .. ".json",uj)

    
	end
	if message.content == prefix..'inventory' then
    print("someone did !inventory")
    uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",{inventory={}})
    local invstring = ''
    for k,v in pairs(uj.inventory) do
      invstring = invstring .. "**" .. k .. "** x" .. v .. "\n"
    end
      
    message.channel:send("Your inventory contains:\n" .. invstring)
	end
  if message.content:find(prefix.. 'show') then
    print("someone did !show")
    uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",{inventory={}})
    local msg = {}
    for s in message.content:gmatch("%S+") do
      table.insert(msg, s)
    end
    if #msg == 2 then
      if uj.inventory[msg[#msg]] then
        print("user has card")
      message.channel:send {
        content = 'Here it is! Your '.. msg[#msg] .. ' card.',
        file = "card_images/" .. msg[#msg] .. ".png"
      }
      else
        print("user doesnt have card")
        message.channel:send("Sorry, but you don't have the " .. msg[#msg] .. " card in your inventory.")
      end
    end
    
    
    
  end
  
end)

client:run(privatestuff.botid)