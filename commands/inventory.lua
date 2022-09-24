local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/inventory.json", "")

  local enableShortNames = false
  local enableSeason = false
  local filterSeason = false
	local filterRarity = false
  
  local filterSeason0 = false
  local filterSeason1 = false
  local filterSeason2 = false
  local filterSeason3 = false
  local filterSeason4 = false
  local filterSeason5 = false
  local filterSeason6 = false
  local filterSeason7 = false
  local filterSeason8 = false
  local filterSeason9 = false
  local filterSeason10 = false

	local filterRarityR = false
	local filterRaritySR = false
	local filterRarityUR = false
	local filterRarityDC = false
	local filterRarityALT = false
	local filterRarityDCR = false
	local filterRarityDCSR = false
	local filterRarityDCUR = false
	local filterRarityDCALT = false
	local filterRarityALTALT = false
	local filterRarityPICO8 = false

  local pagenumber = 1

  args = {}
  for substring in mt[1]:gmatch("%S+") do
    table.insert(args, substring)
  end

  for index, value in ipairs(args) do
    if tonumber(value) then
      pagenumber = math.floor(tonumber(value))
    end
    if value == "-s" then
      enableShortNames = true
	  	print("-s enabled")
    elseif value == "-season" then
      enableSeason = true
	  	print("-season enabled")
		elseif value == "-season0" then
	  	filterSeason = true
	  	filterSeason0 = true
	  	print("-season0 enabled")
    elseif value == "-season1" then
	  	filterSeason = true
	  	filterSeason1 = true
	  	print("-season1 enabled")
		elseif value == "-season2" then
	  	filterSeason = true
	  	filterSeason2 = true
	  	print("-season2 enabled")
		elseif value == "-season3" then
	  	filterSeason = true
	  	filterSeason3 = true
	  	print("-season3 enabled")
		elseif value == "-season4" then
	  	filterSeason = true
	  	filterSeason4 = true
	  	print("-season4 enabled")
		elseif value == "-season5" then
	  	filterSeason = true
	  	filterSeason5 = true
	  	print("-season5 enabled")
		elseif value == "-season6" then
	  	filterSeason = true
	  	filterSeason6 = true
	  	print("-season6 enabled")
		elseif value == "-season7" then
	  	filterSeason = true
	  	filterSeason7 = true
	  	print("-season7 enabled")
		elseif value == "-season8" then
	  	filterSeason = true
	  	filterSeason8 = true
	  	print("-season8 enabled")
		elseif value == "-season9" then
	  	filterSeason = true
	  	filterSeason9 = true
	  	print("-season9 enabled")
    elseif value == "-season10" then
	  	filterSeason = true
	  	filterSeason10 = true
	  	print("-season10 enabled")
		elseif value == "-rarityr" then
			filterRarity = true
			filterRarityR = true
			print("-rarityr enabled")
		elseif value == "-raritysr" then
			filterRarity = true
			filterRaritySR = true
			print("-raritysr enabled")
		elseif value == "-rarityur" then
			filterRarity = true
			filterRarityUR = true
			print("-rarityur enabled")
		elseif value == "-raritydc" then
			filterRarity = true
			filterRarityDC = true
		elseif value == "-rarityalt" then
			filterRarity = true
			filterRarityALT = true
			print("-rarityalt enabled")
		elseif value == "-raritydcr" then
			filterRarity = true
			filterRarityDCR = true
			print("-raritydcr enabled")
		elseif value == "-raritydcsr" then
			filterRarity = true
			filterRarityDCSR = true
			print("-raritydcsr enabled")
		elseif value == "-raritydcur" then
			filterRarity = true
			filterRarityDCUR = true
			print("-raritydcur enabled")
		elseif value == "-raritydcalt" then
			filterRarity = true
			filterRarityDCALT = true
			print("-raritydcalt enabled")
		elseif value == "-rarityaltalt" then
			filterRarity = true
			filterRarityALTALT = true
			print("-rarityaltalt enabled")
		elseif value == "-raritypico8" or value == "-raritypico" then
			filterRarity = true
			filterRarityPICO8 = true
			print("-raritypico8 enabled")
		end
  end

  local invtable = {}
  local invstring = ''
  local invsfilter = {}
  
  if filterSeason0 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 0 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason1 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 1 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason2 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 2 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason3 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 3 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason4 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 4 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason5 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 5 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason6 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 6 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason7 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 7 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason8 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 8 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason9 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 9 then
	    invsfilter[k] = v
	  end
	end
  end
  if filterSeason10 then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 10 then
	    invsfilter[k] = v
	  end
	end
  end

	local invrfilter = {}

	if filterRarity then
		if filterSeason then
			invrfilter = invsfilter
			for k,v in pairs(invrfilter) do
				if filterRarityR and cdb[k].type == "Rare" then
				elseif filterRaritySR and cdb[k].type == "Super Rare" then
				elseif filterRarityUR and cdb[k].type == "Ultra Rare" then
				elseif filterRarityDC and cdb[k].type == "Discontinued" then
				elseif filterRarityALT and cdb[k].type == "Alternate" then
				elseif filterRarityDCR and cdb[k].type == "Discontinued Rare" then
				elseif filterRarityDCSR and cdb[k].type == "Discontinued Super Rare" then
				elseif filterRarityDCUR and cdb[k].type == "Discontinued Ultra Rare" then
				elseif filterRarityDCALT and cdb[k].type == "Discontinued Alternate" then
				elseif filterRarityALTALT and cdb[k].type == "Alternate Alternate" then
				elseif filterRarityPICO8 and cdb[k].type == "PICO-8" then
				else
					invrfilter[k] = nil
				end
			end
		else
			if filterRarityR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRaritySR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Super Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityUR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Ultra Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityDC then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Discontinued" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityALT then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Alternate" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityDCR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Discontinued Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityDCSR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Discontinued Super Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityDCUR then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Discontinued Ultra Rare" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityDCALT then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Discontinued Alternate" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityALTALT then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "Alternate Alternate" then
						invrfilter[k] = v
					end
				end
			end
			if filterRarityPICO8 then
				for k,v in pairs(uj.inventory) do
					if cdb[k].type == "PICO-8" then
						invrfilter[k] = v
					end
				end
			end
		end
	end

  pagenumber = math.max(1, pagenumber)
  
  local numcards = 0
	if filterRarity then
		for k in pairs(invrfilter) do numcards = numcards + 1 end
	elseif filterSeason then
    for k in pairs(invsfilter) do numcards = numcards + 1 end
  else
    for k in pairs(uj.inventory) do numcards = numcards + 1 end
  end
  local maxpn = math.ceil(numcards / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)
  
	if filterRarity then
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(invrfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(invrfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(invrfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(invrfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
  elseif filterSeason then
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(invsfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(invsfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(invsfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(invsfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
	else
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
  end
  table.sort(invtable)
  
  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if invtable[i] then invstring = invstring .. invtable[i] end
  end
  
  local seasonnum = ""
  local multipleSeasons = false
  if filterSeason then
    if filterSeason0 then
			seasonnum = "0"
		end
		if filterSeason1 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 1"
				multipleSeasons = true
			else
				seasonnum = "1"
			end
		end
		if filterSeason2 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 2"
				multipleSeasons = true
			else
				seasonnum = "2"
			end
		end
		if filterSeason3 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 3"
				multipleSeasons = true
			else
				seasonnum = "3"
			end
		end
		if filterSeason4 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 4"
				multipleSeasons = true
			else
				seasonnum = "4"
			end
		end
		if filterSeason5 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 5"
				multipleSeasons = true
			else
				seasonnum = "5"
			end
		end
		if filterSeason6 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 6"
				multipleSeasons = true
			else
				seasonnum = "6"
			end
		end
		if filterSeason7 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 7"
				multipleSeasons = true
			else
				seasonnum = "7"
			end
		end
		if filterSeason8 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 8"
				multipleSeasons = true
			else
				seasonnum = "8"
			end
		end
		if filterSeason9 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 9"
				multipleSeasons = true
			else
				seasonnum = "9"
			end
		end
		if filterSeason10 then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 10"
				multipleSeasons = true
			else
				seasonnum = "10"
			end
		end
  end

	local raritytext = ""
	local multipleRarities = false
	
	if filterRarity then
		if filterRarityR then
			raritytext = "Rare"
		end
		if filterRaritySR then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Super Rare"
				multipleRarities = true
			else
				raritytext = "Super Rare"
			end
		end
		if filterRarityUR then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Ultra Rare"
				multipleRarities = true
			else
				raritytext = "Ultra Rare"
			end
		end
		if filterRarityDC then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Discontinued"
				multipleRarities = true
			else
				raritytext = "Discontinued"
			end
		end
		if filterRarityALT then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Alternate"
				multipleRarities = true
			else
				raritytext = "Alternate"
			end
		end
		if filterRarityDCR then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Discontinued Rare"
				multipleRarities = true
			else
				raritytext = "Discontinued Rare"
			end
		end
		if filterRarityDCSR then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Discontinued Super Rare"
				multipleRarities = true
			else
				raritytext = "Discontinued Super Rare"
			end
		end
		if filterRarityDCUR then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Discontinued Ultra Rare"
				multipleRarities = true
			else
				raritytext = "Discontinued Ultra Rare"
			end
		end
		if filterRarityDCALT then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Discontinued Alternate"
				multipleRarities = true
			else
				raritytext = "Discontinued Alternate"
			end
		end
		if filterRarityALTALT then
			if raritytext ~= "" then
				raritytext = raritytext .. ", Alternate Alternate"
				multipleRarities = true
			else
				raritytext = "Alternate Alternate"
			end
		end
		if filterRarityPICO8 then
			if raritytext ~= "" then
				raritytext = raritytext .. ", PICO-8"
				multipleRarities = true
			else
				raritytext = "PICO-8"
			end
		end
	end		


  local embedtitle = message.author.name .. lang.embed_title
  if filterSeason then
		local filtertitle = ""
		if multipleSeasons then
			if lang.needs_plural_s then
				filtertitle = lang.plural_s .. seasonnum
			else
				filtertitle = " " .. seasonnum
			end
		else
			filtertitle = " " .. seasonnum
		end
		embedtitle = embedtitle .. lang.season_1 .. filtertitle .. lang.season_2
  end

	if filterRarity then
		embedtitle = embedtitle .. lang.rarity_1 .. raritytext .. lang.rarity_2
	end

  if uj.lang == "ko" then
    message.channel:send{
      content = message.author.mentionString .. lang.embed_contains,
      embed = {
        color = 0x85c5ff,
        title = embedtitle,
        description = invstring,
        footer = {
          text =  lang.embed_page_1 .. maxpn .. lang.embed_page_2 .. pagenumber .. lang.embed_page_3,
          icon_url = message.author.avatarURL
        }
      }
    }
  else
    message.channel:send{
      content = message.author.mentionString .. lang.embed_contains,
      embed = {
        color = 0x85c5ff,
        title = embedtitle,
        description = invstring,
        footer = {
          text =  lang.embed_page_1 .. pagenumber .. lang.embed_page_2 .. maxpn .. lang.embed_page_3,
          icon_url = message.author.avatarURL
        }
      }
    }
  end
end
return command
