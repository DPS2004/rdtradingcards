local command = {}
function command.run(message, mt)

  if #mt == 1 then
    print(message.author.name .. " did !showitem")
    print(string.sub(message.content, 0, 8))
    local ujf = ("savedata/" .. message.author.id .. ".json")

    local uj = dpf.loadjson(ujf, defaultjson)
    if not uj.items then
      uj.items = {nothing=true}
      uj.equipped = "nothing"
      dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
    end
    local request = mt[1]
    local curfilename = itemtexttofn(request)
    if curfilename then
      if uj.items[curfilename] then
        message.channel:send {
          content = 'Here it is! Your **'.. itemfntoname(curfilename) .. '**.\nThe description reads: ```'..itemdb[curfilename].description .. '``` The shorthand form is **' .. curfilename .. '**.',
          --file = "medal_images/" .. curfilename .. ".png"
        }
      else
        message.channel:send("Sorry, but you don't have the **" .. itemfntoname(curfilename) .. "** item.")
      end
      
    else
      message.channel:send("Sorry, but I could not find the " .. request .. " item in the database. Make sure that you spelled it right!")
    end
          
  else
    message.channel:send("Sorry, but the c!showitem command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  