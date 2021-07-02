local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !look")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if uj.timeslooked == nil then
    uj.timeslooked = 1
  else
    uj.timeslooked = uj.timeslooked + 1
  end
  if message.guild then
    if #mt == 1 or mt[1] == "" then
      if uj.inventory[texttofn(mt[1])] or uj.storage[texttofn(mt[1])] or uj.items[itemtexttofn(mt[1])] or uj.medals[medaltexttofn(mt[1])] then
        if texttofn(mt[1]) then
          cmd.show.run(message, mt)
        elseif itemtexttofn(mt[1]) then
          cmd.showitem.run(message, mt)
        elseif medaltexttofn(mt[1]) then
          cmd.showmedal.run(message, mt)
        end
      else
        if string.lower(mt[1]) == "pyrowmid" then
          -- message.channel:send('The **Pyrowmid** has recently opened itself, revealing a **Panda** and a **Strange Machine** inside. The walls are made of Rows (Rare) cards.')
          -- message.channel:send('https://cdn.discordapp.com/attachments/829197797789532181/829255814169493535/pyr7.png')
          if wj.worldstate == "prehole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'The **Pyrowmid** has recently opened itself, revealing a **Panda** and a **Strange Machine** inside. The walls are made of Rows (Rare) cards.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/829255814169493535/pyr7.png'
              }
            }}
          elseif wj.worldstate == "tinyhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A very small **Hole** has appeared next to the **Pyrowmid**. The **Panda** is looking at it with a worried look on his face. The **Strange Machine** continues to be strange.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831189023426478170/pyrhole.png'
              }
            }}
          elseif wj.worldstate == "smallhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A small **Hole** has appeared next to the **Pyrowmid**. The **Panda** is looking at it with a worried look on his face. The **Strange Machine** continues to be strange.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831191711917146183/pyrhole2.png'
              }
            }}
          elseif wj.worldstate == "mediumhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A **Hole** has appeared next to the **Pyrowmid**. The **Panda** is looking at it with a very worried look on his face. The **Strange Machine** seems normal in comparison to all this.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831192398524710982/pyrhole3.png'
              }
            }}
          elseif wj.worldstate == "largehole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A somewhat large **Hole** has appeared next to the **Pyrowmid**. The **Panda** is looking at it with a very worried look on his face. The **Strange Machine** seems normal in comparison to all this.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831263091470630922/pyrhole4.png'
              }
            }}
          elseif wj.worldstate == "largerhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A large **Hole** has appeared next to the **Pyrowmid**. The **Panda** is looking at it with an extremely worried look on his face. The **Strange Machine** is making a strange noise.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831223296112066560/pyrhole5.png'
              }
            }}
          elseif wj.worldstate == "largesthole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A very large **Hole** has appeared next to the **Pyrowmid**. It looks large enough to go in, but you have no way of doing so. The **Panda** is looking at it with an extremely worried look on his face. The **Strange Machine** is vibrating intensely.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831225534834802769/pyrhole6.png'
              }
            }}
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Pyrowmid...",
              description = 'A very large **Hole** has appeared next to the **Pyrowmid**. If you **Used** the ladder propped up inside it, you could probably climb down it. The **Panda** is looking at it with a worried look on his face. The **Strange Machine** is being strange.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831291533915324436/pyrholefinal.png'
              }
            }}
          
          end

        elseif string.lower(mt[1]) == "panda" or string.lower(mt[1]) == "het" then 
          
          message.channel:send {
            content = 'The **Panda** looks confused, and probably would rather not be here in the **Pyrowmid**. That **Throne** he is sitting on sure does look comfortable, though.'
          }
        elseif string.lower(mt[1]) == "throne" then 
          message.channel:send {
            content = 'The **Throne**, like the walls of the **Pyrowmid** are made of Rows (Rare) cards. It is unknown how it is being held together.'
          }
        elseif string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" then 
          if wj.worldstate == "largesthole" then
            message.channel:send {
              content = 'The **Strange Machine** appears to have a slot for four **Tokens**, and a crank. The crank is worn, as if it has been **Used** many times. The machine is shaking vigorously.'
            }          
          else
            message.channel:send {
              content = 'The **Strange Machine** appears to have a slot for two **Tokens**, and a crank. The crank is worn, as if it has been **Used** many times.'
            }
          end
        elseif string.lower(mt[1]) == "card factory" or string.lower(mt[1]) == "factory" or string.lower(mt[1]) == "cardfactory" or string.lower(mt[1]) == "the card factory" then 
          message.channel:send {
            content = ':eye:`the card factory looks back`:eye:'
          }
        elseif string.lower(mt[1]) == "token"  then 
          -- message.channel:send('You do not know how, but lots of these **Tokens** have been showing up recently. If only there were somewhere to **Use** them...')
          -- message.channel:send('https://cdn.discordapp.com/attachments/829197797789532181/829255830485598258/token.png')
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Token...",
            description = 'You do not know how, but lots of these **Tokens** have been showing up recently. If only there were somewhere to **Use** them...',
            image = {
              url = 'https://cdn.discordapp.com/attachments/829197797789532181/829255830485598258/token.png'
            }
          }}
        elseif string.lower(mt[1]) == "hole" then
        
        
          if wj.worldstate == "prehole" then
            message.channel:send{
              content = 'what hole?'
            }
          elseif wj.worldstate == "tinyhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A very small **Hole** has appeared next to the **Pyrowmid**. A **Token** could probably fit in it, but just barely.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279975153754/holeclose.png' --holeclose.png
              }
            }}
          elseif wj.worldstate == "smallhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A small **Hole** has appeared next to the **Pyrowmid**. A **Token** would definitely fit in.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507280905633812/holeclose2.png'
              }
            }}
          elseif wj.worldstate == "mediumhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A **Hole** has appeared next to the **Pyrowmid**. It craves more **Tokens**.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507281941495948/holeclose3.png'
              }
            }}
          elseif wj.worldstate == "largehole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A somewhat large **Hole** has appeared next to the **Pyrowmid**. It craves yet more **Tokens**.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507283624198174/holeclose4.png'
              }
            }}
          elseif wj.worldstate == "largerhole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A large **Hole** has appeared next to the **Pyrowmid**. It is vibrating very slightly from its proximity to the **Strange Machine**.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507285242150922/holeclose5.png'
              }
            }}
          elseif wj.worldstate == "largesthole" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A very large **Hole** has appeared next to the **Pyrowmid**. It looks large enough to go in, but you have no way of doing so. It is vibrating intensely from its proximity to the **Strange Machine**.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507288165449728/holeclose6.png'
              }
            }}
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Hole...",
              description = 'A very large **Hole** has appeared next to the **Pyrowmid**. If you **Used** the ladder propped up inside it, you could probably climb down it.',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279164997642/holeclosefinal.png' --TODO
              }
            }}
          
          end
        elseif (string.lower(mt[1]) == "spider" or string.lower(mt[1]) == "spiderweb" or string.lower(mt[1]) == "web" or string.lower(mt[1]) == "spider web") and wj.labdiscovered then       
          
            
          local newmessage = ynbuttons(message,'Are you okay with seeing a spider?',"spiderlook",{})
