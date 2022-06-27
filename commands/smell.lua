local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !smell")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    local request = string.lower(mt[1])
    print(request)
    local curfilename = texttofn(request)
    local hcsmells = {
      panda = "The **Panda** smells of bamboo and needs to shower.",
      pyrowmid = "The **Pyrowmid** smells familiar, but not too familiar.",
      throne = "The **Throne** smells like cardstock.",
      machine = "The **Strange Machine** smells metallic, reminding you of the scent of a **Token**.",
      token = "A **Token** smells like a normal coin. What did you expect?",
      factory = "Smells like smog.",
      ladder = "The **Ladder** smells brand new, even though it has been sitting out for a while.",
      hole = "The **Hole** smells like a strange combination of dirt and electricity.",
      lab = "The **Abandoned Lab** smells strongly of machines and dust.",
      terminal = "Both the **Terminal** and the **Database** still smell strongly of the gas that they released once you collectively deposited 100 tokens.",
      table = "As you go to take a sniff of the **Table**, you end up with a noseful of dust.",
      poster = "The **Cat Poster** smells like lots of different things at the same time.",
      mousehole = "The **Mouse Hole** smells like screen cleaner and screwdrivers.",
      box = "Oddly enough, the **Peculiar Box** smells of nothing at all.",
      mountains = "The **Windy Mountains** smell very calming.",
      bridge = "The **Bridge** smells stable... enough...",
      shop = "The **Quaint Shop** smells like healthy competition.",
      barrels = "The **Barrels** smell like trade secrets.",
      clouds = "The **Clouds** are a bit too high up for you to smell!",
      wolf = "The **Wolf** smells like a good boy.",
      ghost = "Even the **Ghost's** smell tells you it is internally screaming.",
      photo = "The **Photo** smells slightly of moss and spite."
    }
    local itemsmells = {
      nothing = "It smells like the **Peculiar Box**.",
      rustysword = "The **Rusty Sword**, unsurprisingly, smells like rust.",
      cafemixtape = "The **Cafe Mixtape** smells like outdated audio formats.",
      oversizedstethoscope = "The **Oversized Stethoscope** smells like medical school.",
      valentinesdaycard = "The **Valentines Day Card** smells like glitter.",
      hardcandy = "The **Hard Candy** smells like a retirement home.",
      deluxebirdseed = "The **Deluxe Birdseed** smells like something a squirrel would enjoy.",
      brokenmouse = "The **Broken Mouse** smells like cheap plastic.",
      fixedmouse = "The **Fixed Mouse** smells like reinforced plastic.",
      stoppedwatch = "The **Stopped Watch** smells like anachronism.",
      faithfulnecklace = "The **Faithful Necklace** smells. You need to take it off and wash it.",
      stainedgloves = "The **Stained Gloves** smell like red.",
      paddedstickersheet = "The **Padded Sticker Sheet** smells like elementary school.",
      duncecap = "The **Dunce Cap** smells like <#944290668086448148>. That is, to say, bad.",
      deviltail = "The **Devil Tail** smells like fire and brimstone.",
      scribblednotepad = "The **Scribbled-In Notepad** smells like imagination.",
      okamiiscollar = "**okamii's Collar** smells like mirrors.",
      coolhat = "The **Cool Hat** smells really cool :sunglasses:",
      lostnametag = "The **Lost Name Tag** smells like the Department of Agriculture",
      charcoalpencil = "The **Charcoal Pencil** smells like a burnt-out campfire.",
      fieldjournal = "The **Field Journal** has a faint smell of slime emanating off of it.",
      driftingmetronome = "The **Drifting Metronome** smells slightly out of sync.",
      filmreel = "The **Film Reel** smells like *really* outdated video formats. Why are we still using these?",
      swirlymarbles = "You can almost swear the **Swirly Marbles** smell like celestial objects.",
	  
	  granolabar = "The **Granola Bar** smells like sand.",
	  hauntedgrass = "The **Haunted Grass** smells very petrichor." --unsure if this is the right usage but whatevs
    }
    local consumablesmells = {
      caffeinatedsoda = "The **Caffeinated Soda** tickles your nose as you try to smell it.",
      decaf = "The **Decaf Coffee** smells of disappointment.",
      beepingpager = "The **Beeping Pager** gives a worrying scent. It makes you want to check up on people to make sure they are ok.",
      breadcrumbs = "The **Breadcrumbs** smell of slightly expired baked goods.",
      clownnose = "The **Clown Nose** smells funny.",
      fancyteaset = "The **Fancy Tea Set** gives a scent of peppermint tea.",
      lunarrocks = "The **Lunar Rocks** reek of...eggs?",
      secretadmirersnote = "The **Secret Admirers Note** smells of teenage awkwardness.",
      stickontabs = "The **Stick-on Tabs** smell like those old sticker-sheets you got when you were three.",
      tapiocapudding = "The **Tapioca Pudding** smells like pudding. What did you expect?",
      replacementvoid = "The **Replacement Void** doesn't smell like anything. You get a bit worried.",
      xraygoggles = "The **X-Ray Goggles** smell like cheating at poker.",
      scratchoffticket = "The **Scratch-off Ticket** smells like the lottery.",
      giftairstrike = "The **Gift Air Strike** smells like santa.",
      megaphone = "The **Megaphone** smells loud.",
      oldfiles = "The **Old Files** smell like programmer art.",
      spicymintgum = "The **Spicy Mint Gum** smells like peppermint",
      butterypopcorn = "The **Buttery Popcorn** smell reminds you of movie nights.",
      pocketdimension = "The **Pocket Dimension** smells uncannily familiar, yet slighty different.",
      quantummouse = "The **Quantum Mouse** simultaneously smells like high-quality alloys and really cheap plastic.",
      s1booster = "The **Nostalgic Booster** smells like plastic packaging and blueberry lemonade.",
      s2booster = "The **Customized Booster** smells like plastic packaging and child pyramids.",
      s3booster = "The **Pixelated Booster** smells like plastic packaging and 32:41 ratios.",
      s4booster = "The **Released Booster** smells like plastic packaging and bamboo.",
      s5booster = "The **Alternative Booster** smells like plastic packaging and cat posters.",
      s6booster = "The **Diverse Booster** smells like plastic packaging and gender juice.",
      s7booster = "The **Animal Booster** smells like plastic packaging and wolf shop-owners."
    }

    if request == "strange machine" then
      request = "machine"
    elseif request == "abandoned lab" then
      request = "lab"
    elseif request == "database" then
      request = "terminal"
    elseif request == "cat poster" then
      request = "poster"
    elseif request == "mouse hole" or request == "mouse" then
      request = "mousehole"
    elseif request == "peculiar box" or request == "peculiarbox" then
      request = "box"
    elseif request == "windymountains" or request == "windy mountains" then
      request = "mountains"
    elseif request == "quaintshop" or request == "quaint shop" then
      request = "shop"
    end
    
    
    
    print(curfilename)
    if curfilename ~= nil then
      if uj.inventory[curfilename] or uj.storage[curfilename] or shophas(curfilename) then
        print("user has card")
        local smell = cdb[curfilename].smell
        message.channel:send(trf("smell", {card = curfilename, smell = smell}))
      else
        print("user doesnt have card")
        if nopeeking then
          message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
        else
          message.channel:send("Sorry, but you don't have the **" .. cdb[curfilename].name .. "** card in your inventory or your storage.")
        end
      end

    elseif (request == "spiderweb" or request == "spider web" or request == "web") and wj.smellable then
      ynbuttons(message, 'Are you okay with smelling a spider?',"spidersmell",{})
    elseif hcsmells[request] then
      message.channel:send(hcsmells[request])
    elseif itemtexttofn(request) then
      print("smelling")
      request = itemtexttofn(request)
      if uj.items[request] or shophas(request) then
        message.channel:send(itemsmells[request])
      else
        message.channel:send("Sorry, but you do not have the **" .. itemdb[request].name .. "** item.")
      end
    elseif constexttofn(request) then
      print("smelling consumable")
      request = constexttofn(request)
      if uj.consumables[request] or shophas(request) then
        message.channel:send(consumablesmells[request])
      else
        message.channel:send("Sorry, but the **" .. consdb[request].name .. "** item can't be found in the shop or your inventory.")
      end
    else
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
      end
    end

  else
    message.channel:send("Sorry, but the c!smell command expects 1 argument. Please see c!help for more details.")
  end
end
return command
