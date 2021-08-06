local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  ef[reaction.message.id] = nil
  dpf.savejson("savedata/events.json", ef)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    uj.items.brokenmouse = nil
    uj.items.fixedmouse = true
    uj.equipped = "fixedmouse"

    reaction.message.channel:send('You start to push your **Broken Mouse** into the hole, but two grey furry hands pull it in the rest of the way. You can hear the mouse using a saw to open up the **Broken Mouse**, which seems terribly unsafe! After a few minutes of tinkering, the mouse pushes out a **Fixed Mouse**, complete with a green sticker denoting its newfound functionality. You put the **Fixed Mouse** with your other items.')
    dpf.savejson(ujf,uj)
  end
  
  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not put the **Broken Mouse** in the **Mouse Hole**.")
  end
end
return reaction