--          addreacts(newmessage)
--          local tf = dpf.loadjson("savedata/events.json",{})
--          tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "spiderlook",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
--          dpf.savejson("savedata/events.json",tf)
          
        
        elseif (string.lower(mt[1]) == "lab" or string.lower(mt[1]) == "abandoned lab") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Lab...",
            description = 'The **Abandoned Lab** was revealed after a **Hole** appeared next to the **Pyrowmid**. Judging by the presence of a **Spider Web**, it has not been used for quite some time, but the technology here looks relatively modern. The **Database** and the connected **Terminal** juxtapose the cheery **Cat Poster**. The **Table** on the other side of the room is caked in dust.',
            image = {
              url = labimages[getletterindex(string.sub(wj.lablooktext, wj.lablookindex + 1, wj.lablookindex + 1))]
            }
          }}
          wj.lablookindex = wj.lablookindex + 1
          
          wj.lablookindex = wj.lablookindex % string.len(wj.lablooktext)
          dpf.savejson("savedata/worldsave.json", wj)
          
        elseif (string.lower(mt[1]) == "terminal") and wj.labdiscovered  then  --FONT IS MS GOTHIC AT 24PX, 8PX FOR SMALL FONT
          if wj.worldstate == "labopen" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Terminal...",
              description = 'The monitor of the **Terminal** is currently on. It is asking for a password.',
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838832581147361310/terminal1.png"
              }
            }}
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Looking at Terminal...",
              description = 'The monitor of the **Terminal** is currently on. A command prompt is freely available.',
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
              }
            }}
          end
        
        elseif (string.lower(mt[1]) == "database") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Database...",
            description = 'The **Database** towers over you, its lights constantly flashing. What could they mean?',
            image = {
              url = labimages[getletterindex(string.sub(wj.lablooktext, wj.lablookindex + 1, wj.lablookindex + 1))]
            }
          }}
          wj.lablookindex = wj.lablookindex + 1
          
          wj.lablookindex = wj.lablookindex % string.len(wj.lablooktext)
          dpf.savejson("savedata/worldsave.json", wj)
        
        elseif (string.lower(mt[1]) == "table") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Table...",
            description = 'The dusty **Table** has a **Peculiar Box** on it, emitting a soft hum. Underneath the table is a **Mouse Hole**, with a sign reading "I.T." above it.',
          }}
        
        
        elseif (string.lower(mt[1]) == "poster" or string.lower(mt[1]) == "catposter" or string.lower(mt[1]) == "cat poster") and wj.labdiscovered  then 
          local postermessage = {'The **Cat Poster** depicts a cat hanging from a branch. It looks quite pleased to be there.', 'The **Cat Poster**, despite its name, contains no cats. There never was a cat here.','The **Cat Poster** looks back.',"The **Cat Poster** is really less of a poster and more of an anatomical image of a cat. It would not look out of place in a vet's office.", 'The **Cat Poster** looks very worn out. You can barely make out the cat and the branch.', 'The **Cat Poster** contains a map of the area with certain spots marked on it. Once could only presume that cats could be found at these locations.','The **Cat Poster** is a sheet of A4 paper that says "cat" on it. The letters are in the most plain and boring font imaginable.', "The `cat` **Poster** is a printout of the wikipedia article on the Unix `cat` command. How Informative!", "The **CATS Poster** is a poster of a very outdated meme. It still makes you chuckle, though.","The Cat Poster features a photo of a resting cat. She appears to be well-loved. The photo makes you feel nice.", "The Cat Poster has an image of a strange-looking cat, but at least the cat looks happy." }
          local posterimage = {"https://cdn.discordapp.com/attachments/829197797789532181/838962876751675412/poster1.png","https://cdn.discordapp.com/attachments/829197797789532181/839214962786172928/poster3.png","https://cdn.discordapp.com/attachments/829197797789532181/838791958905618462/poster4.png","https://cdn.discordapp.com/attachments/829197797789532181/838799811813441607/poster6.png","https://cdn.discordapp.com/attachments/829197797789532181/838937070616444949/poster7.png","https://cdn.discordapp.com/attachments/829197797789532181/838819064884232233/poster8.png","https://cdn.discordapp.com/attachments/829197797789532181/838799792267067462/poster9.png","https://cdn.discordapp.com/attachments/829197797789532181/838864622878588989/poster10.png","https://cdn.discordapp.com/attachments/829197797789532181/838870206687346768/poster11.png","https://cdn.discordapp.com/attachments/829197797789532181/839214999884398612/poster12.png","https://cdn.discordapp.com/attachments/829197797789532181/839215023662039060/poster13.png"}
          local cposter = math.random(1, #postermessage)
          
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Cat Poster...",
            description = postermessage[cposter],
            image = {
              url = posterimage[cposter]
            }
          }}
        
        elseif (string.lower(mt[1]) == "mouse hole" or string.lower(mt[1]) == "mouse" or string.lower(mt[1]) == "mousehole") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Mouse Hole...",
            description = 'The **Mouse Hole** is directly underneath a yellow sign that says "I.T.". The hole is just about wide enough to fit a computer mouse into.',
          }}
        elseif (string.lower(mt[1]) == "peculiar box" or string.lower(mt[1]) == "box" or string.lower(mt[1]) == "peculiarbox") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Peculiar Box...",
            description = 'The **Peculiar Box** rests on top of the **Table**. The opening on the top of it almost beckons for a **Trading Card** to be placed inside.',
          }}
        
        
        
        
        elseif (string.lower(mt[1]) == "ladder") and wj.labdiscovered  then 
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Looking at Ladder...",
            description = 'The **Ladder** feels too big to fit in a capsule, but that\'s where it came from. It is currently propped up in the **Hole**.',
            image = {
              url = 'https://cdn.discordapp.com/attachments/829197797789532181/831507279164997642/holeclosefinal.png'
            }
          }}
        else
          message.channel:send("Sorry, but I cannot find " .. mt[1] .. ".")
          uj.timeslooked = uj.timeslooked - 1
        end
      end
    else
      message.channel:send("Sorry, but the c!look command expects 1 argument. Please see c!help for more details.")
    end
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end
end
return command
  