local command = {}
function command.run(message, mt, overwrite)
  local authcheck
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
    cmd.granttoken = dofile('commands/granttoken.lua')
    cmd.fullinventory = dofile('commands/fullinventory.lua')
    cmd.fullstorage = dofile('commands/fullstorage.lua')
    cmd.setworldstate = dofile('commands/setworldstate.lua')
    cmd.setspecialuser = dofile('commands/setspecialuser.lua')
    cmd.givetoken = dofile('commands/givetoken.lua')
    cmd.skipprompts = dofile('commands/skipprompts.lua')
    cmd.renamefile = dofile('commands/renamefile.lua')
    cmd.pronounlist = dofile('commands/pronounlist.lua')
    cmd.pronounform = dofile('commands/pronounform.lua')
    cmd.pronoun = dofile('commands/pronoun.lua')
    cmd.getfile = dofile('commands/getfile.lua')
    cmd.vipstest = dofile('commands/vipstest.lua')
    cmd.chick = dofile('commands/chick.lua')
    cmd.move = dofile('commands/move.lua')
    cmd.throw = dofile('commands/throw.lua')
    cmd.catch = dofile('commands/catch.lua')
    cmd.giveitem = dofile('commands/giveitem.lua')
    
    print("done loading commands")

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
    cmdre.buy = dofile('reactions/buy.lua')
    cmdre.useconsumable = dofile('reactions/useconsumable.lua')
    
    cmdcons.xraygoggles = dofile('consumables/xraygoggles.lua')
    cmdcons.decaf = dofile('consumables/decaf.lua')
    cmdcons.beepingpager = dofile('consumables/beepingpager.lua')
    cmdcons.breadcrumbs = dofile('consumables/breadcrumbs.lua')
    cmdcons.clownnose = dofile('consumables/clownnose.lua')
    cmdcons.fancyteaset = dofile('consumables/fancyteaset.lua')
    cmdcons.lunarrocks = dofile('consumables/lunarrocks.lua')
    cmdcons.secretadmirersnote = dofile('consumables/secretadmirersnote.lua')
    cmdcons.stickontabs = dofile('consumables/stickontabs.lua')
    cmdcons.tapiocapudding = dofile('consumables/tapiocapudding.lua')
    cmdcons.megaphone = dofile('consumables/megaphone.lua')
    cmdcons.caffeinatedsoda = dofile('consumables/caffeinatedsoda.lua')
    cmdcons.scratchoffticket = dofile('consumables/scratchoffticket.lua')
    cmdcons.replacementvoid = dofile('consumables/replacementvoid.lua')
    
    print("done loading reactions")

    _G['defaultjson'] = {
      inventory = {},
      storage = {},
      consumables = {},
      medals = {},
      items = {nothing = true},
      equipped = "nothing",
      conspt = "none",
      lastpull = -24,
      lastprayer = -7,
      lastequip = -24,
      lastbox = -24,
      tokens = 0,
      pronouns = {
        their = "their",
        them = "them",
        theirself = "themself",
        they = "they",
        theirs = "theirs"
      },
      room = 0,
      -- chickstats = {
      --   bodycolor = {255, 250, 0},
      --   eyecolor = {49, 49, 49},
      --   scleracolor = {248, 248, 248},
      --   beakcolor = {255, 128, 3},
      --   footcolor =  {255, 128, 3},
      --   headwear = "nothing",
      --   eyewear = "nothing",
      --   neckwear = "nothing",
      --   shoes = "nothing",
      --   others = {}
      -- }
    }
    
    _G['defaultworldsave'] = {
      tokensdonated = 0,
      boxpool = {"ssss45", "roomsdc_ur", "roomsdc_r", "underworld", "enchantedlove", "wallclockur", "rhythmdogtor", "moai", "coolbird", "beanshopper", "cardboardworld", "acofoi", "rollermobster", "inimaur", "fhottour", "superstrongcavity", "soundsr", "pancakefever", "nicoleur", "feedthemachine", "retrofunky", "heartchickalt"},
      lablookindex = 0,
      lablooktext = "abcdefghijklmnopqrstuvwxyz",
      worldstate = "prehole",
      ws = 0,
    }
    
    _G['defaultshopsave'] = {
      lastrefresh = 0,
      consumables = {
        {
          name = "caffeinatedsoda",
          stock = 10,
          price = 5
        },
        {
          name = "lunarrocks",
          stock = 11,
          price = 4
        },
        {
          name = "fancyteaset",
          stock = 12,
          price = 3
        }
      },
      cards = {
        {
          name = "514",
          stock = 10,
          price = 3
        },
        {
          name = "samurair",
          stock = 10,
          price = 1
        },
        {
          name = "knowyou",
          stock = 10,
          price = 3
        },
        {
          name = "alienalien",
          stock = 10,
          price = 1
        },
      },
      item = "hardcandy",
      itemstock = 10
      
    }

    _G['debug'] = false

    _G['nopeeking'] = false
    
    print("loading cards")
    _G['cdata'] = dpf.loadjson("data/cards.json", defaultjson)
    
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json", defaultjson)

    print('loading accessorydb')    
    _G['accessorydb'] = dpf.loadjson("data/accessories.json", defaultjson)

    --generate pull table
    _G['ptable'] = {}
    _G['seasontable'] = {}
    _G['cdb'] = {}
    _G['constable'] = {}
    local iterateitemdb = itemdb
    iterateitemdb["aboveur"] = {}
    for k, q in pairs(iterateitemdb) do
      ptable[k] = {}
      constable[k] = {}
      for i, v in ipairs(cdata.groups) do
        for w, x in ipairs(v.cards) do
          local cmult = 1
          if x.bonuses[k] then
            cmult = 10 -- might tweak this??
            for y=1, (cdata.basemult * v.basechance * x.chance) do
              table.insert(constable[k],x.filename)
            end
          end
          for y = 1, (cdata.basemult * v.basechance * x.chance * cmult) do
            table.insert(ptable[k],x.filename)
          end
        end
      end
    end

    for i, v in ipairs(cdata.groups) do
      for w, x in ipairs(v.cards) do
        table.insert(cdb, x)
        if not seasontable[x.season] then seasontable[x.season] = {} end
        table.insert(seasontable[x.season], x.filename)
      end
    end
    
    -- print("here is cdb")
    -- print(inspect(cdb))
    -- print("here is seasontable")
    -- print(inspect(seasontable))
    -- print("here is ptable")
    -- print(inspect(ptable))
    
    
    print('loading consumabledb')    
    _G['consumabledb'] = dpf.loadjson("data/consumables.json", defaultjson)
    
    print("making cpt")
    _G['cpt'] = {}
    for k,v in pairs(consumabledb) do
      for i=1,v.chance do
        table.insert(cpt,k)
      end
    end

    print("loading collector's info")
    _G['coll'] = dpf.loadjson("data/coll.json", defaultjson)
    print("loading medaldb")
    _G['medaldb'] = dpf.loadjson("data/medals.json", defaultjson)
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json", defaultjson)
    
    print("loading medal requires")
    _G['medalrequires'] = dpf.loadjson("data/medalrequires.json",defaultjson)
    
    _G['upgradeimages'] = {
      "https://cdn.discordapp.com/attachments/829197797789532181/838908505192661022/upgrade1.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908506496958464/upgrade2.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908508841836564/upgrade3.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908510972280842/upgrade4.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908513119109130/upgrade5.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908515179036742/upgrade6.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908517477253181/upgrade7.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908519876263967/upgrade8.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908522040918066/upgrade9.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908524389203998/upgrade10.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908548205379624/upgrade11.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908558963376128/upgrade12.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908564105723925/upgrade13.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908567347003392/upgrade14.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908570355236914/upgrade15.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908575879135242/upgrade16.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908579901734963/upgrade17.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908584078999583/upgrade18.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908589674332180/upgrade19.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838908616329265212/upgrade20.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838910126554742814/upgrade21.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838910145491894292/upgrade22.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/838910782556733511/upgrade23.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/849420890281345034/upgrade24.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044075704221716/upgrade25.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044088089215046/upgrade26.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044088164188180/upgrade27.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044089305563184/upgrade28.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044089003311105/upgrade29.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/853044859139784725/upgrade30.png"
    }

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
      for i, v in ipairs(letters) do
        if v == x then
          return i
        end
      end
    end
    
    _G['fntoname'] = function (x)
      print("finding " .. x)
      for i, v in ipairs(cdb) do
        if string.lower(v.filename) == string.lower(x) then
          return v.name
        end
      end
    end

    _G['nametofn'] = function (x)
      for i, v in ipairs(cdb) do
        if string.lower(v.name) == string.lower(x) then
          return v.filename
        end
      end
    end

    _G['resetclocks'] = function ()
      for i,v in ipairs(scandir("savedata")) do
        local cuj = dpf.loadjson("savedata/" .. v, defaultjson)
        if cuj.lastpull then
          cuj.lastpull = -24
          cuj.lastprayer = -24
          cuj.lastequip = -24
          cuj.lastbox = -24
        end
        dpf.savejson("savedata/" .. v, cuj)
      end
    end

    _G['texttofn'] = function (x)
      local cfn = nametofn(x)
      if not cfn then
        cfn = fntoname(x)
        if cfn then
          cfn = string.lower(x)
        end
      end
      return cfn
    end

    _G['medalnametofn'] = function (x)
      for k, v in pairs(medaldb) do
        if string.lower(v.name) == string.lower(x) then
          return k
        end
      end
    end

    _G['medalfntoname'] = function (x)
      print("finding " .. x)
      for k, v in pairs(medaldb) do
        if string.lower(k) == string.lower(x) then
          return v.name
        end
      end
    end

    _G['medaltexttofn'] = function (x)
      local mfn = medalnametofn(x)
      if not mfn then
        mfn = medalfntoname(x)
        if mfn then
          mfn = string.lower(x)
        end
      end
      return mfn
    end
    
    _G['consnametofn'] = function (x)
      for k, v in pairs(consumabledb) do
        if string.lower(v.name) == string.lower(x) then
          return k
        end
      end
    end
    
    _G['consfntoname'] = function (x)
      print("finding " .. x)
      for k, v in pairs(consumabledb) do
        if string.lower(k) == string.lower(x) then
          return v.name
        end
      end
      
    end
    
    _G['constexttofn'] = function (x)
      local ifn = consnametofn(x)
      if not ifn then
        ifn = consfntoname(x)
        if ifn then
          ifn = string.lower(x)
        end
      end
      return ifn
    end
    
    _G['itemnametofn'] = function (x)
      for k, v in pairs(itemdb) do
        if string.lower(v.name) == string.lower(x) then
          return k
        end
      end
    end

    _G['itemfntoname'] = function (x)
      print("finding " .. x)
      for k, v in pairs(itemdb) do
        if string.lower(k) == string.lower(x) then
          return v.name
        end
      end
      
    end

    _G['itemtexttofn'] = function (x)
      local ifn = itemnametofn(x)
      if not ifn then
        ifn = itemfntoname(x)
        if ifn then
          ifn = string.lower(x)
        end
      end
      return ifn
    end
    
    

    
    _G['getcardtype'] = function (x)
      for i, v in ipairs(cdb) do
        if v.filename == x then
          return v.type
        end
      end
    end

    _G['getcardseason'] = function (x)
      for i, v in ipairs(cdb) do
        if v.filename == x then
          return v.season
        end
      end
    end
    
    _G['getcarddescription'] = function (x)
      print("getting description for " .. x)
      for i, v in ipairs(cdb) do
        if v.filename == x then
          print(v.description)
          return v.description
        end
      end
    end
    
	
    _G['getcardsmell'] = function (x)
      print("getting smell for " .. x)
      for i, v in ipairs(cdb) do
        if v.filename == x then
          print(v.smell)
          return v.smell
        end
      end
    end

    _G['getcardembed'] = function (x)
      local cembed = nil
      for i, v in ipairs(cdb) do
        if v.filename == x then
          cembed = v.embed
          if v.randomized then
            if math.random(2) == 1 then
              cembed = v.embedalt
            end
          end
        end
      end
      return cembed
    end
    
    _G['getcardspoiler'] = function (x)
      print("getting spoiler for " .. x)
      for i, v in ipairs(cdb) do
        if v.filename == x then
          print(v.spoiler)
          if v.spoiler then
            return true
          end
        end
      end
    end

    -- Lua implementation of PHP scandir function
    _G['scandir'] = function (directory)
      return fs.readdirSync(directory)
    end

    _G['usernametojson'] = function (x)
      print(x)
      for i,v in ipairs(scandir("savedata")) do
        local cuj = dpf.loadjson("savedata/"..v,defaultjson)
        if cuj.id then
          if cuj.id == x or ("<@!" .. cuj.id .. ">") == x or ("<@" .. cuj.id .. ">") == x then --prioritize id and mentions over nickname
            return "savedata/"..v
          end
        end
        if cuj.names then
          for j,w in pairs(cuj.names) do
            if string.lower(j) == string.lower(x) then
              return "savedata/"..v
            end
          end
        end
      end
    end

    _G['ynbuttons'] = function(message, content, etype, data, yesoption, nooption)
      yesoption = yesoption or "Yes"
      nooption = nooption or "No"
      local messagecontent, messageembed
      if type(content) == "table" then
        messageembed = content
      else
        messagecontent = content
      end
      local newmessage = message.channel:send({
        embed = messageembed,
        content = messagecontent,
        components = {
          { --whyyyyyy
            type = 1, -- make button container
            components = {
              {
                type = 2, -- make a button
                style = 3, -- green
                label = yesoption, -- add text
                custom_id = etype .. "_yes",
                disabled = "false"
              },
              {
                type = 2, -- make a button
                style = 4, -- red
                label = nooption, -- add text
                custom_id = etype .. "_no",
                disabled = "false"
              }
            }
          } --discord pls
        }
      })
      local tf = dpf.loadjson("savedata/events.json",{})
      local newevent = {ujf = ("savedata/" .. message.author.id .. ".json") ,etype = etype,ogmessage = {channel = {id = message.channel.id}, id = message.id, author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString, avatarURL = message.author.avatarURL}}}
      for k,v in pairs(data) do
        newevent[k] = v
      end
      tf[newmessage.id] = newevent
      dpf.savejson("savedata/events.json", tf)

      if client:waitFor(newmessage.id, 3600 * 1000) then -- Timeout after 1 hour
        print("Message successfully reacted to, removing event")
      else
        print("Button reaction timed out, removing event")
      end
      tf = dpf.loadjson("savedata/events.json",{})
      tf[newmessage.id] = nil
      dpf.savejson("savedata/events.json", tf)

      return newmessage
    end
    
    _G['commands'] = {}
    
    _G['addcommand'] = function(trigger,commandfunction, expectedargs,force,usebypass)
      local newcommand = {}
      newcommand.trigger = prefix .. trigger
      newcommand.commandfunction = commandfunction or cmd.ping
      newcommand.expectedargs = 0 or expectedargs
      newcommand.force = force
      newcommand.usebypass = usebypass
      
      table.insert(commands, newcommand)
    end
    
    addcommand("ping",cmd.ping)
    addcommand("help",cmd.help)
    addcommand("resetclock",cmd.resetclock)
    addcommand("uptime",cmd.uptime)
    addcommand("testcards",cmd.testcards)
    addcommand("pull",cmd.pull)
    addcommand("inventory",cmd.inventory)
    addcommand("inv",cmd.inventory)
    addcommand("give",cmd.give)
    addcommand("trade",cmd.trade)
    addcommand("store",cmd.store)
    addcommand("storage",cmd.storage)
    addcommand("reloaddb",cmd.reloaddb)
    addcommand("medals",cmd.medals)
    addcommand("crash",cmd.crash)
    addcommand("yeetalltokens",cmd.yeetalltokens)
    addcommand("showmedal",cmd.showmedal)
    addcommand("runlua",cmd.runlua)
    addcommand("generategive",cmd.generategive)  
    addcommand("search",cmd.search)  
    addcommand("tell",cmd.tell)  
    addcommand("beans",cmd.beans)
    addcommand("nickname",cmd.nickname)
    addcommand("checkmedals",cmd.checkmedals)
    addcommand("pronouns",cmd.pronoun)
    addcommand("pronounlist",cmd.pronounlist)
    addcommand("pronounform",cmd.pronounform)
    addcommand("pronoun",cmd.pronoun)
    addcommand("pray",cmd.pray)
    addcommand("look",cmd.look)
    addcommand("use",cmd.use)
    addcommand("smell",cmd.smell)
    addcommand("shred",cmd.shred)
    addcommand("items",cmd.items)
    addcommand("showitem",cmd.showitem)
    addcommand("equip",cmd.equip)
    addcommand("granttoken",cmd.granttoken)
    addcommand("machine",cmd.use,0,{"machine"})
    addcommand("name",cmd.nickname)
    addcommand("fullinventory",cmd.fullinventory)
    addcommand("fullinv",cmd.fullinventory)
    addcommand("fullstorage",cmd.fullstorage)
    addcommand("setworldstate",cmd.setworldstate)
    addcommand("setspecialuser",cmd.setspecialuser)
    addcommand("ladder",cmd.use,0,{"ladder"})
    addcommand("givetoken",cmd.givetoken)
    addcommand("skipprompts",cmd.skipprompts)
    addcommand("vipstest",cmd.vipstest)
    --addcommand("chick",cmd.chick)
    addcommand("move",cmd.move)
    addcommand("renamefile",cmd.renamefile)
    addcommand("getfile",cmd.getfile)
    addcommand("stats",cmd.use,0,{"terminal","stats"},true)
    addcommand("upgrade",cmd.use,0,{"terminal","upgrade"})
    addcommand("credits",cmd.use,0,{"terminal","credits"},true)
    addcommand("savedata",cmd.use,0,{"terminal","savedata"},true)
    addcommand("logs",cmd.use,0,{"terminal","logs"},true)
    addcommand("terminal",cmd.use,0,{"terminal"})
    addcommand("buy",cmd.use,0,{"shop"})
    addcommand("box",cmd.use,0,{"box"})
    addcommand("show",cmd.show)
    addcommand("p",cmd.pull)
    addcommand("b",cmd.use,0,{"box"})
    addcommand("throw",cmd.throw)
    addcommand("vipstest",cmd.vipstest,0)
    addcommand("catch",cmd.catch)
    addcommand("giveitem",cmd.giveitem)
    _G['handlemessage'] = function (message,skip)
      if message.author.id ~= client.user.id or skip then
        local hasrun = false
        for i,v in ipairs(commands) do
          if (string.lower(string.sub(message.content, 0, #v.trigger+1)) == v.trigger or string.lower(string.sub(message.content, 0, #v.trigger+1)) == v.trigger.." ") and not hasrun then
            print("found ".. v.trigger)
            local mt = {}
            local nmt = {}
            if v.expectedargs == 0 then
              mt = string.split(string.sub(message.content, #v.trigger+1),"/")
              for a,b in ipairs(mt) do
                b = trim(b)
                nmt[a]=b
              end
            elseif v.expectedargs == 1 then
              nmt = {trim(string.sub(message.content, #v.trigger+1))}
            end --might have to expand later?
            if v.force then
              for c,d in ipairs(v.force) do
                table.insert(nmt,c,d)
              end
            end
            print("nmt: " .. inspect(nmt))
            hasrun = true
            local status, err = pcall(function ()
              v.commandfunction.run(message,nmt,v.usebypass)
            end)
            if not status then
              print("uh oh")
              message.channel:send("Oops! An error has occured! Error message: ```" .. err .. "``` (<@290582109750427648> <@298722923626364928> please fix this thanks)")
            end
          end
        end
      end
    end
    
    print("handlebutton")
    _G['handlebutton'] = function (buttonid, member, message)
      local ef = dpf.loadjson("savedata/events.json",{})
      if ef[message.id] then
        local reaction = {
          emojiName = "✅",
          message = message
        }
        print("looking for " .. ef[reaction.message.id].etype .. "_no")
        if buttonid == ef[reaction.message.id].etype .. "_no" then
          print("reaction is no")
          reaction.emojiName = "❌"
        end

        local userid = member.id
        print('a button named '.. buttonid .. ' was pressed on a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
        local eom = ef[reaction.message.id]
        if eom then
          print('it is an event message being reacted to')
          local status, err = pcall(function ()
            cmdre[eom.etype].run(ef, eom, reaction, userid)
          end)
          if not status then
            print("uh oh")
            reaction.message.channel:send("Oops! An error has occured! Error message: ```" .. err .. "``` (<@290582109750427648> <@298722923626364928> please fix this thanks)")
          end
        end
      else
        print("user reacted to a finished button")
      end
    end
    
    _G['getitemthumb'] = function(item,cons)
      local cf = io.open("vips_out/cache/items/"..item..".png", "r")
      if not cf then --check if file exists
        print("caching thumb for ".. item)
        local dir = "items/"
        if cons then
          dir = "assets/consumables/"
        end
        print(dir..item..".png")
        local itemimg = vips.Image.new_from_file(dir..item..".png") -- load item image
        itemimg = itemimg:resize(0.15) --TODO: force nearest neighbor scaling?
        itemimg:write_to_file("vips_out/cache/items/"..item..".png")
        print("done cachin'")
      end
      return "vips_out/cache/items/"..item..".png"
    end
    _G['getcardthumb'] = function(card)
      local cf = io.open("vips_out/cache/cards/"..card..".png", "r")
      if not cf then --check if file exists
        print("caching thumb for " .. card)
        local check = io.open("card_images/"..card..".png")
        if not check then
          card = "none"
        end
        local cardimg = vips.Image.new_from_file("card_images/"..card..".png") -- load item image
        cardimg = cardimg:resize(96 / cardimg:height()) --TODO: force nearest neighbor scaling?
        
        cardimg:write_to_file("vips_out/cache/cards/"..card..".png")
        print("done cachin'")
      end
      return "vips_out/cache/cards/"..card..".png"
    end
    getitemthumb("decaf",true)
    getitemthumb("stainedgloves")
    getcardthumb("knowyou")
    
    _G['getshopimage'] = function()
      local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local osj = dpf.loadjson("vips_out/cache/shop/lastshop.json", {})
      
      
      if json.encode(sj) ~= json.encode(osj) then--holy shit why
        local darkener = vips.Image.new_from_file("assets/darkener.png")
        print("remaking shop")
        local base = vips.Image.new_from_file("assets/shop/base.png")
        local item = vips.Image.new_from_file(getitemthumb(sj.item))
        if sj.itemstock == 0 then
          item = item:Colourspace('b-w')
          item = item:composite2(darkener,"over")
        end
        base = base:composite2(item,"over",{x=900,y=420})
        for i,v in pairs(sj.consumables) do
          item = vips.Image.new_from_file(getitemthumb(v.name,true))
          if v.stock == 0 then
            item = item:Colourspace('b-w')
            item = item:composite2(darkener,"over")
          end
          base = base:composite2(item,"over",{x=260 + (i-1)*213 ,y=420})
          i = i + 1
        end 
        local x = 0
        local y = 0
        for i,v in ipairs(sj.cards) do
          if i == 1 then
            x,y = 210,173
          elseif i == 2 then
            x,y = 330,173
          elseif i == 3 then
            x,y = 210,293
          elseif i == 4 then
            x,y = 330,293
          end
          
          local card = vips.Image.new_from_file(getcardthumb(v.name))
          if v.stock == 0 then
            card = card:Colourspace('b-w')
            card = card:composite2(darkener,"over")
          end
          base = base:composite2(card,"over",{x=x,y=y})
        end
            
        base:write_to_file("vips_out/shop.png")
        dpf.savejson("vips_out/cache/shop/lastshop.json", sj)
      else
        print("shop is already good")
      end
      return "vips_out/shop.png"
    end
    getshopimage()
    
    
    _G['checkforreload'] = function(days) 
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      print(days .. "days")
      if days >= sj.lastrefresh + 46/24 then
        stockshop()
        sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
        sj.lastrefresh = sj.lastrefresh + 46/24
        dpf.savejson("savedata/shop.json", sj)
      end
      
    end
    
    _G['stockshop'] = function()
      local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      
      local newcards = {{name="",stock=0,price=0},{name="",stock=0,price=0},{name="",stock=0,price=0},{name="",stock=0,price=0}}
      for i,v in ipairs(sj.cards) do--------------------cards
        print("stocking" .. i)
        local finding = true
        local nc = ""
        while finding do
          nc = ptable.nothing[math.random(#ptable.nothing)]
          print(nc)
          local new = true
          for w,x in ipairs(newcards) do
            if x.name == nc then
              new = false
            end
          end
          if new == true then
            finding = false
          end
        end
        local price = 8
        if getcardtype(nc) == "Rare" then
          price = 1
        elseif getcardtype(nc) == "Super Rare" or getcardtype(nc) == "PICO-8" then
          price = 2
        elseif getcardtype(nc) == "Ultra Rare" then
          price = 4
        elseif getcardtype(nc) == "Discontinued" or getcardtype(nc) == "Alternate" then
          price = math.random(4, 6)
        elseif getcardtype(nc) == "Discontinued Alternate" or getcardtype(nc) == "Discontinued Super Rare" then
          price = math.random(8, 10)
        elseif getcardtype(nc) == "Discontinued Rare" or getcardtype(nc) == "Discontinued Ultra Rare" then
          price = math.random(13, 17)
        end

        if getcardseason(nc) == #seasontable then
          price = price + 1
        end
        newcards[i] = {name = nc,stock = math.random(5,15), price = price}
        sj.cards = newcards
      end
      ---------------------------------------------item
      
      local itempt = {}
      for k in pairs(itemdb) do
        if k ~= "fixedmouse" and k ~= "nothing" then
          table.insert(itempt, k)
        end
      end
      sj.item = itempt[math.random(#itempt)]
      sj.itemstock = math.random(5,15)
      -----------------------consumables
      local newconsumables = {{name="",stock=0,price=0},{name="",stock=0,price=0},{name="",stock=0,price=0}}
      for i,v in ipairs(sj.consumables) do
        
        local finding = true
        local nc = ""
        while finding do
          nc = cpt[math.random(#cpt)]
          local new = true
          for w,x in ipairs(newconsumables) do
            if x.name == nc then
              new = false
            end
          end
          if new == true then
            finding = false
          end
        end

        newconsumables[i] = {name = nc,stock = math.random(5,15), price = consumabledb[nc].baseprice + math.random(-1,1)}
        
      end
      sj.consumables = newconsumables
        
      
      
      
      dpf.savejson("savedata/shop.json", sj)
      
      
      
    end
    _G['shophas'] = function (x)
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local found = false
      for i,v in ipairs(sj.consumables) do
        if v.name == x then
          found = true
        end
      end
      for i,v in ipairs(sj.cards) do
        if v.name == x then
          found = true
        end
      end
      if sj.item == x then
        found = true
      end
      return found
    end

    print("getchickimage")
    _G['getchickimage'] = function (userid)
      local ujf = ("savedata/" .. userid .. ".json")
      local uj = dpf.loadjson(ujf, defaultjson)

      --getting all the body parts
      local chickbody = vips.Image.new_from_file("chick/chick_body.png")
      local chickeyes = vips.Image.new_from_file("chick/chick_eyes.png")
      local chicksclerae = vips.Image.new_from_file("chick/chick_sclerae.png")
      local chickbeak = vips.Image.new_from_file("chick/chick_beak.png")
      local chickfeet = vips.Image.new_from_file("chick/chick_feet.png")

      --coloring the body
      local cbodycolor = uj.chickstats.bodycolor
      chickbody = chickbody:colourspace("hsv") * { 0, 0, 1, 1 }
      chickbody = chickbody:colourspace("srgb") * { cbodycolor[1] / 255, cbodycolor[2] / 255, cbodycolor[3] / 255, 1 }

      --coloring the body parts
      local ceyecolor = uj.chickstats.eyecolor
      chickeyes = chickeyes * { ceyecolor[1] / 255, ceyecolor[2]/255, ceyecolor[3] / 255, 1 }

      local cscleracolor = uj.chickstats.scleracolor
      chicksclerae = chicksclerae * { cscleracolor[1] / 255, cscleracolor[2]/255, cscleracolor[3] / 255, 1 }
      
      local cbeakcolor = uj.chickstats.beakcolor
      chickbeak = chickbeak * { cbeakcolor[1] / 255, cbeakcolor[2]/255, cbeakcolor[3] / 255, 1 }

      local cfootcolor = uj.chickstats.footcolor
      chickfeet = chickfeet * { cfootcolor[1] / 255, cfootcolor[2]/255, cfootcolor[3] / 255, 1 }

      --combining the body parts
      local chickimg = chickbody:composite2(chickeyes, "over")
      chickimg = chickimg:composite2(chicksclerae, "over")
      chickimg = chickimg:composite2(chickbeak, "over")
      chickimg = chickimg:composite2(chickfeet, "over")
      
      
      --adding others (middle layer)
      if uj.chickstats.others and uj.chickstats.others ~= {} then
        for i,v in ipairs(uj.chickstats.others) do
          print("loading "..v)
          if accessorydb.other[v].layer == "middle" then
            if not accessorydb.other[v].replace then
              local otherimg = vips.Image.new_from_file("chick/accessories/" .. v .. ".png")
              if accessorydb.other[v].bodycolor then
                print("found bodycolor")

                local cbodycolor = uj.chickstats.bodycolor
                otherimg = otherimg:colourspace("hsv") * { 0, 0, 1, 1 }
                otherimg = otherimg:colourspace("srgb") * { cbodycolor[1] / 255, cbodycolor[2] / 255, cbodycolor[3] / 255, 1 }
              end
              if accessorydb.other[v].sclerae then
                print("found scl")
                local scleraelayer = vips.Image.new_from_file("chick/accessories/" .. v .. "_sclerae.png")
                scleraelayer = scleraelayer * { cscleracolor[1] / 255, cscleracolor[2]/255, cscleracolor[3] / 255, 1 }
                otherimg = otherimg:composite2(scleraelayer, "over")
              end
              if accessorydb.other[v].eyes then
                print("found eyes")
                local eyeslayer = vips.Image.new_from_file("chick/accessories/" .. v .. "_eyes.png")
                eyeslayer = eyeslayer * { ceyecolor[1] / 255, ceyecolor[2]/255, ceyecolor[3] / 255, 1 }
                otherimg = otherimg:composite2(eyeslayer, "over")
              end
              if accessorydb.other[v].legs then
                print("found legs")
                local legslayer = vips.Image.new_from_file("chick/accessories/" .. v .. "_legs.png")
                legslayer = legslayer * { cfootcolor[1] / 255, cfootcolor[2]/255, cfootcolor[3] / 255, 1 }
                otherimg = otherimg:composite2(legslayer, "over")
              end
              if accessorydb.other[v].uncolored then
                local uclayer = vips.Image.new_from_file("chick/accessories/" .. v .. "_uncolored.png")
                otherimg = otherimg:composite2(uclayer, "over")
              end
              chickimg = chickimg:composite2(otherimg, "over")
            else
              chickimg = vips.Image.new_from_file("chick/accessories/" .. v .. ".png")
              if accessorydb.other[v].bodycolor then
                print("found bodycolor")

                local cbodycolor = uj.chickstats.bodycolor
                chickimg = chickimg:colourspace("hsv") * { 0, 0, 1, 1 }
                chickimg = chickimg:colourspace("srgb") * { cbodycolor[1] / 255, cbodycolor[2] / 255, cbodycolor[3] / 255, 1 }
              end
            end
          end
        end
      end

      --adding headwear
      if (uj.chickstats.headwear and uj.chickstats.headwear ~= "nothing") then
        local hatimg = vips.Image.new_from_file("chick/accessories/" .. uj.chickstats.headwear .. ".png")
        chickimg = chickimg:composite2(hatimg, "over")
      end

      --adding eyewear
      if (uj.chickstats.eyewear and uj.chickstats.eyewear ~= "nothing") then
        local glassesimg = vips.Image.new_from_file("chick/accessories/" .. uj.chickstats.eyewear .. ".png")
        chickimg = chickimg:composite2(glassesimg, "over")
      end

      --adding neckwear
      if (uj.chickstats.neckwear and uj.chickstats.neckwear ~= "nothing") then
        local neckimg = vips.Image.new_from_file("chick/accessories/" .. uj.chickstats.neckwear .. ".png")
        chickimg = chickimg:composite2(neckimg, "over")
      end
      
      --adding clothes
      if (uj.chickstats.clothes and uj.chickstats.clothes ~= "nothing") then
        local clothesimg = vips.Image.new_from_file("chick/accessories/" .. uj.chickstats.clothes .. ".png")
        chickimg = chickimg:composite2(clothesimg, "over")
      end

      --adding shoes
      if (uj.chickstats.shoes and uj.chickstats.shoes ~= "nothing") then
        local shoeimg = vips.Image.new_from_file("chick/accessories/" .. uj.chickstats.shoes .. ".png")
        chickimg = chickimg:composite2(shoeimg, "over")
      end
      
      --adding others (top layer)
      if uj.chickstats.others and uj.chickstats.others ~= {} then
        for i,v in ipairs(uj.chickstats.others) do
          if accessorydb.other[v].layer == "top" then
            local otherimg = vips.Image.new_from_file("chick/accessories/" .. v .. ".png")
            if accessorydb.other[v].bodycolor then
              print(accessorydb.other[v].uncoloredlayer)
              local cbodycolor = uj.chickstats.bodycolor
              otherimg = otherimg:colourspace("hsv") * { 0, 0, 1, 1 }
              otherimg = otherimg:colourspace("srgb") * { cbodycolor[1] / 255, cbodycolor[2] / 255, cbodycolor[3] / 255, 1 }
              if accessorydb.other[v].uncolored then
                local uclayer = vips.Image.new_from_file("chick/accessories/" .. v .. "_uncolored.png")
                otherimg = otherimg:composite2(uclayer, "over")
              end
            end
            chickimg = chickimg:composite2(otherimg, "over")
          end
        end
      end
      
      return chickimg
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
  
