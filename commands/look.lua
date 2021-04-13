local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !look")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if #mt == 1 or mt[1] == "" then
    if texttofn(mt[1]) then
      cmd.show.run(message, mt)
    elseif itemtexttofn(mt[1]) then
      cmd.showitem.run(message, mt)
    elseif medaltexttofn(mt[1]) then
      cmd.showmedal.run(message, mt)
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
        message.channel:send {
          content = 'The **Strange Machine** appears to have a slot for two **Tokens**, and a crank. The crank is worn, as if it has been **Used** many times.'
        }
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

  --  elseif string.lower(mt[1]) == "lab" or string.lower(mt[1]) == "abandoned lab" then 
  --    message.channel:send {
  --      content = ':eye:`the card factory looks back`:eye:'
  --    }
      else
        message.channel:send("Sorry, but I cannot find " .. mt[1] .. ".")
      end
    end
  else
    message.channel:send("Sorry, but the c!look command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  