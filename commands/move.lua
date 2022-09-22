local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !move")

  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/move.json","")
  if not mt[1] then
    mt[1] = "pyrowmid"
  end
  local locations = {lang.locations_pyrowmid, lang.locations_lab, lang.locations_mountains, lang.locations_shop, lang.locations_hallway, lang.locations_casino}
  local success = false
  local request = string.lower(mt[1])
  local newroom = 0
  
  --0: pyrowmid
  --1: lab
  --2: mountain
  --3: shop
  --4: hallway
  --5: casino
  
  if request == "pyrowmid" or request == "the pyrowmid" or (uj.lang ~= "en" and request == lang.locations_pyrowmid) then
    success = true
    newroom = 0
  elseif wj.ws >= 507 and wj.labdiscovered == true and (request == "lab" or request == "abandonedlab" or request == "the abandoned lab" or request == "abandoned lab" or (uj.lang ~= "en" and request == lang.request_lab_1 or request == lang.request_lab_2 or request == lang.locations_lab)) then
    success = true
    newroom = 1
  elseif wj.ws >= 702 and (request == "mountains" or request == "mountain" or request == "windymountains" or request == "the windy mountains" or request == "windy mountains" or (uj.lang ~= "en" and request == lang.request_mountains_1 or request == lang.request_mountains_2 or request == lang.locations_mountains)) then
    success = true
    newroom = 2
  elseif wj.ws >= 702 and (request == "shop" or request == "quaintshop" or request == "quaint shop" or request == "the quaint shop" or (uj.lang ~= "en" and request == lang.request_shop_1 or request == lang.request_shop_2 or request == lang.request_shop_3 or request == lang.locations_shop)) then
    success = true
    newroom = 3
  elseif wj.ws >= 904 and (request == "hallway" or request == "darkhallway" or request == "the dark hallway" or request == "dark hallway" or (uj.lang ~= "en" and request == lang.request_hallway_1 or request == lang.request_hallway_2 or request == lang.locations_hallway)) then
    success = true
    newroom = 4
  elseif wj.ws >= 905 and (request == "casino" or request == "shadycasino" or request == "the shady casino" or request == "shady casino" or (uj.lang ~= "en" and request == lang.request_casino_1 or request == lang.request_casino_2 or request == lang.locations_casino)) then
    success = true
    newroom = 5
  end
  
  
  if success then
    print("newroom is ".. newroom)
    if newroom == uj.room then
      message.channel:send(lang.already_in_1 .. locations[newroom+1] .. lang.already_in_2)
      return
    elseif newroom == 3 and uj.lastrob + 4 > dpf.loadjson("savedata/shop.json", defaultshopsave).stocknum and uj.lastrob ~= 0 then
      lang = dpf.loadjson("langs/" .. uj.lang .. "/rob.json")
      local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
      local stocksleft = uj.lastrob + 3 - sj.stocknum
      local stockstring = lang.more_restock_1 .. stocksleft .. lang.more_restock_2
      if lang.needs_plural_s == true then
        if stocksleft > 1 then
          stockstring = stockstring .. lang.plural_s
        end
      end
      if uj.lastrob + 3 == sj.stocknum then
        local minutesleft = math.ceil((26/24 - time:toDays() + sj.lastrefresh) * 24 * 60)
        print(minutesleft)
        local durationtext = ""
        if math.floor(minutesleft / 60) > 0 then
          durationtext = math.floor(minutesleft / 60) .. lang.time_hour
          if lang.needs_plural_s == true then
            if math.floor(minutesleft / 60) ~= 1 then 
              durationtext = durationtext .. lang.plural_s 
            end
          end
        end
        if minutesleft % 60 > 0 then
          if durationtext ~= "" then
            durationtext = durationtext .. lang.time_and
          end
          durationtext = durationtext .. minutesleft % 60 .. lang.time_minute
          if lang.needs_plural_s == true then
            if minutesleft % 60 ~= 1 then
              durationtext = durationtext .. lang.plural_s 
            end
          end
        end
        message.channel:send(lang.blacklist_next_1 .. durationtext .. lang.blacklist_next_2)
      else
        message.channel:send(lang.blacklist_1 .. stockstring .. lang.blacklist_2)
      end
      return
    else
      uj.room = newroom
      if uj.lang == "ko" and newroom == 2 then
        message.channel:send(lang.room_changed_1 .. locations[newroom+1] .. lang.room_changed_2 .. lang.eu .. lang.room_changed_3)
      else
        message.channel:send(lang.room_changed_1 .. locations[newroom+1] .. lang.room_changed_2 .. lang.room_changed_3)
      end
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
      return uj
    end
  else
    message.channel:send(lang.no_room_1 .. mt[1] .. lang.no_room_2)
  end

end
return command