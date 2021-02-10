local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !search")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local request = mt[1]
    print(request)
    local curfilename = texttofn(request)
    
    print(curfilename)
    if curfilename ~= nil then
      
      local invnum = uj.inventory[curfilename] or 0
      local stornum = uj.storage[curfilename] or 0
      
      message.channel:send("Here is how many **" .. fntoname(curfilename) .. "** cards you have:\n**In your inventory:** ".. invnum .."x\n**In your storage:** ".. stornum.."x")
      
    else
      message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
    end
  
  else
    message.channel:send("Sorry, but the c!search command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  