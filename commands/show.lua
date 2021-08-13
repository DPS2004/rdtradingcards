local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !show")
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!show command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local curfilename = texttofn(mt[1])

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not ((uj.inventory[curfilename] or uj.storage[curfilename])) and (not shophas(curfilename)) then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory or your storage.")
    end
    return
  end

  print("user has card")
  if not getcardspoiler(curfilename) then
    local embeddescription = ""
    if getcarddescription(curfilename) then
      embeddescription = "\n\n*The description on the back reads:*\n> " .. getcarddescription(curfilename)
    end
    message.channel:send{embed = {
      color = 0x85c5ff,
      title = "Showing card...",
      description = 
      'Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.' .. embeddescription,
      image = {
        url = getcardembed(curfilename)
      }
    }}
  else
    print("spiderrrrrrr")
    message.channel:send{
      content = 'Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.',
      file = "card_images/SPOILER_" .. curfilename .. ".png"
    }
    if getcarddescription(curfilename) then
      message.channel:send("The description on the back reads:\n> " .. getcarddescription(curfilename))
    end
  end
end
return command
  