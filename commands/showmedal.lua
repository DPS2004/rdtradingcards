local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !showmedal")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!showmedal command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local curfilename = medaltexttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " medal in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " medal in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not uj.medals[curfilename] then
    print("user doesnt have medal")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " medal in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. medalfntoname(curfilename) .. "** medal.")
    end
    return
  end

  print("user has medal")
  message.channel:send{embed = {
    color = 0x85c5ff,
    title = "Showing medal...",
    description = 'Here it is! Your **'.. medalfntoname(curfilename) .. '** medal. The shorthand form is **' .. curfilename .. '**.\n\n*The description on the back reads:*\n> ' .. medaldb[curfilename].description,
    image = {
      url = medaldb[curfilename].embed
    }
  }}
end
return command
