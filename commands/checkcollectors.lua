local command = {}
function command.run(message, mt,mc)
  if not mc then
    mc = message.channel
  end
  print("checking collector's drops for ".. message.author.name)
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/checkcollectors.json", "")
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
        local ncn = cdb[newcard].name
        if not cdb[newcard].spoiler then
          mc:send{embed = {
            color = 0x85c5ff,
            title = lang.congratulations,
            description = lang.gotcard_1 .. message.author.mentionString .. lang.gotcard_2 .. ncn .. lang.gotcard_3 .. ncn .. lang.gotcard_4 ..uj.pronouns["their"].. lang.gotcard_5,
            image = {
              url = cdb[newcard].embed
            }
          }}
        else
          mc:send{
          content = "**" .. lang.congratulations .. "**\n" .. lang.gotcard_1 .. message.author.mentionString .. lang.gotcard_2 .. ncn .. lang.gotcard_3 .. ncn .. lang.gotcard_4 .. uj.pronouns["their"] .. lang.gotcard_5,
          file = "card_images/SPOILER_" .. newcard .. ".png"
        }
        end
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
  
