
local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !renamefile")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    if #mt == 2 then
      -- why did i even add this if statement
      if fntoname(mt[2]) then
        for i,v in ipairs(scandir("savedata")) do
          local cuj = dpf.loadjson("savedata/"..v,defaultjson)
          if cuj.id then
              if cuj.inventory[mt[1]] then
                cuj.inventory[mt[2]] = cuj.inventory[mt[1]]
                cuj.inventory[mt[1]] = nil
              end
              if cuj.storage[mt[1]] then
                cuj.storage[mt[2]] = cuj.storage[mt[1]]
                cuj.storage[mt[1]] = nil
              end
          end
          dpf.savejson("savedata/"..v,cuj)
        end
        message.channel:send("Renamed " .. mt[1] .. " to " .. mt[2] .. ".")
      else
        message.channel:send("Sorry, but " .. mt[1] .. " doesn't exist in the database.")
      end
    else
      message.channel:send("Sorry, but the c!renamefile command expects 2 arguments.")
    end
  else
    message.channel:send('Sorry, but only moderators can use this command!')
  end
end
return command
  