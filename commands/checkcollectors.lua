local command = {}
function command.run(message, mt,mc)
  if not mc then
    mc = message.channel
  end
  print("checking collector's drops for ".. message.author.name)
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  for i,v in ipairs(coll) do
    print("checking for " .. v.receive)
    if not uj.storage[v.receive] then
      print("user does not have " .. v.receive)
      local allcards = true
      for w,x in ipairs(v.require) do
        if not uj.storage[x] then
          allcards = false
        end
      end
      if allcards then
        local newcard = v.receive
        if uj.storage[newcard] == nil then
          uj.storage[newcard] = 1
        else
          uj.storage[newcard] = uj.storage[newcard] + 1
        end
        local ncn = fntoname(newcard)
        -- mc:send('Congratulations! After collecting and storing some other cards, '.. message.author.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their storage.')
        -- mc:send('https://cdn.discordapp.com/attachments/' .. attachmentchannel .. '/' .. getcardembed(newcard) .. '/' .. newcard .. extension)
        mc:send{embed = {
          color = 0x85c5ff,
          title = "Congratulations!",
          description = 'After collecting and storing some other cards, '.. message.author.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their storage.',
          image = {
            url = 'https://cdn.discordapp.com/attachments/' .. attachmentchannel .. '/' .. getcardembed(newcard) .. '/' .. newcard .. '.png'
          }
        }}
      else
        print("no card for you lol")
      end
    else
      print("user already has " .. v.receive)
    end
  end
  dpf.savejson(ujf,uj)
end
return command
  