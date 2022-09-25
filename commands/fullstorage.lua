local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullstorage")
  local filename = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(filename, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/fullstorage.json", "")

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

  args = {}
  for substring in mt[1]:gmatch("%S+") do
    table.insert(args, substring)
  end

  if not (args[1] == nil or args[1] == "-s" or args[1] == "-season" or args[1] == "-season0" or args[1] == "-season1" or args[1] == "-season2" or args[1] == "-season3" or args[1] == "-season4" or args[1] == "-season5" or args[1] == "-season6" or args[1] == "-season7" or args[1] == "-season8" or args[1] == "-season9" or args[1] == "-season10" or args[1] == "-rarityr" or args[1] == "-raritysr" or args[1] == "-rarityur" or args[1] == "-raritydc" or args[1] == "-rarityalt" or args[1] == "-raritydcr" or args[1] == "-raritydcsr" or args[1] == "-raritydcur" or args[1] == "-raritydcalt" or args[1] == "-rarityaltalt" or args[1] == "-raritypico8" or args[1] == "-raritypico") then
    filename = usernametojson(args[1])
  end

  if not filename then
    message.channel:send(lang.no_user_1 .. mt[1] .. lang.no_user_2)
    return
  end

  for index, value in ipairs(args) do
    if value == "-s" then
      enableShortNames = true
		elseif value == "-season" then
			enableSeason = true
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

  message:addReaction("✅")
  local uj = dpf.loadjson(filename, defaultjson)
  local numkey = 0
  
  local storetable = {}
  local storestring = ''
  local storesfilter = {}
  
  if filterSeason0 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 0 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason1 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 1 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason2 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 2 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason3 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 3 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason4 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 4 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason5 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 5 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason6 == true then
    for k,v in pairs(uj.storage) do
	  	if cdb[k].season == 6 then
	    	storesfilter[k] = v
	  	end
		end
  end
  if filterSeason7 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 7 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason8 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 8 then
	    storesfilter[k] = v
	  end
	end
  end
  if filterSeason9 == true then
    for k,v in pairs(uj.storage) do
	  	if cdb[k].season == 9 then
	    	storesfilter[k] = v
	  	end
		end
	end
  if filterSeason10 == true then
    for k,v in pairs(uj.storage) do
	  	if cdb[k].season == 10 then
	    	storesfilter[k] = v
	  	end
		end
	end

	local storerfilter = {}

	if filterRarity then
		if filterSeason then
			storerfilter = storesfilter
			for k,v in pairs(storerfilter) do
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
					storerfilter[k] = nil
				end
			end
		else
			if filterRarityR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRaritySR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Super Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityUR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Ultra Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityDC then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Discontinued" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityALT then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Alternate" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityDCR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Discontinued Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityDCSR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Discontinued Super Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityDCUR then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Discontinued Ultra Rare" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityDCALT then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Discontinued Alternate" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityALTALT then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "Alternate Alternate" then
						storerfilter[k] = v
					end
				end
			end
			if filterRarityPICO8 then
				for k,v in pairs(uj.storage) do
					if cdb[k].type == "PICO-8" then
						storerfilter[k] = v
					end
				end
			end
		end
	end
  
  if filterRarity then
    for k in pairs(storerfilter) do numkey = numkey + 1 end
	elseif filterSeason then
		for k in pairs(storesfilter) do numkey = numkey + 1 end
  else
    for k in pairs(uj.storage) do numkey = numkey + 1 end
  end
  
  local seasonnum = ""
  local multipleSeasons = false
  if filterSeason == true then
    if filterSeason0 == true then
			seasonnum = "0"
		end
		if filterSeason1 == true then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 1"
				multipleSeasons = true
			else
				seasonnum = "1"
			end
		end
		if filterSeason2 == true then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 2"
				multipleSeasons = true
			else
				seasonnum = "2"
			end
		end
		if filterSeason3 == true then
			if seasonnum ~= "" then
				seasonnum = seasonnum .. ", 3"
				multipleSeasons = true
			else
				seasonnum = "3"
			end
		end
	if filterSeason4 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 4"
			multipleSeasons = true
		else
			seasonnum = "4"
		end
	end
	if filterSeason5 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 5"
			multipleSeasons = true
		else
			seasonnum = "5"
		end
	end
	if filterSeason6 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 6"
			multipleSeasons = true
		else
			seasonnum = "6"
		end
	end
	if filterSeason7 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 7"
			multipleSeasons = true
		else
			seasonnum = "7"
		end
	end
	if filterSeason8 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 8"
			multipleSeasons = true
		else
			seasonnum = "8"
		end
	end
	if filterSeason9 == true then
		if seasonnum ~= "" then
			seasonnum = seasonnum .. ", 9"
			multipleSeasons = true
		else
			seasonnum = "9"
		end
	end
	if filterSeason10 == true then
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
	
  local embedtitle = lang.embed_title
  if filterSeason then
		local filtertitle = ""
		if multipleSeasons then
			if lang.needs_plural_s then
				filtertitle = lang.plural_s .. " " .. seasonnum
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
  
  local contentstring = (uj.id == message.author.id and lang.embed_your or "<@" .. uj.id .. ">" .. lang.embed_s) .. lang.embed_contains
  local prevstorestring = ''
  if filterRarity then
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(storerfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(storerfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(storerfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(storerfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
  elseif filterSeason then
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(storesfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(storesfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(storesfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(storesfilter) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
	else
		if enableShortNames then
			if enableSeason then
				for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ") " ..  "(Season " .. cdb[k].season .. ")\n") end
			else
				for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
			end
		elseif enableSeason then
			for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
		else
			for k,v in pairs(uj.storage) do table.insert(storetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
		end
  end
  table.sort(storetable)
  for i = 1, numkey do
    storestring = storestring .. storetable[i]
    if #storestring > 4096 then
      message.author:send{
        content = contentstring,
        embed = {
          color = 0x85c5ff,
          title = embedtitle,
          description = prevstorestring
        },
      }
      storestring = storetable[i]
      contentstring = ''
      embedtitle = embedtitle .. lang.embed_cont
    end
    prevstorestring = storestring
  end
  message.author:send{
    content = contentstring,
    embed = {
      color = 0x85c5ff,
      title = embedtitle,
      description = storestring
    },
  }
end
return command
