local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !smell")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    local request = mt[1]
    print(request)
    local curfilename = texttofn(request)

    print(curfilename)
    if curfilename ~= nil then
      if uj.inventory[curfilename] or uj.storage[curfilename] then
        print("user has card")

        local beginnings = {
          "You pull out your **____** card and smell it.",
          "You pull out your **____** card and give it a whiff.",
          "You take out your **____** card and put it up your nose.",
          "You whip out your **____** card and shove it in your face.",
          --"You pull out your **____** card and a doctah pops out.",
          "You pry out your crumpled **____** card. It has lines eminating off it."
          --"Your **____** card is not encased in a peanut."
        }
        local random_beginning = beginnings[math.random(#beginnings)]
        message.channel:send(random_beginning:gsub("____", fntoname(curfilename)))

        local smell = getcardsmell(curfilename)
        if smell then
          local descriptions = {
            "The smell fondly reminds you of **____**",
            "It reeks of **____**",
            "Actually, you taste it. The card tastes like **____**",
            "A foreign voice enters your mind. It talks about **____**",
            --"The Panda smites you with the power of **____**",
            "A nostalgic memory of **____** passes over you",
            "You suddenly have an intense feeling of yearning for **____**"
            --"Dramatic Message Here, Description: **____**"
          }
          local random_description = descriptions[math.random(#descriptions)]

          message.channel:send(random_description:gsub("____", smell))
        end
      
      else
        print("user doesnt have card")
        if nopeeking then
          message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
        else
          message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory or your storage.")
        end
      end
    elseif string.lower(request) == "panda" then --YanDPSdev :pensive:
      message.channel:send("The **Panda** smells of bamboo and needs to shower.")
    elseif string.lower(request) == "pyrowmid" and wj.smellable then
      message.channel:send("The **Pyrowmid** smells familiar, but not too familiar.")
    elseif string.lower(request) == "throne" and wj.smellable then
      message.channel:send("The **Throne** smells like cardstock.")
    elseif (string.lower(request) == "strange machine" or string.lower(request) == "machine") and wj.smellable then 
      message.channel:send("The **Strange Machine** smells metallic, reminding you of the scent of a **Token**.")
    elseif string.lower(request) == "token" and wj.smellable then
      message.channel:send("A **Token** smells like a normal coin. What did you expect?")
    elseif string.lower(request) == "factory" and wj.smellable then
      message.channel:send("Smells like smog.")
    elseif string.lower(request) == "ladder" and wj.smellable then
      message.channel:send("The **Ladder** smells brand new, even though it has been sitting out for a while.")
    elseif string.lower(request) == "hole" and wj.smellable then
      message.channel:send("The **Hole** smells like a strange combination of dirt and electricity.")
    elseif (string.lower(request) == "spider" or string.lower(request) == "spiderweb" or string.lower(request) == "spider web" or string.lower(request) == "web") and wj.smellable then
      local newmessage = message.channel:send {
        content = 'Are you okay with smelling a spider?'
      }
      addreacts(newmessage)

      local tf = dpf.loadjson("savedata/events.json",{})
      tf[newmessage.id] ={ujf = "savedata/" .. message.author.id .. ".json",etype = "spidersmell",ogmessage = {author = {name=message.author.name, id=message.author.id,mentionString = message.author.mentionString}}}
      

      dpf.savejson("savedata/events.json",tf)
      
    elseif (string.lower(request) == "lab" or string.lower(request) == "abandoned lab") and wj.smellable then
      message.channel:send("The **Abandoned Lab** smells strongly of machines and dust.")
    
    elseif (string.lower(request) == "terminal" or string.lower(request) == "database") and wj.smellable then
      message.channel:send("Both the **Terminal** and the **Database** still smell strongly of the gas that they released once you collectively deposited 100 tokens. ")
      
    elseif string.lower(request) == "table" and wj.smellable then
      message.channel:send("As you go to take a sniff of the **Table**, you end up with a noseful of dust.")
    
    elseif (string.lower(request) == "poster" or string.lower(request) == "cat poster") and wj.smellable then
      message.channel:send("The **Cat Poster** smells like lots of different things at the same time.")
      
    elseif (string.lower(request) == "mouse hole" or string.lower(request) == "mouse" or string.lower(request) == "mousehole") and wj.smellable then
      message.channel:send("The **Mouse Hole** smells like screen cleaner and screwdrivers.")
    
    elseif (string.lower(request) == "peculiar box" or string.lower(request) == "box" or string.lower(request) == "peculiarbox") and wj.smellable then
      message.channel:send("Oddly enough, the **Peculiar Box** smells of nothing at all.")
      
    
    else
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
      end
    end

  else
    message.channel:send("Sorry, but the c!smell command expects 1 argument. Please see c!help for more details.")
  end
end
return command
