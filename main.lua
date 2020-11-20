local discordia = require('discordia')
local client = discordia.Client()
local prefix = "c!"
local privatestuff = require('privatestuff')
json = require('libs/json')
dpf = require('libs/dpf')
utils = require('libs/utils')


defaultjson = {inventory={},storage={},lastpull=-24}

debug = true

cj =  io.open("cards.json", "r")

sw = discordia.Stopwatch()
sw:start()

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

function resetclocks()
  for i,v in ipairs(scandir("savedata")) do
    cuj = dpf.loadjson("savedata/"..v,defaultjson)
    if cuj.lastpull then
      cuj.lastpull = -24
    end
    dpf.savejson("savedata/"..v,cuj)
  end
end

function texttofn(x)
  local cfn = nametofn(x)
  if cfn == nil then
    cfn = fntoname(x)
    if cfn ~= nil then
      cfn = string.lower(x)
    end
  end
  return cfn
end

-- Lua implementation of PHP scandir function
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    for filename in popen('dir "'..directory..'" /b'):lines() do
        i = i + 1
        t[i] = filename
    end
    return t
end

function usernametojson(x)
  for i,v in ipairs(scandir("savedata")) do
    cuj = dpf.loadjson("savedata/"..v,defaultjson)
    if cuj.name == x then
      return "savedata/"..v
    end
  end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
  if message.member.user.id ~= "767445265871142933" and message.member.username ~= "RDCards" then --failsafe to avoid recursion
    if message.content == prefix..'ping' then
      message.channel:send('pong')
      print(message.member.name .. " did !ping")
    end
    if message.content == prefix..'resetclock' then
      if message.member:hasRole(privatestuff.modroleid) then
        for i,v in ipairs(scandir("savedata")) do
          resetclocks()
        end
        message.channel:send('All user cooldowns have been reset.')
      else
        
        message.channel:send('Sorry but only moderators can use this command!')
      end
    end
    if message.content == prefix..'uptime' then
      local time = sw:getTime()
      message.channel:send('this bot has been running for' .. math.floor(time:toMinutes()) .. ' minutes.')
      print(message.member.name .. " did !ping")
    end
    if message.content == prefix..'testcards' then
      if debug then
        message.channel:send('ok, testing. There are '.. #cdb ..'cards in the database.')
        print(message.member.name .. " did !testcards")
        for i,v in ipairs(cdb) do
          message.channel:send {
            content = 'TESTCARDS: '.. v.name,
          }
          message.channel:send {
            file = "card_images/" .. v.filename .. ".png"
          }
        end
      else
        message.channel:send('Not so fast, buckaroo.')
      end
    end
    if message.content == prefix..'pull' then
      local time = sw:getTime()
      --message.channel:send('haha wowie! discord user '.. message.member.mentionString .. ' whos discord ID happens to be ' .. message.member.user.id ..' you got a card good job my broski')
      print(message.member.name .. " did !pull")
      local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
      if uj.lastpull + 10 <= time:toMinutes() then
        message.channel:send('Pulling card...')
        local newcard = ptable[math.random(#ptable)]
        local ncn = fntoname(newcard)
        print(ncn)
        message.channel:send {
            content = 'Woah! '.. message.member.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their inventory.',
            file = "card_images/" .. newcard .. ".png"
          }

        local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
        if uj.inventory[newcard] == nil then
          uj.inventory[newcard] = 1
        else
          uj.inventory[newcard] = uj.inventory[newcard] + 1
        end
        uj.name = message.member.username .. "#".. message.member.discriminator
        uj.id = message.member.user.id
        uj.lastpull = time:toMinutes()
        print(message.member.username .. "#" .. message.member.discriminator .. " is the username")
        print("number of cards is " .. uj.inventory[newcard])
        dpf.savejson("savedata/" .. message.member.user.id .. ".json",uj)
      else
        message.channel:send('Please wait ' .. math.ceil(uj.lastpull + 10 - time:toMinutes()) .. ' minutes before pulling again.')
      end

      
    end
    if message.content == prefix..'inventory' then
      print(message.member.name .. " did !inventory")
      local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
      local invstring = ''
      for k,v in pairs(uj.inventory) do
        invstring = invstring .. "**" .. (fntoname(k) or "ERROR!!!!!!!!") .. "** x" .. v .. "\n"
      end
        
      message.channel:send("Your inventory contains:\n" .. invstring)
    end
    if message.content:find(prefix.. 'show ') then
      print(message.member.name .. " did !show")
      local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
      local request = string.sub(message.content, 8)
      print(request)
      local curfilename = texttofn(request)
      
      print(curfilename)
      if curfilename ~= nil then
        if uj.inventory[curfilename] then
          print("user has card")
          message.channel:send {
            content = 'Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.',
            file = "card_images/" .. curfilename .. ".png"
          }
        else
          print("user doesnt have card")
          message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory.")
        end
      else
        message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
      end
      
      -- whole lotta code to display a png image lmao
      
    end
    if  message.content:find(prefix.. 'give ') then -- format is c!give DPS2004#5143/farmer (rare)
      print(message.member.name .. " did !give")
      local mt = string.split(string.sub(message.content, 8),"/")
      
      local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
      local uj2f = usernametojson(mt[1])
      if uj2f then
        local uj2 = dpf.loadjson(uj2f,defaultjson)
        local curfilename = texttofn(mt[2])
        if curfilename ~= nil then
          if uj.inventory[curfilename] ~= nil then
            print(uj.inventory[curfilename] .. "before")
            uj.inventory[curfilename] = uj.inventory[curfilename] - 1
            print(uj.inventory[curfilename] .. "after")
            if uj.inventory[curfilename] == 0 then
              uj.inventory[curfilename] = nil
            end
            dpf.savejson("savedata/" .. message.member.user.id .. ".json",uj)
            print("user had card, removed from original user")
            if uj2.inventory[curfilename] == nil then
              uj2.inventory[curfilename] = 1
            else
              uj2.inventory[curfilename] = uj2.inventory[curfilename] + 1
            end
            dpf.savejson(uj2f,uj2)
            print("saved user2 json with new card")
            
            message.channel:send {
              content = 'You have gifted your **' .. fntoname(curfilename) .. '** card to @' .. uj2.name .. ' .'
            }
          else
            print("user doesnt have card")
            message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory.")
          end
        else
          message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
        end
      else
        message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      end
      
    end
    if  message.content:find(prefix.. 'trade ') then
      print(message.member.name .. " did !trade")
      local mt = string.split(string.sub(message.content, 9),"/")
      
      local ujf = ("savedata/" .. message.member.user.id .. ".json")
      
      local uj2f = usernametojson(mt[2])
      --print(ujf2 .. "bleh")
      print("checking if user 2 exists")
      if uj2f then
        print("check if users are different people")
        if uj2f ~= ujf then
          --check if the items exist
          print("checking if item 1 exists")
          local uj = dpf.loadjson(ujf, defaultjson)
          local uj2 = dpf.loadjson(uj2f, defaultjson)
          local item1 = texttofn(mt[1])
          if item1 then
            print("checking if item 2 exists")
            local item2 = texttofn(mt[3])
            if item2 then
              --check if items are in the players inventories
              print("checking if u1 has i1")
              if uj.inventory[item1] then
                print("checking if u2 has i2")
                if uj2.inventory[item2] then
                  --BOTH ITEMS EXIST, AND ARE IN THE RIGHT PLACES.
                  print("success!!!!!")
                  local newmessage = message.channel:send("<@".. uj2.id ..">, <@" .. uj.id .. "> wants to trade their **" .. fntoname(item1) .. "** for your **" .. fntoname(item2) .. "**. React to this post with :white_check_mark: to accept and :x: to deny.")
                  local tf = dpf.loadjson("savedata/trades.json",{})
                  tf[newmessage.id] ={ujf = ujf, uj2f=uj2f,item1=item1, item2=item2}
                  dpf.savejson("savedata/trades.json",tf)
                  
                  
                else
                  message.channel:send("Sorry, but ".. uj2.name .. "doesn't have the **" .. fntoname(item2) .. "** card in their inventory.")
                end
                
                
                
              else
                message.channel:send("Sorry, but you don't have the **" .. fntoname(item1) .. "** card in your inventory.")
              end
              
              
              
            else
            
              message.channel:send("Sorry, but I could not find the " .. mt[3] .. " card in the database. Make sure that you spelled it right!")
            end
            
            
          else
            message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
          end
        else
          message.channel:send("Sorry, you cannot trade with yourself!")
        end
      else
        message.channel:send("Sorry, but I could not find a user named " .. mt[2] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      end
    end
  end
end)


client:on('reactionAdd', function(reaction, userid)
  local tf = dpf.loadjson("savedata/trades.json",{})
  print('a reaction with an emoji named '.. reaction.emojiName .. ' was added to a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
  if tf[reaction.message.id] then
    print('it is a trade message being reacted to')
    local ujf = tf[reaction.message.id].ujf
    local uj2f = tf[reaction.message.id].uj2f
    local item1 = tf[reaction.message.id].item1
    local item2 = tf[reaction.message.id].item2
    local uj = dpf.loadjson(ujf, defaultjson)
    print("loaded uj")
    local uj2 = dpf.loadjson(uj2f, defaultjson)
    print("loaded uj2")
    if uj2.id == userid then
      print('user2 has reacted')
      if reaction.emojiName == "✅" then
        print('user2 has accepted')
        print("removing item1 from user1")
        uj.inventory[item1] = uj.inventory[item1] - 1
        if uj.inventory[item1] == 0 then
          uj.inventory[item1] = nil
        end
        print("removing item2 from user2")
        uj2.inventory[item2] = uj2.inventory[item2] - 1
        if uj2.inventory[item2] == 0 then
          uj2.inventory[item2] = nil
        end
        print("giving item1 to user2")
        if uj2.inventory[item1] == nil then
          uj2.inventory[item1] = 1
        else
          uj2.inventory[item1] = uj2.inventory[item1] + 1
        end        
        print("giving item2 to user1")
        if uj.inventory[item2] == nil then
          uj.inventory[item2] = 1
        else
          uj.inventory[item2] = uj.inventory[item2] + 1
        end
        
        tf[reaction.message.id] = nil
        reaction.message.channel:send("The trade between <@".. uj2.id .."> and <@" .. uj.id .. "> has completed.")
        dpf.savejson("savedata/trades.json",tf)
        dpf.savejson(uj2f,uj2)
        dpf.savejson(ujf,uj)
      end
      if reaction.emojiName == "❌" then
        print('user2 has denied')
        tf[reaction.message.id] = nil
        local newmessage = reaction.message.channel:send("<@".. uj2.id .."> has successfully denied the trade with <@" .. uj.id .. ">.")
        dpf.savejson("savedata/trades.json",tf)
        
      end
    else
      print("its not uj2 reacting")
    end

    
    
    
    
  end


end)

resetclocks()



client:run(privatestuff.botid)