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
cdb = {}
for i,v in ipairs(cdata.groups) do
  for w,x in ipairs(v.cards) do
    
    for y=1,(cdata.basemult*v.basechance*x.chance) do
      table.insert(ptable,x.filename)
    end
    table.insert(cdb,x)
    print(x.name.. " loaded!")
  end
end


function fntoname(x)
  print("finding "..x)
  for i,v in ipairs(cdb) do
    if string.lower(v.filename) == string.lower(x) then
      local match = v.name
      print(x.." = "..v.name)
      return v.name
    end
  end
  
end

function nametofn(x)
  for i,v in ipairs(cdb) do
    if string.lower(v.name) == string.lower(x) then
      local match = v.filename
      return v.filename
    end
  end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == prefix..'ping' then
		message.channel:send('pong')
    print(message.member.name .. " did !ping")
	end
	if message.content == prefix..'pull' then
		--message.channel:send('haha wowie! discord user '.. message.member.mentionString .. ' whos discord ID happens to be ' .. message.member.user.id ..' you got a card good job my broski')
    print(message.member.name .. " did !pull")
    message.channel:send('Pulling card...')
    local newcard = ptable[math.random(#ptable)]
    ncn = fntoname(newcard)
    print(ncn)
    message.channel:send {
        content = 'Woah! '.. message.member.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their inventory.',
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
    print(message.member.name .. " did !inventory")
    uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",{inventory={}})
    local invstring = ''
    for k,v in pairs(uj.inventory) do
      invstring = invstring .. "**" .. fntoname(k) .. "** x" .. v .. "\n"
    end
      
    message.channel:send("Your inventory contains:\n" .. invstring)
	end
  if message.content:find(prefix.. 'show ') then
    print(message.member.name .. " did !show")
    uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",{inventory={}})
    local request = string.sub(message.content, 8)
    print(request)
    local curfilename = nametofn(request)
    if curfilename == nil then
      curfilename = fntoname(request)
      if curfilename ~= nil then
        curfilename = string.lower(request)
      end
    end
    
    print(curfilename)
    if curfilename ~= nil then
      if uj.inventory[curfilename] then
        print("user has card")
        message.channel:send {
          content = 'Here it is! Your '.. fntoname(curfilename) .. ' card.',
          file = "card_images/" .. curfilename .. ".png"
        }
      else
        print("user doesnt have card")
        message.channel:send("Sorry, but you don't have the " .. fntoname(curfilename) .. " card in your inventory.")
      end
    else
      message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
    end
    
    
    
  end
  
end)

client:run(privatestuff.botid)