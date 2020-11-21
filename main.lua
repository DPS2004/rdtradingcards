-- ok i know ths code is hot stinky garbage but it *works*, god damn-it.


-- it works most of the time. most of the time.
local discordia = require('discordia')
local client = discordia.Client()
_G["prefix"] = "c!"
_G["privatestuff"] = require('privatestuff')
_G["json"] = require('libs/json')
_G["dpf"] = require('libs/dpf')
_G["utils"] = require('libs/utils')
_G["trim"] = function (s)
   return s:match "^%s*(.-)%s*$"
end



-- import all the commands
cmd = {}
cmd.ping = require('commands/ping')
cmd.resetclock = require('commands/resetclock')
cmd.uptime = require('commands/uptime')
cmd.testcards = require('commands/testcards')
cmd.pull = require('commands/pull')
cmd.inventory = require('commands/inventory')
cmd.show = require('commands/show')

_G['defaultjson'] = {inventory={},storage={},lastpull=-24}

_G['debug'] = true

cj =  io.open("cards.json", "r")

_G['sw'] = discordia.Stopwatch()
sw:start()

_G['cdata'] = json.decode(cj:read("*a"))
cj:close()
--generate pull table
_G['ptable'] = {}
_G['cdb'] = {}
for i,v in ipairs(cdata.groups) do
  for w,x in ipairs(v.cards) do
    
    for y=1,(cdata.basemult*v.basechance*x.chance) do
      table.insert(ptable,x.filename)
    end
    table.insert(cdb,x)
    print(x.name.. " loaded!")
  end
end



_G['fntoname'] = function (x)
  print("finding "..x)
  for i,v in ipairs(cdb) do
    if string.lower(v.filename) == string.lower(x) then
      local match = v.name
      print(x.." = "..v.name)
      return v.name
    end
  end
  
end

_G['nametofn'] = function (x)
  for i,v in ipairs(cdb) do
    if string.lower(v.name) == string.lower(x) then
      local match = v.filename
      return v.filename
    end
  end
end

_G['resetclocks'] = function ()
  for i,v in ipairs(scandir("savedata")) do
    cuj = dpf.loadjson("savedata/"..v,defaultjson)
    if cuj.lastpull then
      cuj.lastpull = -24
    end
    dpf.savejson("savedata/"..v,cuj)
  end
end

_G['texttofn'] = function (x)
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
_G['scandir'] = function (directory)
    local i, t, popen = 0, {}, io.popen
    for filename in popen('dir "'..directory..'" /b'):lines() do
        i = i + 1
        t[i] = filename
    end
    return t
end

_G['usernametojson'] = function (x)
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
    
    if string.sub(message.content, 0, 4+3) == prefix.. 'ping' then 
      local mt = string.split(string.sub(message.content, 4+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.ping.run(message,mt)
    end
    
    if string.sub(message.content, 0, 10+3) == prefix.. 'resetclock' then 
      local mt = string.split(string.sub(message.content, 10+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.resetclock.run(message,mt)
    end
    if string.sub(message.content, 0, 6+3) == prefix.. 'uptime' then 
      local mt = string.split(string.sub(message.content, 6+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.uptime.run(message,mt)
    end
    if string.sub(message.content, 0, 9+3) == prefix.. 'testcards' then 
      local mt = string.split(string.sub(message.content, 9+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.testcards.run(message,mt)
    end

    if string.sub(message.content, 0, 4+3) == prefix.. 'pull' then 
      local mt = string.split(string.sub(message.content, 4+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.pull.run(message,mt)      
    end
    
    if string.sub(message.content, 0, 9+3) == prefix.. 'inventory' then 
      local mt = string.split(string.sub(message.content, 9+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.inventory.run(message,mt)
    end
    if string.sub(message.content, 0, 4+3) == prefix.. 'show ' then 
      local mt = string.split(string.sub(message.content, 4+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.show.run(message,nmt)      
    end
    if  message.content:find(prefix.. 'give ') and string.sub(message.content, 0, 7) == prefix.. 'give ' then -- format is c!give DPS2004#5143/farmer (rare)
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
    if message.content:find(prefix.. 'trade ') and string.sub(message.content, 0, 8) == prefix.. 'trade ' then
      print(message.member.name .. " did !trade")
      local mt = string.split(string.sub(message.content, 9),"/")
      if true then
        print(string.sub(message.content, 0, 8))
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
                    local tf = dpf.loadjson("savedata/events.json",{})
                    tf[newmessage.id] ={ujf = ujf, uj2f=uj2f,item1=item1, item2=item2,etype = "trade"}
                    dpf.savejson("savedata/events.json",tf)
                    
                    
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
  end
end)


client:on('reactionAdd', function(reaction, userid)
  local tf = dpf.loadjson("savedata/events.json",{})
  print('a reaction with an emoji named '.. reaction.emojiName .. ' was added to a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
  if tf[reaction.message.id] then
    print('it is an event message being reacted to')
    if tf[reaction.message.id].etype == "trade" then
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
          dpf.savejson("savedata/events.json",tf)
          dpf.savejson(uj2f,uj2)
          dpf.savejson(ujf,uj)
        end
        if reaction.emojiName == "❌" then
          print('user2 has denied')
          tf[reaction.message.id] = nil
          local newmessage = reaction.message.channel:send("<@".. uj2.id .."> has successfully denied the trade with <@" .. uj.id .. ">.")
          dpf.savejson("savedata/events.json",tf)
          
        end
      else
        print("its not uj2 reacting")
      end
    elseif tf[reaction.message.id].etype == "store" then
      print('it is a storage message being reacted to')
    end
    
    
    
    
  end


end)

resetclocks()



client:run(privatestuff.botid)