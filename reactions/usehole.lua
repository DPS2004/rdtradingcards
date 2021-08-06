local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if uj.id == userid then
    print('user1 has reacted')
    
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
     
      uj.tokens = uj.tokens - 1
      
      if uj.timesused == nil then
        uj.timesused = 1
      else
        uj.timesused = uj.timesused + 1
      end
      
      if uj.tokensdonated == nil then
        uj.tokensdonated = 1
      else
        uj.tokensdonated = uj.tokensdonated + 1
      end
      if not wj.labdiscovered then
        local newmessage = reaction.message.channel:send {
          content = 'A **Token** has been dropped into the **Hole.** Thank you for your generosity!'
        }
      else
        local upgradeimages = {
          "https://cdn.discordapp.com/attachments/829197797789532181/838908505192661022/upgrade1.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908506496958464/upgrade2.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908508841836564/upgrade3.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908510972280842/upgrade4.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908513119109130/upgrade5.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908515179036742/upgrade6.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908517477253181/upgrade7.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908519876263967/upgrade8.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908522040918066/upgrade9.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908524389203998/upgrade10.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908548205379624/upgrade11.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908558963376128/upgrade12.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908564105723925/upgrade13.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908567347003392/upgrade14.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908570355236914/upgrade15.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908575879135242/upgrade16.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908579901734963/upgrade17.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908584078999583/upgrade18.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908589674332180/upgrade19.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838908616329265212/upgrade20.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838910126554742814/upgrade21.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838910145491894292/upgrade22.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/838910782556733511/upgrade23.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/849420890281345034/upgrade24.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044075704221716/upgrade25.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044088089215046/upgrade26.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044088164188180/upgrade27.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044089305563184/upgrade28.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044089003311105/upgrade29.png",
          "https://cdn.discordapp.com/attachments/829197797789532181/853044859139784725/upgrade30.png"
        }  
        wj.tokensdonated = wj.tokensdonated + 1
        local newmessage = reaction.message.channel:send {
          reaction.message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Using Terminal...",
            description = 'The **Terminal** whirrs happily. A printout lets you know that ' .. wj.tokensdonated .. ' tokens have been donated so far.',
            image = {
              url = upgradeimages[math.random(#upgradeimages)]
            },
            footer = {
              text =  eom.ogmessage.author.name,
              icon_url = eom.ogmessage.author.avatarURL
            }
          }}
        }
      end
      dpf.savejson(ujf,uj)
      
      
      
      if wj.ws == 501 and wj.tokensdonated >= 5 then
        wj.ws = 502
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.ws == 502 and wj.tokensdonated >= 10 then
        wj.ws = 503
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.ws == 503 and wj.tokensdonated >= 15 then
        wj.ws = 504
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end      
      if wj.ws == 504 and wj.tokensdonated >= 20 then
        wj.ws = 505
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.ws == 505 and wj.tokensdonated >= 30 then
        wj.ws = 506
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles... and so does the Strange Machine***'
        }
      end
      if not wj.smellable and wj.tokensdonated >= 100 then
        wj.smellable = true
        local newmessage = reaction.message.channel:send {
          content = '***The Database lets out a loud BEEP, before the Hole above you closes off. The Terminal begins spewing a noxious gas. ***\n.\n..\n...\n***When you wake up, the Hole has opened again, and your sense of Smell feels much more potent.***'
        }

      end
      
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json",ef)
      dpf.savejson("savedata/worldsave.json", wj)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      if not wj.labdiscovered then
        local newmessage = reaction.message.channel:send("You decide to not put a **Token** into the **Hole.** (how rude!)")
      else
        local newmessage = reaction.message.channel:send("You decide to not put a **Token** into the **Terminal.** (how rude!)")
      end
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  