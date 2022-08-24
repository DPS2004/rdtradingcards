local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !fullinventory")
  local filename = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(filename, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/fullinventory.json", "")

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

  args = {}
  for substring in mt[1]:gmatch("%S+") do
    table.insert(args, substring)
  end

  if not (args[1] == nil or args[1] == "-s" or args[1] == "-season0" or args[1] == "-season1" or args[1] == "-season2" or args[1] == "-season3" or args[1] == "-season4" or args[1] == "-season5" or args[1] == "-season6" or args[1] == "-season7" or args[1] == "-season8" or args[1] == "-season9") then
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
    end
  end

  message:addReaction("✅")
  local uj = dpf.loadjson(filename, defaultjson)
  local numkey = 0

  local invtable = {}
  local invstring = ''
  local invfilter = {}
  
  if filterSeason0 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 0 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason1 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 1 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason2 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 2 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason3 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 3 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason4 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 4 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason5 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 5 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason6 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 6 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason7 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 7 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason8 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 8 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason9 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 9 then
	    invfilter[k] = v
	  end
	end
  end
  
  if filterSeason == true then
    for k in pairs(invfilter) do numkey = numkey + 1 end
  else
    for k in pairs(uj.inventory) do numkey = numkey + 1 end
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
	
  local embedtitle = lang.embed_title
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
	embedtitle = lang.embed_title_season_1 .. filtertitle .. lang.embed_title_season_2
  end
  
  local contentstring = (uj.id == message.author.id and lang.embed_your or "<@" .. uj.id .. ">" .. lang.embed_s) .. lang.embed_contains
  local previnvstring = ''
  if filterSeason == true then
    if enableShortNames == true then
		for k,v in pairs(invfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	else
		for k,v in pairs(invfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  else
	if enableShortNames == true then
		for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	else
		for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  end
  table.sort(invtable)
  for i = 1, numkey do
    invstring = invstring .. invtable[i]
    if #invstring > 4096 then
      message.author:send{
        content = contentstring,
        embed = {
          color = 0x85c5ff,
          title = embedtitle,
          description = previnvstring
        },
      }
      invstring = invtable[i]
      contentstring = ''
      embedtitle = embedtitle .. embed_cont
    end
    previnvstring = invstring
  end
  message.author:send{
    content = contentstring,
    embed = {
      color = 0x85c5ff,
      title = embedtitle,
      description = previnvstring
    },
  }
end
return command
