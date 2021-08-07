local command = {}
function command.run(message, mt,bypass)
  print(message.author.name .. " did !use")
  local time = sw:getTime()

  if not (message.guild or bypass) then
    message.channel:send("Sorry, but you cannot use in DMs!")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local found = true
  local request = string.lower(mt[1])

  ----------------------------PYROWMID------------------------
  if uj.room == 0 or bypass then
    if request == "strange machine" or request == "machine" then 
      if not uj.tokens then uj.tokens = 0 end
      if not uj.items then uj.items = {nothing = true} end
      if wj.ws ~= 506 then
        local itempt = {}
        for k in pairs(itemdb) do
          if uj.items["fixedmouse"] then
            if not uj.items[k] and k ~= "brokenmouse" then table.insert(itempt, k) end
          else
            if not uj.items[k] and k ~= "fixedmouse" then table.insert(itempt, k) end
          end
        end
        if #itempt == 0 then
          message.channel:send('You already have every item that is currently available.')
          return
        end
        if uj.tokens < 2 then
          message.channel:send('You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit two **Tokens**...')
          return
        end
        if not uj.skipprompts then
          ynbuttons(message, {
            color = 0x85c5ff,
            title = "Using Strange Machine...",
            description = 'Will you put two **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')',
          },"usemachine",{})
        else
          local newitem = itempt[math.random(#itempt)]
          uj.items[newitem] = true
          uj.tokens = uj.tokens - 2
          uj.timesused = uj.timesused and uj.timesused + 1 or 1
          message.channel:send('After depositing 2 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **' .. itemfntoname(newitem) .. '**! You put the **'.. itemfntoname(newitem) ..'** with your items.')
        end
      else
        if uj.tokens >= 4 then
          ynbuttons(message, {
          color = 0x85c5ff,
          title = "Using Strange Machine...",
          description = 'Will you put four **Tokens** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')', 
          },"getladder", {})
        else
          message.channel:send('You try to turn the crank, but it does not budge. There is a slot above it that looks like it could fit four **Tokens**...')
        end
      end
    elseif request == "hole" then
      if uj.tokens == nil then uj.tokens = 0 end
      if wj.ws >= 506 or wj.ws < 501 then
        message.channel:send('The **Hole** is not accepting donations at this time.')
        return
      end
      if uj.tokens > 0 then
        ynbuttons(message, {
        color = 0x85c5ff,
        title = "Using Hole...",
        description = 'Will you put a **Token** into the **Hole?** (tokens remaining: ' .. uj.tokens .. ')', 
        },"usehole", {})
      else
        message.channel:send('You have no **Tokens** to offer to the **Hole.**')
      end
    elseif request == "panda"  then    
      if uj.equipped == "coolhat" then
        if not uj.storage.ssss45 then
          message.channel:send("The **Panda** takes one look at your **Cool Hat**, and puts a **Shaun's Server Statistics Sampling #45** card into your storage out of respect.")
          uj.storage.ssss45 = 1
        else
          message.channel:send(':pensive:')
        end
      else
        message.channel:send(':flushed:')
      end
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif request == "throne" then       
      message.channel:send('It appears that the **Throne** is already in use by the **Panda**.')
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif (request == "necklace" or request == "faithfulnecklace" or request == "faithful necklace") and uj.items["faithfulnecklace"] then       
      message.channel:send('You wash off the **Faithful Necklace**, and then immediately drop it on the grimy floor of the **Abandoned Lab**. Whoops.')
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    elseif request == "ladder" then
      if wj.ws >= 507 then
        local embedtitle = "Using the ladder..."
        if not wj.labdiscovered then
          embedtitle = "NEW AREA DISCOVERED: LAB"
          wj.labdiscovered = true
        end
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = embedtitle,
          description = 'As you climb down the **Ladder**, you begin to hear the sound of a large computer whirring. Reaching the bottom reveals the source, a huge terminal, in the middle of an **Abandoned Lab.**',
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/831907381830746162/labfade.gif'
          }
        }}
        uj.room = 1
        dpf.savejson("savedata/worldsave.json", wj)
        dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
        return
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
    else
      found = false
    end
  end
  
  ----------------------------LAB------------------------
  if (uj.room == 1 or bypass) and wj.labdiscovered then
    if request == "spider" or request == "spiderweb" or request == "web" or request == "spider web" then       
      ynbuttons(message, 'Are you okay with seeing a spider?',"spideruse",{})
    elseif request == "table" then 
      message.channel:send{embed = {
        color = 0x85c5ff,
        title = "Using Table...",
        description = 'You dust off the **Table**. But as soon as you look away, the **Table** is covered in dust again.',
      }}
    elseif request == "poster" or request == "catposter" or request == "cat poster"  then 
      if wj.ws ~= 801 then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "What poster?",
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/838793078574809098/blankwall.png'
          }
        }}
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "Using Cat Poster...",
          description = "By **Pull**ing away the **Cat Poster** and putting it up elsewhere in the room, you have revealed a **Scanner**.",
          image = {
            url = 'https://cdn.discordapp.com/attachments/829197797789532181/862883805786144768/scanner.png'
          }
        }}
        wj.ws = 802
      end
    elseif request == "mouse hole" or request == "mouse" or request == "mousehole"  then 
      if uj.equipped == "brokenmouse" then
        ynbuttons(message,{
          color = 0x85c5ff,
          title = "Using Mouse Hole...",
          description = message.author.mentionString .. ', do you want to put your **Broken Mouse** into the **Mouse Hole?**',
        },"usemousehole",{})
      else
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "Using Mouse Hole...",
          description = 'You do not have anything to put into the **Mouse Hole.**',
        }}
      end
    elseif request == "peculiar box" or request == "box" or request == "peculiarbox" then 
      if not uj.lastbox then 
        uj.lastbox = -24
      end
      local cooldown = (uj.equipped == "stainedgloves") and 8 or 11.5
      if uj.lastbox + cooldown > time:toHours() then
        local minutesleft = math.ceil(uj.lastbox * 60 - time:toMinutes() + cooldown * 60)
        local durationtext = ""
        if math.floor(minutesleft / 60) > 0 then
          durationtext = math.floor(minutesleft / 60) .. " hour"
          if math.floor(minutesleft / 60) ~= 1 then durationtext = durationtext .. "s" end
        end
        if minutesleft % 60 > 0 then
          if durationtext ~= "" then durationtext = durationtext .. " and " end
          durationtext = durationtext .. minutesleft % 60 .. " minute"
          if minutesleft % 60 ~= 1 then durationtext = durationtext .. "s" end
        end
        message.channel:send('Please wait ' .. durationtext .. ' before using the box again.')
        return
      end

      if not next(uj.inventory) then
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = "Using Peculiar Box...",
          description = 'You do not have any cards to put into the **Peculiar Box**',
        }}
        return
      end
      
      if not uj.skipprompts then
        ynbuttons(message,{
          color = 0x85c5ff,
          title = "Using Peculiar Box...",
          description = message.author.mentionString .. ', will you put a random **Trading Card** from your inventory in the **Peculiar Box?**.',
        },"usebox",{})
      else
        local iptable = {}
        for k, v in pairs(uj.inventory) do
          for i = 1, v do
            table.insert(iptable, k)
          end
        end

        local givecard = iptable[math.random(#iptable)]
        print("user giving " .. givecard)
        local boxpoolindex = math.random(#wj.boxpool)
        local getcard = wj.boxpool[boxpoolindex]
        
        uj.inventory[getcard] = uj.inventory[getcard] and uj.inventory[getcard] + 1 or 1
        uj.inventory[givecard] = uj.inventory[givecard] - 1
        if uj.inventory[givecard] == 0 then uj.inventory[givecard] = nil end
        
        wj.boxpool[boxpoolindex] = givecard
        
        message.channel:send('<@' .. uj.id .. '> grabs a **' .. fntoname(givecard) .. '** card from '..uj.pronouns["their"]..' inventory and places it inside the box. As it goes in, a **' .. fntoname(getcard) .. '** card shows up in '..uj.pronouns["their"]..' pocket!')

        uj.timesusedbox = uj.timesusedbox and uj.timesusedbox + 1 or 1
        uj.lastbox = time:toHours()
      end
    elseif request == "terminal" then 
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
      if not mt[2] then mt[2] = "" end
      local embedtitle = "Using Terminal..."
      local embeddescription = nil
      local embedimage = nil
      local filename = nil
      if wj.ws < 508 then
        if string.lower(mt[2]) == "gnuthca" then
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838841498757234728/terminal3.png"
          wj.ws = 508
        else
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838841479698579587/terminal4.png"
        end
      else
        if string.lower(mt[2]) == "gnuthca" then
          embeddescription ='`ERROR: USER ALREADY LOGGED IN`'
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
        elseif string.lower(mt[2]) == "cat" then
          embeddescription = '`=^•_•^=`'
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838840001310752788/terminalcat.gif"
        elseif string.lower(mt[2]) == "savedata" then
          embeddescription = '`DATA LOCATED. GENERATING PRINTOUT`'
          filename = "savedata/" .. uj.id .. ".json"
        elseif string.lower(mt[2]) == "teikyou" then
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/849431570103664640/teikyou.png"
        elseif string.lower(mt[2]) == "help" or mt[2] == "" then
          embeddescription = '`AVAILABLE COMMANDS: \nHELP\nSTATS\nUPGRADE\nCREDITS\nSAVEDATA' .. (wj.ws >= 701 and "\nLOGS" or "") .. "`"
          embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838836625391484979/terminal2.gif"
        elseif string.lower(mt[2]) == "stats" then
          if not uj.timespulled then uj.timespulled = 0 end
          if not uj.timesshredded then uj.timesshredded = 0 end
          if not uj.timesprayed then uj.timesprayed = 0 end
          if not uj.timesstored then uj.timesstored = 0 end
          if not uj.timestraded then uj.timestraded = 0 end
          if not uj.timesusedbox then uj.timesusedbox = 0 end
          if not uj.timescardgiven then uj.timescardgiven = 0 end
          if not uj.tokensdonated then uj.tokensdonated = 0 end
          if not uj.timescardreceived then uj.timescardreceived = 0 end
          if not uj.timeslooked then uj.timeslooked = 0 end
          if not uj.timesdoubleclicked then uj.timesdoubleclicked = 0 end
          embeddescription = 'The **Terminal** prints out a slip of paper. It reads:\n`Times Pulled: ' .. uj.timespulled .. '\nTimes Used: ' .. uj.timesused .. '\nTimes Looked: ' .. uj.timeslooked .. '\nTimes Prayed: ' .. uj.timesprayed .. '\nTimes Shredded: ' .. uj.timesshredded .. '\nTimes Stored: ' .. uj.timesstored .. '\nTimes Traded: ' .. uj.timestraded .. '\nTimes Peculiar Box has been Used: ' .. uj.timesusedbox .. '\nTimes Doubleclicked: ' .. uj.timesdoubleclicked .. '\nTokens Donated: ' .. uj.tokensdonated .. '\nCards Given: ' .. uj.timescardgiven .. '\nCards Received: ' .. uj.timescardreceived .. (math.random(100) == 1 and "\nRemember, the Factory is watching!" or "") .. '`'
        elseif string.lower(mt[2]) == "credits" then
          embedtitle = "Credits"
          embeddescription = 'https://docs.google.com/document/d/1WgUqA8HNlBtjaM4Gpp4vTTEZf9t60EuJ34jl2TleThQ/edit?usp=sharing'
        elseif string.lower(mt[2]) == "logs" then
          embedtitle = "Logs"
          embeddescription = 'https://docs.google.com/document/d/1td9u_n-ou-yIKHKU766T-Ue4EdJGYThjcl-MRxRUA5E/edit?usp=sharing'
        elseif string.lower(mt[2]) == "laureladams" and wj.ws >= 701 then
          embedtitle = "Logs"
          embeddescription = "TODO"
          if wj.ws == 701 then wj.ws = 702 end
        elseif string.lower(mt[2]) == "upgrade" then
          if uj.tokens > 0 then
            if not uj.skipprompts then
              ynbuttons(message, {
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
              },"usehole",{})
              return
            else
              uj.tokens = uj.tokens - 1
              uj.timesused = uj.timesused and uj.timesused + 1 or 1
              uj.tokensdonated = uj.tokensdonated and uj.tokensdonated + 1 or 1
              wj.tokensdonated = wj.tokensdonated + 1

              embeddescription = 'The **Terminal** whirrs happily. A printout lets you know that ' .. wj.tokensdonated .. ' tokens have been donated so far.'
              embedimage = upgradeimages[math.random(#upgradeimages)]
            end
          else
            embeddescription = 'Unfortunately, you have no **Tokens** to your name.'
            embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/838894186472275988/terminal5.png"
          end
        elseif string.lower(mt[2]) == "pull" then
          if (wj.ws >= 804) or (wj.ws == 802 and uj.id == wj.specialuser and (not uj.storage.key)) then
            embedtitle = "PULLING CARD... ERROR!"
            embeddescription = '`message.author.mentionString .. " got a **" .. KEY .. "** card! The **" .. KEY .."** card has been added to " .. uj.pronouns["their"] .. "STORAGE. The shorthand form of this card is **" .. newcard .. "**." uj.storage.key = 1 dpf.savejson("savedata/" .. message.author.id .. ".json", uj)`'
            embedimage = "https://cdn.discordapp.com/attachments/829197797789532181/865792363167219722/key.png"

            uj.storage.key = 1
            if wj.ws == 802 then wj.ws = 803 end --bruh
          else
            embeddescription = '`ERROR: CARD PRINTER JAMMED. PLEASE WAIT.`'
          end
        else
          embeddescription = '`COMMAND "' .. mt[2] ..  '" NOT RECOGNIZED`'
        end
        message.channel:send{embed = {
          color = 0x85c5ff,
          title = embedtitle,
          description = embeddescription,
          image = {
            url = embedimage
          },
          footer = {
            text =  message.author.name,
            icon_url = message.author.avatarURL
          }
        }}
        if filename then 
          message.channel:send{
            file = filename
          }
        end
      end
    else
      found = false
    end
  end
  if (not found) and (not bypass) then ----------------------------------NON-ROOM ITEMS GO HERE!-------------------------------------------------
    if request == "token"  then
      if uj.tokens > 0 then
        message.channel:send('You flip a **Token** in the air. It lands on **' .. (math.random(2) and "heads" or "tails") .. '**.')
      else
        message.channel:send('Sadly, you do not have any **Tokens**.')
      end
      uj.timesused = uj.timesused and uj.timesused + 1 or 1
    else
      message.channel:send("Sorry, but I don't know how to use " .. mt[1] .. ".")
    end
  end
  dpf.savejson("savedata/worldsave.json", wj)
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
