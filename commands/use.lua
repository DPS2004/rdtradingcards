local function adduse(uj)
  if uj.timesused == nil then
    uj.timesused = 1
  else
    uj.timesused = uj.timesused + 1
  end
  return uj
end

local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !use")
  local time = sw:getTime()
  if message.guild then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    if #mt >= 1 or mt[1] == "" then

      if string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" then 
        if uj.tokens == nil then
          uj.tokens = 0
        end
        local numitems = 0
        if uj.items == nil then 
          uj.items = {nothing=true}
        end
        for k,v in pairs(uj.items) do
          numitems = numitems + 1
        end
        if wj.worldstate ~= "largesthole" then
          if numitems < #itempt then
            if uj.tokens >= 2 then
        
              if not uj.skipprompts then
                local newmessage = message.channel:send {
                  content = 'Will you put two **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')'
                }
                addreacts(newmessage)
                --message.channel:send("IF YOU ARE SEEING THIS, SOMETHING HAS GONE WRONG!!!! <@290582109750427648>")
                local tf = dpf.loadjson("savedata/events.json",{})
                tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usemachine",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
                dpf.savejson("savedata/events.json",tf)
              else
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
                uj = adduse(uj)
                local newmessage = message.channel:send {
                  content = 'After depositing 2 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **' .. itemfntoname(newitem) .. '**! You put the **'.. itemfntoname(newitem) ..'** with your items.'
                }
                dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
                
              end
              
            else
              message.channel:send {
                content = 'You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit two **Tokens**...'
              }
            end
          else
            message.channel:send('You already have every item that is currently available.')
          end
        else
          if uj.tokens >= 4 then
            local newmessage = message.channel:send {
              
              content = 'Will you put four **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')'
            }
            addreacts(newmessage)
            local tf = dpf.loadjson("savedata/events.json",{})
            tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "getladder",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
            dpf.savejson("savedata/events.json",tf)
          else
            message.channel:send {
              content = 'You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit four **Tokens**...'
            }
          end
          
        end
      elseif string.lower(mt[1]) == "hole" then
        if uj.tokens == nil then
          uj.tokens = 0
        end
        
        
        if wj.worldstate == "labopen" or wj.worldstate == "largesthole" or wj.worldstate == "terminalopen" or wj.worldstate == "prehole" then
          local newmessage = message.channel:send {
            content = 'The **Hole** is not accepting donations at this time.'
          }
        else
          if uj.tokens > 0 then
            local newmessage = message.channel:send {
              content = 'Will you put a **Token** into the **Hole?** (tokens remaining: ' .. uj.tokens .. ')'
            }
            addreacts(newmessage)
            local tf = dpf.loadjson("savedata/events.json",{})
            tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usehole",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
            dpf.savejson("savedata/events.json",tf)
          else
            local newmessage = message.channel:send {
              content = 'You have no **Tokens** to offer to the **Hole.**'
            }
          end
        end
      elseif string.lower(mt[1]) == "token"  then 
        if uj.tokens > 0 then
          local rnum = math.random(0,1)
          local cflip = ":doctah:"
          if rnum == 0 then
            cflip = "heads"
          else
            cflip = "tails"
          end
          
          message.channel:send {
            
            content = 'You flip a **Token** in the air. It lands on **' .. cflip .. '**.'
          }
        else
          message.channel:send {
            
            content = 'Sadly, you do not have any **Tokens**.'
          }
        end
        uj = adduse(uj)
      elseif string.lower(mt[1]) == "panda"  then    
        if uj.equipped == "coolhat" then
          if not uj.storage.ssss45 then
            message.channel:send {
              
              content = "The **Panda** takes one look at your **Cool Hat**, and puts a **Shaun's Server Statistics Sampling #45** card into your storage out of respect."
            }
            uj.storage.ssss45 = 1
            dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
          else
            
            message.channel:send {
              
              content = ':pensive:'
            }
          end
        else
          message.channel:send {
            
            content = ':flushed:'
          }
        end
        uj = adduse(uj)
      elseif string.lower(mt[1]) == "throne" then       
        message.channel:send {
          
          content = 'It appears that the **Throne** is already in use by the **Panda**.'
        }
        uj = adduse(uj)
      
      elseif string.lower(mt[1]) == "ladder" then
        if wj.worldstate == "labopen" or wj.worldstate == "terminalopen" then
          if not wj.labdiscovered then
            wj.labdiscovered = true
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "NEW AREA DISCOVERED: LAB",
              description = 'As you climb down the **Ladder**, you begin to hear the sound of a large computer whirring. Reaching the bottom reveals the source, a huge terminal, in the middle of an **Abandoned Lab.**',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
              }
            }}

          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using the ladder...",
              description = 'As you climb down the **Ladder**, you begin to hear the sound of a large computer whirring. Reaching the bottom reveals the source, a huge terminal, in the middle of an **Abandoned Lab.**',
              image = {
                url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
              }
            }}
          end
          
        else
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Using the ladder...",
            description = 'You attempt to climb down the **Ladder**. Unfortunately, the **Hole** is still too small for you to fit through. You cannot wiggle your way out of it.',
            image = {
              url = 'https://cdn.discordapp.com/attachments/829197797789532181/831868583696269312/nowigglezone.png'
            }
          }}
        end
      elseif (string.lower(mt[1]) == "spider" or string.lower(mt[1]) == "spiderweb" or string.lower(mt[1]) == "web" or string.lower(mt[1]) == "spider web") and wj.labdiscovered then       
        
          
        local newmessage = message.channel:send {
          content = 'Are you okay with seeing a spider?'
        }
        addreacts(newmessage)

        local tf = dpf.loadjson("savedata/events.json",{})
        tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "spideruse",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
        
        

        dpf.savejson("savedata/events.json",tf)
      elseif (string.lower(mt[1]) == "table") and wj.labdiscovered  then 
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "Using Table...",
          description = 'You dust off the **Table**. But as soon as you look away, the **Table** is covered in dust again.',
        }}
      elseif (string.lower(mt[1]) == "poster" or string.lower(mt[1]) == "catposter" or string.lower(mt[1]) == "cat poster") and wj.labdiscovered  then 
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "What poster?",
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/838793078574809098/blankwall.png'
          }
        }}
      elseif (string.lower(mt[1]) == "mouse hole" or string.lower(mt[1]) == "mouse" or string.lower(mt[1]) == "mousehole") and wj.labdiscovered  then 
        if uj.equipped == "brokenmouse" then
          newmessage = message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Using Mouse Hole...",
            description = message.author.mentionString .. ', do you want to put your **Broken Mouse** into the **Mouse Hole?**',
          }}
          local tf = dpf.loadjson("savedata/events.json",{})
          
          addreacts(newmessage)
          tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usemousehole",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
          
          dpf.savejson("savedata/events.json",tf)
        else
          newmessage = message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Using Mouse Hole...",
            description = 'You do not have anything to put into the **Mouse Hole.**',
          }}
          
          
        end 
      elseif  (string.lower(mt[1]) == "peculiar box" or string.lower(mt[1]) == "box" or string.lower(mt[1]) == "peculiarbox") and wj.labdiscovered  then 
        if not uj.lastbox then 
          uj.lastbox = -24
        end
        local cooldown = 11.5
        if uj.equipped == "stainedgloves" then
          cooldown = 8
        end
        if uj.lastbox + cooldown <= time:toHours() then
          if next(uj.inventory) then
            if not uj.skipprompts then
              newmessage = message.channel:send{embed = {
                color = 0x85c5ff,
                title = "Using Peculiar Box...",
                description = message.author.mentionString .. ', will you put a random **Trading Card** from your inventory in the **Peculiar Box?**.',
              }}
              local tf = dpf.loadjson("savedata/events.json",{})
              
              addreacts(newmessage)
              tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usebox",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
              
              dpf.savejson("savedata/events.json",tf)
            else
              local iptable = {}
              for k,v in pairs(uj.inventory) do
                table.insert(iptable, k)
              end
              local givecard = iptable[math.random(1,#iptable)]
              print("user giving " .. givecard)
              
              local boxpoolindex = math.random(1,#wj.boxpool)
              local getcard = wj.boxpool[boxpoolindex]
              
              if uj.inventory[getcard] == nil then
                uj.inventory[getcard] = 1
              else
                uj.inventory[getcard] = uj.inventory[getcard] + 1
              end
              
              uj.inventory[givecard] = uj.inventory[givecard] - 1
              
              if uj.inventory[givecard] == 0 then
                uj.inventory[givecard] = nil
              end
              
              wj.boxpool[boxpoolindex] = givecard
              message.channel:send {
                content = '<@' .. uj.id .. '> grabs a **' .. fntoname(givecard) .. '** card from '..uj.pronouns["their"]..' inventory and places it inside the box. As it goes in, a **' .. fntoname(getcard) .. '** card shows up in '..uj.pronouns["their"]..' pocket!'
              }
              
              if uj.timesusedbox == nil then
                uj.timesusedbox = 1
              else
                uj.timesusedbox = uj.timesusedbox + 1
              end
              uj.lastbox = time:toHours()
            end
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Peculiar Box...",
              description = 'You do not have any cards to put into the **Peculiar Box**',
            }}
          end
        else

          local minutesleft = math.ceil(uj.lastbox * 60 - time:toMinutes() + cooldown * 60)
          local durationtext = ""
          if math.floor(minutesleft / 60) > 0 then
            durationtext = math.floor(minutesleft / 60) .. " hour"
            if math.floor(minutesleft / 60) ~= 1 then
              durationtext = durationtext .. "s"
            end
          end
          if minutesleft % 60 > 0 then
            if durationtext ~= "" then
              durationtext = durationtext .. " and "
            end
            durationtext = durationtext .. minutesleft % 60 .. " minute"
            if minutesleft % 60 ~= 1 then
              durationtext = durationtext .. "s"
            end
          end
          message.channel:send('Please wait ' .. durationtext .. ' before using the box again.')
          
          
        end
      elseif (string.lower(mt[1]) == "terminal") and wj.labdiscovered  then 
        uj = adduse(uj)
        if not mt[2] then
          mt[2] = ""
        end
        if wj.worldstate == "labopen" then
          
          if string.lower(mt[2]) == "gnuthca" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838841498757234728/terminal3.png"
              },
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
            wj.worldstate = "terminalopen"
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838841479698579587/terminal4.png"
              },
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          end
        else
          if string.lower(mt[2]) == "gnuthca" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              description = '`ERROR: USER ALREADY LOGGED IN`',
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
              },
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          elseif string.lower(mt[2]) == "cat" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              description = '`=^•_•^=`',
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838840001310752788/terminalcat.gif"
              },
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          elseif string.lower(mt[2]) == "help" or mt[2] == "" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              description = '`AVAILABLE COMMANDS: \nHELP\nSTATS\nUPGRADE\nCREDITS`',
              image = {
                url = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
              },
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          elseif string.lower(mt[2]) == "stats" then
            if not uj.timespulled then
              uj.timespulled = 0
            end            
            if not uj.timesshredded then
              uj.timesshredded = 0
            end
            if not uj.timesprayed then
              uj.timesprayed = 0
            end
            if not uj.timesstored then
              uj.timesstored = 0
            end
            if not uj.timestraded then
              uj.timestraded = 0
            end
            if not uj.timesusedbox then
              uj.timesusedbox = 0
            end
            if not uj.timescardgiven then
              uj.timescardgiven = 0
            end
            if not uj.tokensdonated then
              uj.tokensdonated = 0
            end
            if not uj.timescardreceived then
              uj.timescardreceived = 0
            end
            if not uj.timeslooked then
              uj.timeslooked = 0
            end
            if not uj.timesdoubleclicked then
              uj.timesdoubleclicked = 0
            end
            local easteregg = ""
            if math.random(1,100) == 1 then
              easteregg = "\nRemember, the Factory is watching!"
            end
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              description = 'The **Terminal** prints out a slip of paper. It reads:\n`Times Pulled: ' .. uj.timespulled .. '\nTimes Used: ' .. uj.timesused .. '\nTimes Looked: ' .. uj.timeslooked .. '\nTimes Prayed: ' .. uj.timesprayed .. '\nTimes Shredded: ' .. uj.timesshredded .. '\nTimes Stored: ' .. uj.timesstored .. '\nTimes Traded: ' .. uj.timestraded .. '\nTimes Peculiar Box has been Used: ' .. uj.timesusedbox .. '\nTimes Doubleclicked: ' .. uj.timesdoubleclicked .. '\nTokens Donated: ' .. uj.tokensdonated .. '\nCards Given: ' .. uj.timescardgiven .. '\nCards Received: ' .. uj.timescardreceived .. easteregg .. '`',
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
            
          elseif string.lower(mt[2]) == "credits" then
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Credits",
              description = 'https://docs.google.com/document/d/1WgUqA8HNlBtjaM4Gpp4vTTEZf9t60EuJ34jl2TleThQ/edit?usp=sharing',
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          elseif string.lower(mt[2]) == "upgrade" then
            if uj.tokens > 0 then
              if not uj.skipprompts then
                local newmessage = message.channel:send{embed = {
                  color = 0x85c5ff,
                  title = "Using Terminal...",
                  description = 'Will you put a **Token** into the **Terminal?** (tokens remaining: ' .. uj.tokens .. ')',
                  image = {
                    url = "https://cdn.discordapp.com/attachments/829197797789532181/838894186472275988/terminal5.png"
                  },
                  footer = {
                    text =  message.author.name,
                    icon_url = message.author.avatarURL
                  }
                }}
                addreacts(newmessage)
                local tf = dpf.loadjson("savedata/events.json",{})
                tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "usehole",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString, avatarURL = message.author.avatarURL}}}
                dpf.savejson("savedata/events.json",tf)
              else
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
                  "https://cdn.discordapp.com/attachments/829197797789532181/838910782556733511/upgrade23.png"
                }  
                message.channel:send{embed = {
                  color = 0x85c5ff,
                  title = "Using Terminal...",
                  description = 'The **Terminal** whirrs happily.',
                  image = {
                    url = upgradeimages[math.random(1,#upgradeimages)]
                  },
                  footer = {
                    text =  message.author.name,
                    icon_url = message.author.avatarURL
                  }
                }}
                wj.tokensdonated = wj.tokensdonated + 1
              end
            else
              message.channel:send{embed = {
                color = 0x85c5ff,
                title = "Using Terminal...",
                description = 'Unfortunately, you have no **Tokens** to your name.',
                image = {
                  url = "https://cdn.discordapp.com/attachments/829197797789532181/838894186472275988/terminal5.png"
                },
                footer = {
                  text =  message.author.name,
                  icon_url = message.author.avatarURL
                }
              }}
            end
          
          else
            message.channel:send{embed = {
              color = 0x85c5ff,
              title = "Using Terminal...",
              description = '`COMMAND "' .. mt[2] ..  '" NOT RECOGNIZED`',
              footer = {
                text =  message.author.name,
                icon_url = message.author.avatarURL
              }
            }}
          end
        end

      else
        message.channel:send("Sorry, but I don't know how to use " .. mt[1] .. ".")
      end
    
    
    else
      message.channel:send("Sorry, but the c!use command expects 1 argument. Please see c!help for more details.")
    end
    dpf.savejson("savedata/worldsave.json", wj)
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  else
    message.channel:send("Sorry, but you cannot use in DMs!")
  end
end
return command
  
