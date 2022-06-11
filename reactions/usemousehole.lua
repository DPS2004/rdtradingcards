local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    uj.items.brokenmouse = nil
    uj.items.fixedmouse = true
    uj.equipped = "fixedmouse"

    interaction:reply('You start to push your **Broken Mouse** into the hole, but two grey furry hands pull it in the rest of the way. You can hear the mouse using a saw to open up the **Broken Mouse**, which seems terribly unsafe! After a few minutes of tinkering, the mouse pushes out a **Fixed Mouse**, complete with a green sticker denoting its newfound functionality. You put the **Fixed Mouse** with your other items.')
    dpf.savejson(ujf,uj)
  end
  
  if response == "no" then
    print('user1 has denied')
    interaction:reply("You decide to not put the **Broken Mouse** in the **Mouse Hole**.")
  end
end
return reaction
