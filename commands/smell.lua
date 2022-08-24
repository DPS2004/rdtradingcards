local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !smell")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
	local lang = dpf.loadjson("langs/" .. uj.lang .. "/smell.json")
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    local request = string.lower(mt[1])
    print(request)
    local curfilename = texttofn(request)
    local hcsmells = {
      panda = lang.smell_panda,
      pyrowmid = lang.smell_pyrowmid,
      throne = lang.smell_throne,
      machine = lang.smell_machine,
      token = lang.smell_token,
      factory = lang.smell_factory,
      ladder = lang.smell_ladder,
      hole = lang.smell_hole,
      lab = lang.smell_lab,
      terminal = lang.smell_terminal,
      table = lang.smell_table,
      poster = lang.smell_poster,
      mousehole = lang.smell_mousehole,
      box = lang.smell_box,
      mountains = lang.smell_mountains,
      bridge = lang.smell_bridge,
      shop = lang.smell_shop,
      barrels = lang.smell_barrels,
      clouds = lang.smell_clouds,
      wolf = lang.smell_wolf,
      ghost = lang.smell_ghost,
      photo = lang.smell_photo
    }
    local itemsmells = {
      nothing = lang.smell_nothing,
      rustysword = lang.smell_rustysword,
      cafemixtape = lang.smell_cafemixtape,
      oversizedstethoscope = lang.smell_oversizedstethoscope,
      valentinesdaycard = lang.smell_valentinesdaycard,
      hardcandy = lang.smell_hardcandy,
      deluxebirdseed = lang.smell_deluxebirdseed,
      brokenmouse = lang.smell_brokenmouse,
      fixedmouse = lang.smell_fixedmouse,
      stoppedwatch = lang.smell_stoppedwatch,
      faithfulnecklace = lang.smell_faithfulnecklace,
      stainedgloves = lang.smell_staindedgloves,
      paddedstickersheet = lang.smell_paddedstickersheet,
      duncecap = lang.smell_duncecap,
      deviltail = lang.smell_deviltail,
      scribblednotepad = lang.smell_scribblednotepad,
      okamiiscollar = lang.smell_okamiiscollar,
      coolhat = lang.smell_coolhat,
      lostnametag = lang.smell_lostnametag,
      charcoalpencil = lang.smell_charcoalpencil,
      fieldjournal = lang.smell_fieldjournal,
      driftingmetronome = lang.smell_driftingmetronome,
      filmreel = lang.smell_filmreel,
      swirlymarbles = lang.smell_swirlymarbles,
	  
	  granolabar = lang.smell_granolabar,
	  hauntedgrass = lang.smell_hauntedgrass, --unsure if this is the right usage but whatevs
	  --cryopod
	  subwayticket = lang.smell_subwayticket
    }
    local consumablesmells = {
      caffeinatedsoda = lang.smell_caffeinatedsoda,
      decaf = lang.smell_decaf,
      beepingpager = lang.smell_beepingpager,
      breadcrumbs = lang.smell_breadcrumbs,
      clownnose = lang.smell_clownnose,
      fancyteaset = lang.smell_fancyteaset,
      lunarrocks = lang.smell_lunarrocks,
      secretadmirersnote = lang.smell_secretadmirersnote,
      stickontabs = lang.smell_stickontabs,
      tapiocapudding = lang.smell_tapiocapudding,
      replacementvoid = lang.smell_replacementvoid,
      xraygoggles = lang.smell_xraygoggles,
      scratchoffticket = lang.smell_scratchoffticket,
      giftairstrike = lang.smell_giftairstrike,
      megaphone = lang.smell_megaphone,
      oldfiles = lang.smell_oldfiles,
      spicymintgum = lang.smell_spicymintgum,
      butterypopcorn = lang.smell_butterypopcorn,
      pocketdimension = lang.smell_pocketdimension,
      quantummouse = lang.smell_quantummouse,
      s1booster = lang.smell_s1booster,
      s2booster = lang.smell_s2booster,
      s3booster = lang.smell_s3booster,
      s4booster = lang.smell_s4booster,
      s5booster = lang.smell_s5booster,
      s6booster = lang.smell_s6booster,
      s7booster = lang.smell_s7booster
    }

    if uj.lang ~= "en" and request == lang.request_panda then
      request = "panda"
	elseif uj.lang ~= "en" and request == lang.request_pyrowmid then
      request = "pyrowmid"
	elseif uj.lang ~= "en" and request == lang.request_throne then
      request = "throne"
	elseif request == "strange machine" or (uj.lang ~= "en" and request == lang.request_machine_1 or request == lang.request_machine_2 or request == lang.request_machine_3) then
      request = "machine"
	elseif uj.lang ~= "en" and request == lang.request_token then
      request = "token"
	elseif request == "card factory" or request == "cardfactory" or (uj.lang ~= "en" and request == lang.request_factory_1 or request == lang.request_factory_2 or request == lang.request_factory_3) then
      request = "factory"
	elseif uj.lang ~= "en" and request == lang.request_ladder then
      request = "ladder"
	elseif uj.lang ~= "en" and request == lang.request_hole then
      request = "hole"
    elseif request == "abandoned lab" or (uj.lang ~= "en" and request == lang.request_lab_1 or request == lang.request_lab_2 or request == lang.request_lab_3) then
      request = "lab"
    elseif request == "database" or (uj.lang ~= "en" and request == lang.request_terminal_1 or request == lang.request_terminal_2) then
      request = "terminal"
	elseif uj.lang ~= "en" and request == lang.request_table then
      request = "table"
    elseif request == "cat poster" or (uj.lang ~= "en" and request == lang.request_poster_1 or request == lang.request_poster_2 or request == lang.request_poster_3) then
      request = "poster"
    elseif request == "mouse hole" or request == "mouse" or (uj.lang ~= "en" and request == lang.request_mousehole_1 or request == lang.request_mousehole_2 or request == lang.request_mousehole_3) then
      request = "mousehole"
    elseif request == "peculiar box" or request == "peculiarbox" or (uj.lang ~= "en" and request == lang.request_box_1 or request == lang.request_box_2 or request == lang.request_box_3) then
      request = "box"
    elseif request == "windymountains" or request == "windy mountains" or (uj.lang ~= "en" and request == lang.request_mountains_1 or request == lang.request_mountains_2 or request == lang.request_mountains_3) then
      request = "mountains"
	elseif uj.lang ~= "en" and request == lang.request_bridge then
      request = "bridge"
    elseif request == "quaintshop" or request == "quaint shop" or (uj.lang ~= "en" and request == lang.request_shop_1 or request == lang.request_shop_2 or request == lang.request_shop_3 or request == lang.request_shop_4) then
      request = "shop"
	elseif uj.lang ~= "en" and request == lang.request_barrels then
      request = "barrels"
	elseif uj.lang ~= "en" and request == lang.request_panda then
      request = "clouds"
	elseif uj.lang ~= "en" and request == lang.request_wolf then
      request = "wolf"
	elseif uj.lang ~= "en" and request == lang.request_ghost then
      request = "ghost"
	elseif uj.lang ~= "en" and request == lang.request_photo then
      request = "photo"
    end
    
    
    
    print(curfilename)
    if curfilename ~= nil then
      if uj.inventory[curfilename] or uj.storage[curfilename] or shophas(curfilename) then
        print("user has card")
        local smell = cdb[curfilename].smell
		if uj.lang == "ko" then
		  local take = {"뽑은", "옮긴", "꺼낸", "빼낸"}
		  local ctake = math.random(1, #take)
		  local action = {"냄새를 맡았다. ", "냄새를 들이마셨다. ", "당신의 코에 올렸다. ", "당신의 얼굴에 두었다. "}
		  local caction = math.random(1, #action)
		  local desc = {"그 냄새는 ",  "", "사실 당신은 맛을 봤다. 카드의 맛은 ", "외부의 목소리가 당신의 머릿속에 들어온다. ", "", "당신은 갑자기 ", "그 카드는 "}
		  local desc2 = {"을(를) 떠올리게 한다.", " 냄새가 난다.",  " 같다.", "에 대해 말하고 있다.", "에 대한 그리운 기억이 당신을 스쳐 지나간다.", "에 대한 극심한 갈망을 느낀다.", "을(를) 떠올리게 하는 강렬한 향취를 내뿜는다."}
		  local cdesc = math.random(1, #desc)
		  local trfstring = "당신은 **" .. cdb[curfilename].name .. "** 카드를 " .. take[ctake] .. " 뒤 " .. action[caction] .. "\n" .. desc[cdesc] .. "**" .. smell .. "**" .. desc2[cdesc]
          message.channel:send(trfstring)
		else
		  message.channel:send(trf("smell", {card = cdb[curfilename].name, smell = smell}))
		end
      else
        print("user doesnt have card")
        if nopeeking then
          message.channel:send(lang.error_nopeeking_1 .. request .. error_nopeeking_2)
        else
          message.channel:send(lang.dont_have_card_1 .. cdb[curfilename].name .. lang.dont_have_card_2)
        end
      end
	
    elseif (request == "spiderweb" or request == "spider web" or request == "web" or (uj.lang ~= "en" and request == lang.request_spider_1 or request == lang.request_spider_2)) and wj.smellable then
      ynbuttons(message, lang.spider_alert,"spidersmell",{},uj.id,uj.lang)
    elseif hcsmells[request] then
      message.channel:send(hcsmells[request])
    elseif itemtexttofn(request) then
      print("smelling")
      request = itemtexttofn(request)
      if uj.items[request] or shophas(request) then
        message.channel:send(itemsmells[request])
      else
        message.channel:send(lang.dont_have_item_1 .. itemdb[request].name .. lang.dont_have_item_2)
      end
    elseif constexttofn(request) then
      print("smelling consumable")
      request = constexttofn(request)
      if uj.consumables[request] or shophas(request) then
        message.channel:send(consumablesmells[request])
      else
        message.channel:send(lang.dont_have_cons_1 .. consdb[request].name .. lang.dont_have_cons_2)
      end
    else
      if nopeeking then
        message.channel:send(lang.error_nopeeking_1 .. request .. error_nopeeking_2)
      else
        message.channel:send(lang.no_card_1 .. request .. lang.no_card_2)
      end
    end

  else
    message.channel:send(lang.no_arguments)
  end
end
return command
