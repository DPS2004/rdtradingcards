reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("loaded uj")
  if uj.id == userid then
    print('user1 has reacted')
    
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
      local loops = 0
      local newitem = "nothing"
      while true do --this is bad!
        newitem = itempt[math.random(#itempt)]
        if not uj.items[newitem] then
          if newitem == "brokenmouse" then
            if not uj.items["fixedmouse"] then
              print("found one!")
              print(newitem)
              break
            end
          else
            print("found one!")
            print(newitem)
            break
          end
        end
        loops = loops + 1
        print(loops)
      end
      uj.items[newitem] = true
      uj.tokens = uj.tokens - 2
      local newmessage = reaction.message.channel:send {
        content = 'After depositing 2 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **' .. itemfntoname(newitem) .. '**! You put the **'.. itemfntoname(newitem) ..'** with your items.'
      }
      dpf.savejson(ujf,uj)
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json",ef)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("You decide to not use the **Strange Machine**.")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  