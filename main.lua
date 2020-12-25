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
cmd.help = require('commands/help')
cmd.resetclock = require('commands/resetclock')
cmd.uptime = require('commands/uptime')
cmd.testcards = require('commands/testcards')
cmd.pull = require('commands/pull')
cmd.inventory = require('commands/inventory')
cmd.show = require('commands/show')
cmd.give = require('commands/give')
cmd.trade = require('commands/trade')
cmd.store = require('commands/store')
cmd.storage = require('commands/storage')


-- import reaction commands
cmdre = {}
cmdre.trade = require('reactions/trade')
cmdre.store = require('reactions/store')

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

_G['addreacts'] = function (x)
  x:addReaction("✅")
  x:addReaction("❌")
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
    
    if string.sub(message.content, 0, 4+3) == prefix.. 'help' then 
      local mt = string.split(string.sub(message.content, 4+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.help.run(message,mt)
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
    if string.sub(message.content, 0, 4+3) == prefix.. 'give ' then 
      local mt = string.split(string.sub(message.content, 4+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.give.run(message,nmt)      
    end
    if string.sub(message.content, 0, 5+3) == prefix.. 'trade ' then 
      local mt = string.split(string.sub(message.content, 5+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.trade.run(message,nmt)      
    end
    if string.sub(message.content, 0, 5+3) == prefix.. 'store ' then 
      local mt = string.split(string.sub(message.content, 5+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.store.run(message,nmt)      
    end
    if string.sub(message.content, 0, 7+3) == prefix.. 'storage' then 
      local mt = string.split(string.sub(message.content, 7+4),"/")
      local nmt = {}
      for i,v in ipairs(mt) do
        v = trim(v)
        nmt[i]=v
      end
      cmd.storage.run(message,mt)
    end
  end

end)


client:on('reactionAdd', function(reaction, userid)
  if userid ~= "767445265871142933" then
    local ef = dpf.loadjson("savedata/events.json",{})
    print('a reaction with an emoji named '.. reaction.emojiName .. ' was added to a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
    eom = ef[reaction.message.id]
    if eom then
      print('it is an event message being reacted to')
      if eom.etype == "trade" then
        cmdre.trade.run(ef, eom, reaction, userid)
      elseif eom.etype == "store" then
        print('it is a storage message being reacted to')
        cmdre.store.run(ef, eom, reaction, userid)
      end
      
      
      
      
    end
  end


end)

resetclocks()



client:run(privatestuff.botid)