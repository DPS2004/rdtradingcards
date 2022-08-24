local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !storage")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/storage.json", "")
  
  local enableShortNames = false
  local filterSeason = false
  
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
	end
  end

  local storagetable = {}
  local storagestring = ''
  local storagefilter = {}
  
  if filterSeason0 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 0 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason1 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 1 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason2 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 2 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason3 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 3 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason4 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 4 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason5 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 5 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason6 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 6 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason7 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 7 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason8 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 8 then
	    storagefilter[k] = v
	  end
	end
  end
  if filterSeason9 == true then
    for k,v in pairs(uj.storage) do
	  if cdb[k].season == 9 then
	    storagefilter[k] = v
	  end
	end
  end

  pagenumber = math.max(1, pagenumber)

  local numcards = 0
  if filterSeason == true then
    for k in pairs(storagefilter) do numcards = numcards + 1 end
  else
    for k in pairs(uj.storage) do numcards = numcards + 1 end
  end
  local maxpn = math.ceil(numcards / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)

  if filterSeason == true then
    if enableShortNames == true then
		for k,v in pairs(storagefilter) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	else
		for k,v in pairs(storagefilter) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  else
	if enableShortNames == true then
		for k,v in pairs(uj.storage) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	else
		for k,v in pairs(uj.storage) do table.insert(storagetable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  end
  table.sort(storagetable)

  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if storagetable[i] then storagestring = storagestring .. storagetable[i] end
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
  end
	
  local embedtitle = message.author.name .. lang.embed_title
  if filterSeason == true then
	local filtertitle = ""
	if multipleSeasons == true then
		if lang.needs_plural_s == true then
			filtertitle = lang.plural_s .. " " .. seasonnum
		else
			filtertitle = " " .. seasonnum
		end
	else
		filtertitle = " " .. seasonnum
	end
	embedtitle = message.author.name .. lang.embed_title_season_1 .. filtertitle .. lang.embed_title_season_2
  end

  if uj.lang == "ko" then
    message.channel:send{
    content = message.author.mentionString .. lang.embed_contains,
    embed = {
      color = 0x85c5ff,
      title = embedtitle,
      description = storagestring,
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
      title = message.author.name .. lang.embed_title,
      description = storagestring,
      footer = {
        text =  lang.embed_page_1 .. pagenumber .. lang.embed_page_2 .. maxpn .. lang.embed_page_3,
        icon_url = message.author.avatarURL
      }
    }
  }
  end
end
return command
