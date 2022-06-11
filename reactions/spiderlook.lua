local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  uj.timeslooked = uj.timeslooked and uj.timeslooked + 1 or 1
  dpf.savejson(ujf, uj)

  if response == "yes" then
    print('user1 has accepted')
    interaction:reply{embed = {
      color = 0x85c5ff,
      title = "Looking at Spider...",
      description = "It's a spider! How cute!",
      image = {
        url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930162475040798/spider.png'
      }
    }}
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply{embed = {
      color = 0x85c5ff,
      title = "Looking at Spiderweb...",
      description = "There is a **Spiderweb** here, but there is no **Spider**. There never **was** and there never **will** be a **Spider** in this location.",
      image = {
        url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930243249864704/hand.png'
      }
    }}
  end
end
return reaction
