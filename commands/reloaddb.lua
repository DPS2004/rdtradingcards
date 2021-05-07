local command = {}
function command.run(message, mt,overwrite)
  if overwrite then
    authcheck = true
  else
    
    local cmember = message.guild:getMember(message.author)
    authcheck = cmember:hasRole(privatestuff.modroleid)
  end
  if authcheck then
    print("authcheck passed")
    _G["privatestuff"] = dofile('privatestuff.lua')
    cmd.ping = dofile('commands/ping.lua')
    cmd.help = dofile('commands/help.lua')
    cmd.resetclock = dofile('commands/resetclock.lua')
    cmd.uptime = dofile('commands/uptime.lua')
    cmd.testcards = dofile('commands/testcards.lua')
    cmd.pull = dofile('commands/pull.lua')
    cmd.inventory = dofile('commands/inventory.lua')
    cmd.show = dofile('commands/show.lua')
    cmd.give = dofile('commands/give.lua')
    cmd.trade = dofile('commands/trade.lua')
    cmd.store = dofile('commands/store.lua')
    cmd.storage = dofile('commands/storage.lua')
    cmd.checkcollectors = dofile('commands/checkcollectors.lua')
    cmd.checkmedals = dofile('commands/checkmedals.lua')
    cmd.reloaddb = dofile('commands/reloaddb.lua')
    cmd.medals = dofile('commands/medals.lua')
    cmd.crash = dofile('commands/crash.lua')
    cmd.showmedal = dofile('commands/showmedal.lua')
    cmd.runlua = dofile('commands/runlua.lua')
    cmd.generategive = dofile('commands/generategive.lua')
    cmd.search = dofile('commands/search.lua')
    cmd.tell = dofile('commands/tell.lua')
    cmd.tellimage = dofile('commands/tellimage.lua')
    cmd.beans = dofile('commands/beans.lua')
    cmd.nickname = dofile('commands/nickname.lua')
    cmd.pray = dofile('commands/pray.lua')
    cmd.smell = dofile('commands/smell.lua')
    cmd.shred = dofile('commands/shred.lua')
    cmd.look = dofile('commands/look.lua')
    cmd.use = dofile('commands/use.lua')
    cmd.items = dofile('commands/items.lua')
    cmd.showitem = dofile('commands/showitem.lua')
    cmd.equip = dofile('commands/equip.lua')
    cmd.yeetalltokens = dofile('commands/yeetalltokens.lua')
    cmd.survey = dofile('commands/survey.lua')
    cmd.granttoken = dofile('commands/granttoken.lua')
    cmd.addallnicknames = dofile('commands/addallnicknames.lua')
    cmd.fullinventory = dofile('commands/fullinventory.lua')
    cmd.fullstorage = dofile('commands/fullstorage.lua')
    cmd.setworldstate = dofile('commands/setworldstate.lua')
    cmd.givetoken = dofile('commands/givetoken.lua')
    cmd.skipprompts = dofile('commands/skipprompts.lua')
    cmd.renamefile = dofile('commands/renamefile.lua')
    
    print("done loading commands")

    -- import reaction commands
    cmdre = {}
    cmdre.trade = dofile('reactions/trade.lua')
    cmdre.store = dofile('reactions/store.lua')
    cmdre.shred = dofile('reactions/shred.lua')
    cmdre.equip = dofile('reactions/equip.lua')
    cmdre.usemachine = dofile('reactions/usemachine.lua')
    cmdre.usehole = dofile('reactions/usehole.lua')
    cmdre.spideruse = dofile('reactions/spideruse.lua')
    cmdre.spiderlook = dofile('reactions/spiderlook.lua')
    cmdre.spidersmell = dofile('reactions/spidersmell.lua')
    cmdre.getladder = dofile('reactions/getladder.lua')
    cmdre.usemousehole = dofile('reactions/usemousehole.lua')
    cmdre.usebox = dofile('reactions/usebox.lua')
    
    print("done loading reactions")

    _G['defaultjson'] = {inventory={},storage={},medals={},names={},items={nothing=true},lastpull=-24,lastprayer=-7,lastequip=-24,lastbox=-24,tokens=0}
    
    _G['defaultworldsave'] = {tokensdonated=0,boxpool={"ssss45","roomsdc_ur","roomsdc_r","underworld","enchantedlove","wallclockur","rhythmdogtor","moai","coolbird","beanshopper","cardboardworld","acofoi","rollermobster","inimaur","fhottour","superstrongcavity","soundsr","pancakefever","nicoleur","feedthemachine","retrofunky","heartchickalt"},lablookindex=0,lablooktext="password is gnuthca ",worldstate = "prehole"}

    _G['debug'] = false
    
    _G["attachmentchannel"] = "829197797789532181"
    print("loading cards")
    cj =  io.open("data/cards.json", "r")
    
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json",defaultjson)

    _G['cdata'] = json.decode(cj:read("*a"))
    cj:close()

    --generate pull table
    _G['ptable'] = {}
    _G['cdb'] = {}
    for k,q in pairs(itemdb) do
      ptable[k] = {}
      for i,v in ipairs(cdata.groups) do
        for w,x in ipairs(v.cards) do
          local cmult = 1
          if x.bonuses[k] then
            cmult = 10 -- might tweak this??
          end
          for y=1,(cdata.basemult*v.basechance*x.chance*cmult) do
            table.insert(ptable[k],x.filename)
          end
        end
      end
    end
    for i,v in ipairs(cdata.groups) do
      for w,x in ipairs(v.cards) do
        table.insert(cdb,x)
        print(x.name.. " loaded!")
      end
    end
    --dpf.savejson("savedata/pulltable.json",ptable)
    
    print("here is cdb")
    print(inspect(cdb))
    -- print("here is ptable")
    --print(inspect(ptable))

    print("loading collector's info")
    _G['coll'] = dpf.loadjson("data/coll.json",defaultjson)
    print("loading medaldb")
    _G['medaldb'] = dpf.loadjson("data/medals.json",defaultjson)
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json",defaultjson)
    
    print("generating item pull table")
    _G['itempt'] = {}
    for k,v in pairs(itemdb) do
      if k ~= "fixedmouse" then
        table.insert(itempt,k)
      end
    end
    print(inspect(itempt))
    
    print("loading medal requires")
    _G['medalrequires'] = dpf.loadjson("data/medalrequires.json",defaultjson)
    
    
    _G['labimages'] = {
      "https://cdn.discordapp.com/attachments/829197797789532181/831907762081497118/lab0.png", --use embeds, they said
      "https://cdn.discordapp.com/attachments/829197797789532181/831907763076333588/lab1.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907764762574868/lab2.png", --it will be easy, they said
      "https://cdn.discordapp.com/attachments/829197797789532181/831907766682517544/lab3.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907771020214292/lab4.png", --i'm so sorry, dps
      "https://cdn.discordapp.com/attachments/829197797789532181/831907771716075632/lab5.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907773830791198/lab6.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907776657227816/lab7.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907779236724786/lab8.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907782151110656/lab9.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907809926316052/lab10.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907816570224700/lab11.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907820299485215/lab12.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907824485400626/lab13.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907829383823401/lab14.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907832977948712/lab15.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907838213357638/lab16.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907842084175872/lab17.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907846848380958/lab18.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907851671830538/lab19.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907856558194708/lab20.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907860207239168/lab21.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907864444534834/lab22.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907869049356338/lab23.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907874141765683/lab24.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907878990381076/lab25.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907882618323015/lab26.png" --h      
    }
    _G['letters'] = {
      " ",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    }
    
    
    print("loading functions")
    
    _G['getletterindex'] = function (x)
      print("finding letterindex of "..x)
      for i,v in ipairs(letters) do
        if v == x then
          return i
        end
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
          cuj.lastprayer = -24
          cuj.lastequip = -24
          cuj.lastbox = -24
        end
        dpf.savejson("savedata/"..v,cuj)
      end
    end
    --really cool and good code goes here
    --variable = "string" .. nilvalue

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
    _G['medalnametofn'] = function (x)
      for k,v in pairs(medaldb) do
        if string.lower(v.name) == string.lower(x) then
          local match = k
          return k
        end
      end
    end
    _G['medalfntoname'] = function (x)
      print("finding "..x)
      for k,v in pairs(medaldb) do
        if string.lower(k) == string.lower(x) then
          local match = v.name
          print(x.." = "..v.name)
          return v.name
        end
      end
      
    end

    _G['medaltexttofn'] = function (x)
      local cfn = medalnametofn(x)
      if cfn == nil then
        cfn = medalfntoname(x)
        if cfn ~= nil then
          cfn = string.lower(x)
        end
      end
      return cfn
    end
    
    ---aaaaaa
    _G['itemnametofn'] = function (x)
      for k,v in pairs(itemdb) do
        if string.lower(v.name) == string.lower(x) then
          local match = k
          return k
        end
      end
    end
    _G['itemfntoname'] = function (x)
      print("finding "..x)
      for k,v in pairs(itemdb) do
        if string.lower(k) == string.lower(x) then
          local match = v.name
          print(x.." = "..v.name)
          return v.name
        end
      end
      
    end

    _G['itemtexttofn'] = function (x)
      local cfn = itemnametofn(x)
      if cfn == nil then
        cfn = itemfntoname(x)
        if cfn ~= nil then
          cfn = string.lower(x)
        end
      end
      return cfn
    end
    
    _G['getcardtype'] = function (x)
      local ctype = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.filename)
          ctype = v.type
        end
      end
      return ctype
    end
    
    
    
    
    --- end aaaa
    _G['getcarddescription'] = function (x)
      print("getting description for " .. x)
      local cdescription = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.description)
          cdescription = v.description
        end
      end
      return cdescription
    end
    
	
    _G['getcardsmell'] = function (x)
      print("getting smell for " .. x)
      local csmell = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.smell)
          csmell = v.smell
        end
      end
      return csmell 
    end

    _G['getcardembed'] = function (x)
      local cembed = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.smell)
          cembed = v.embed
        end
      end
      return cembed
    end
	
    
    -- _G['getcardanimated'] = function (x)
    --   print("getting animated for " .. x)
    --   local canimated = nil
    --   for i,v in ipairs(cdb) do
        
    --     if v.filename == x then
    --       print(v.animated)
    --       canimated = v.animated
    --       if canimated == nil then
    --         canimated = false
    --       end
    --     end
    --   end
  
    --   print("returning" .. tostring(canimated))
    --   return canimated
    -- end
    -- _G['getcardpico'] = function (x)
    --   print("getting pico for " .. x)
    --   local cpico = nil
    --   for i,v in ipairs(cdb) do
        
    --     if v.filename == x then
    --       print(v.pico)
    --       cpico = v.pico
    --       if cpico == nil then
    --         cpico = false
    --       end
    --     end
    --   end
    --   print("returning" .. tostring(cpico))
    --   return cpico
    -- end


    -- Lua implementation of PHP scandir function
    _G['scandir'] = function (directory)
      return fs.readdirSync(directory)
    end

    _G['usernametojson'] = function (x)
      print(x)
      for i,v in ipairs(scandir("savedata")) do
        cuj = dpf.loadjson("savedata/"..v,defaultjson)
        if cuj.id then
          if cuj.id == x or ("<@!" .. cuj.id .. ">") == x or ("<@" .. cuj.id .. ">") == x then --prioritize id and mentions over nickname
            return "savedata/"..v
          end
        end
        if cuj.names then
          for j,w in pairs(cuj.names) do
            if j == x then
              return "savedata/"..v
            end
          end
        end
      end
    end

    _G['addreacts'] = function (x)
      x:addReaction("✅")
      x:addReaction("❌")
    end
    print("handlemessage")
    _G['handlemessage'] = function (message)
      if message.author.id ~= "767445265871142933" then --failsafe to avoid recursion
        --print("in handlemessage")
        local status, err = pcall(function ()
          if string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'ping' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.ping.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'help' then 
            print("this is a call for help")
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.help.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 10+3)) == prefix.. 'resetclock' then 
            print("hee hoo clocks go reset")
            local mt = string.split(string.sub(message.content, 10+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.resetclock.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 6+3)) == prefix.. 'uptime' then 
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.uptime.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 9+3)) == prefix.. 'testcards' then 
            local mt = string.split(string.sub(message.content, 9+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.testcards.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'pull' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.pull.run(message,mt)      
          elseif string.lower(string.sub(message.content, 0, 9+2)) == prefix.. 'inventory' then 
            print("wow its inventory")
            local mt = string.split(string.sub(message.content, 9+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.inventory.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 3+2)) == prefix.. 'inv' then 
            print("wow its inv")
            local mt = string.split(string.sub(message.content, 3+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.inventory.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'show ' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.show.run(message,nmt)         
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'give ' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.give.run(message,nmt)      
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'trade ' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.trade.run(message,nmt)      
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'store ' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.store.run(message,nmt)     
          
          elseif string.lower(string.sub(message.content, 0, 7+3)) == prefix.. 'storage ' or string.lower(string.sub(message.content, 0, 7+3)) == prefix.. 'storage' then 
            local mt = string.split(string.sub(message.content, 7+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.storage.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 8+3)) == prefix.. 'reloaddb' then 
            local mt = string.split(string.sub(message.content, 8+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.reloaddb.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 6+2)) == prefix.. 'medals' then 
            print("wow its medals")
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.medals.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'crash' then 
            print("this is a call for crash")
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.crash.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 13+3)) == prefix.. 'yeetalltokens' then 
            print("this is a call for crash")
            local mt = string.split(string.sub(message.content, 13+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.yeetalltokens.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 9+3)) == prefix.. 'showmedal ' then 
            local mt = string.split(string.sub(message.content, 9+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.showmedal.run(message,nmt)    
          elseif string.lower(string.sub(message.content, 0, 6+3)) == prefix.. 'runlua ' then 
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.runlua.run(message,nmt)   
          elseif string.lower(string.sub(message.content, 0, 12+3)) == prefix.. 'generategive ' then 
            local mt = string.split(string.sub(message.content, 12+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.generategive.run(message,nmt) 
          elseif string.lower(string.sub(message.content, 0, 6+3)) == prefix.. 'search ' then 
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.search.run(message,nmt)  
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'tell ' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.tell.run(message,nmt) 
          elseif string.lower(string.sub(message.content, 0, 9+3)) == prefix.. 'tellimage ' then 
            local mt = string.split(string.sub(message.content, 9+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.tellimage.run(message,nmt) 
          elseif string.lower(string.sub(message.content, 0, 5+2)) == prefix.. 'beans' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.beans.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 8+2)) == prefix.. 'nickname' then 
            local mt = string.split(string.sub(message.content, 8+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.nickname.run(message,nmt)
          
          elseif string.lower(string.sub(message.content, 0, 4+2)) == prefix.. 'pray' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.pray.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 4+3)) == prefix.. 'look ' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.look.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 3+3)) == prefix.. 'use ' then 
            local mt = string.split(string.sub(message.content, 3+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.use.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'smell ' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.smell.run(message,nmt)  
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'shred ' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.shred.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 5+2)) == prefix.. 'items' then 
            print("wow its medals")
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.items.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 8+3)) == prefix.. 'showitem ' then 
            local mt = string.split(string.sub(message.content, 8+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.showitem.run(message,nmt) 
          elseif string.lower(string.sub(message.content, 0, 5+3)) == prefix.. 'equip ' then 
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.equip.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 6+2)) == prefix.. 'survey' then 
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.survey.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 10+3)) == prefix.. 'granttoken ' then 
            local mt = string.split(string.sub(message.content, 10+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.granttoken.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 7+2)) == prefix.. 'machine' then 
            print("wow its medals")
            local mt = string.split(string.sub(message.content, 7+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.use.run(message,{"machine"})
          elseif string.lower(string.sub(message.content, 0, 1+3)) == prefix.. 'p' then 
            local mt = string.split(string.sub(message.content, 1+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.pull.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 4+2)) == prefix.. 'name' then 
            local mt = string.split(string.sub(message.content, 4+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.nickname.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 15+3)) == prefix.. 'addallnicknames' then 
            local mt = string.split(string.sub(message.content, 15+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.addallnicknames.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 13+3)) == prefix.. 'fullinventory' then 
            local mt = string.split(string.sub(message.content, 13+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.fullinventory.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 7+3)) == prefix.. 'fullinv' then 
            local mt = string.split(string.sub(message.content, 7+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.fullinventory.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 11+3)) == prefix.. 'fullstorage' then 
            local mt = string.split(string.sub(message.content, 11+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.fullstorage.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 13+3)) == prefix.. 'setworldstate ' then 
            local mt = string.split(string.sub(message.content, 13+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.setworldstate.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 6+3)) == prefix.. 'ladder' then 
            local mt = string.split(string.sub(message.content, 6+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.use.run(message,{"ladder"})
          elseif string.lower(string.sub(message.content, 0, 9+3)) == prefix.. 'givetoken ' then 
            local mt = string.split(string.sub(message.content, 9+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.givetoken.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 11+3)) == prefix.. 'skipprompts' then 
            local mt = string.split(string.sub(message.content, 11+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.skipprompts.run(message,mt)
          elseif string.lower(string.sub(message.content, 0, 10+3)) == prefix.. 'renamefile ' then 
            local mt = string.split(string.sub(message.content, 10+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            cmd.renamefile.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 5+2)) == prefix.. 'stats' then 
            print("terminal command shortcut")
            local mt = string.split(string.sub(message.content, 5+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.use.run(message,{"terminal","stats"})
          elseif string.lower(string.sub(message.content, 0, 7+2)) == prefix.. 'upgrade' then 
            print("terminal command shortcut")
            local mt = string.split(string.sub(message.content, 7+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.use.run(message,{"terminal","upgrade"})
          elseif string.lower(string.sub(message.content, 0, 7+2)) == prefix.. 'credits' then 
            print("terminal command shortcut")
            local mt = string.split(string.sub(message.content, 7+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.use.run(message,{"terminal","credits"})
          elseif string.lower(string.sub(message.content, 0, 8+2)) == prefix.. 'terminal' then 
            print("terminal command shortcut")
            local mt = string.split(string.sub(message.content, 8+4),"/")
            local nmt = {}
            nmt[1] = "terminal"
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i+1]=v
            end
            
            print(inspect(nmt))
            cmd.use.run(message,nmt)
          elseif string.lower(string.sub(message.content, 0, 3+2)) == prefix.. 'box' then 
            print("box command shortcut")
            local mt = string.split(string.sub(message.content, 3+4),"/")
            local nmt = {}
            for i,v in ipairs(mt) do
              v = trim(v)
              nmt[i]=v
            end
            print(inspect(nmt))
            cmd.use.run(message,{"box"})
          end
          

        end)
        if not status then
          print("uh oh")
          message.channel:send("Oops! An error has occured! Error message: ```" .. err .. "``` (<@290582109750427648> <@298722923626364928> please fix this thanks)")
        end
      end
    end
    print("handlereaction")
    _G['handlereaction'] = function (reaction, userid)
      
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
          elseif eom.etype == "shred" then
            print('it is a shred message being reacted to')
            cmdre.shred.run(ef, eom, reaction, userid)
          elseif eom.etype == "equip" then
            print('it is an equip message being reacted to')
            cmdre.equip.run(ef, eom, reaction, userid)
          elseif eom.etype == "usemachine" then
            print('it is a use machine message being reacted to')
            cmdre.usemachine.run(ef, eom, reaction, userid)
          elseif eom.etype == "usehole" then
            print('it is a use hole message being reacted to')
            cmdre.usehole.run(ef, eom, reaction, userid)
          elseif eom.etype == "spideruse" then
            print('it is a use spider message being reacted to')
            cmdre.spideruse.run(ef, eom, reaction, userid)
          elseif eom.etype == "spiderlook" then
            print('it is a look spider message being reacted to')
            cmdre.spiderlook.run(ef, eom, reaction, userid)
          elseif eom.etype == "spidersmell" then
            print('it is a look spider message being reacted to')
            cmdre.spidersmell.run(ef, eom, reaction, userid)
          elseif eom.etype == "getladder" then
            print('getladder')
            cmdre.getladder.run(ef, eom, reaction, userid)
          elseif eom.etype == "usemousehole" then
            print('usemousehole')
            cmdre.usemousehole.run(ef, eom, reaction, userid)
          elseif eom.etype == "usebox" then
            print('usebox')
            cmdre.usebox.run(ef, eom, reaction, userid)
          end
        end
      end
    end
    print("done loading")
    
    if not overwrite then
      message.channel:send('All commands have been reloaded.')
    end
    

  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
  --print(message.author.name .. " did !reloaddb")
end
return command
  