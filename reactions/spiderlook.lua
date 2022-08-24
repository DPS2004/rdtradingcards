local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/look/lab.json")
  print("Loaded uj")

  uj.timeslooked = uj.timeslooked and uj.timeslooked + 1 or 1
  dpf.savejson(ujf, uj)

  if response == "yes" then
    print('user1 has accepted')
    interaction:reply{embed = {
      color = 0x85c5ff,
      title = lang.looking_at_spider,
      description = lang.looking_spider,
      image = {
        url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930162475040798/spider.png'
      }
    }}
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply{embed = {
      color = 0x85c5ff,
      title = lang.looking_at_spiderweb,
      description = lang.looking_spider_nospider,
      image = {
        url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930243249864704/hand.png'
      }
    }}
  end
end
return reaction
