local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  local sj = dpf.loadjson("savedata/shop.json", defaultshopsave)
  local request = eom.crequest
  print("Loaded uj")
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    --sanity check
    local checked = (uj.consumables[request])

    
    if not checked then
      reaction.message.channel:send("An error has occured. Please make sure that you still have the item!")
      return
    end
    fn = request
    if getconscommand(request) then
      request = getconscommand(request)
    end
    
    cmdcons[request].run(uj,ujf,client:getChannel(eom.ogmessage.channel.id):getMessage(eom.ogmessage.id),eom.mt,fn) -- this is the single worst line of code that i have ever written
    
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not use the **".. consfntoname(eom.crequest) .."**.")
  end
end
return reaction
