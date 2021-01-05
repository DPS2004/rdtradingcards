local command = {}
function command.run(message, mt,overwrite)
  if overwrite then
    authcheck = true
  else
    
    local cmember = message.guild:getMember(message.author)
    authcheck = cmember:hasRole(privatestuff.modroleid)
  end
  if authcheck then
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


    -- import reaction commands
    cmdre = {}
    cmdre.trade = dofile('reactions/trade.lua')
    cmdre.store = dofile('reactions/store.lua')

    _G['defaultjson'] = {inventory={},storage={},medals={},lastpull=-24}

    _G['debug'] = false
    cj =  io.open("data/cards.json", "r")
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
    print("here is cdb")
    print(inspect(cdb))
    print("here is ptable")
    print(inspect(ptable))

    print("loading collector's info")
    _G['coll'] = dpf.loadjson("data/coll.json",defaultjson)
    print("loading medaldb")
    _G['medaldb'] = dpf.loadjson("data/medals.json",defaultjson)
    print("loading medal requires")
    _G['medalrequires'] = dpf.loadjson("data/medalrequires.json",defaultjson)

    print("loading functions")

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


    -- Lua implementation of PHP scandir function
    _G['scandir'] = function (directory)
      return fs.readdirSync(directory)
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
  