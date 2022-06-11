local reaction = {}
function reaction.run(message, interaction, data, response)
  local newequip = data.newequip
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    if uj.lastequip + 6 > time:toHours() then
      interaction:reply("An error has occured. Please make sure that you didn't recently equip another item!")
      return
    end

    uj.equipped = newequip
    interaction:reply("<@" .. uj.id .. "> successfully set **" .. itemdb[newequip].name .. "** as " .. uj.pronouns["their"] .. " equipped item.")
    uj.lastequip = time:toHours()

    if uj.sodapt and uj.sodapt.equip then
      uj.lastequip = uj.lastequip + uj.sodapt.equip
      uj.sodapt.equip = nil
      if uj.sodapt == {} then uj.sodapt = nil end
    end
    
    dpf.savejson(ujf, uj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("<@" .. uj.id .. "> has successfully stopped the changing of " .. uj.pronouns["their"] .. " equipped item.")
  end
end
return reaction
