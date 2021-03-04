local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !smell")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local request = mt[1]
    print(request)
    local curfilename = texttofn(request)

    print(curfilename)
    if curfilename ~= nil then
      local extension = ""
      local animated = getcardanimated(curfilename)
      local pico8 = getcardpico(curfilename)
      if animated then
        extension = ".gif"
      elseif pico8 then
        extension = ".p8.png"
      else
        extension = ".png"
      end
      if uj.inventory[curfilename] or uj.storage[curfilename] then
        print("user has card")

        beginnings = {
          "You pull out your **____** card and smell it.",
          "You pull out your **____** card and give it a whiff.",
          "You take out your **____** card and put it up your nose.",
          "You whip out your **____** card and shove it in your face.",
          "You pull out your **____** card and a doctah pops out.",
          "You pry out your crumpled **____** card. It has lines eminating off it.",
          "Your **____** card is not encased in a peanut."
        }
        random_beginning = beginnings[math.random(#beginnings)]
        message.channel:send(random_beginning:gsub("____", fntoname(curfilename)))

        local smell = getcardsmell(curfilename)
        if smell then
          descriptions = {
            "The smell fondly reminds you of **____**",
            "It reeks of **____**",
            "Actually, you taste it. The card tastes like **____**",
            "A foreign voice enters your mind. It talks about **____**",
            --"The Panda smites you with the power of **____**",
            "A nostalgic memory of **____** passes over you",
            "You suddenly have an intense feeling of yearning for **____**",
            "Dramatic Message Here, Description: **____**"
          }
          random_description = descriptions[math.random(#descriptions)]

          message.channel:send(random_description:gsub("____", smell))
        end
      else
        print("user doesnt have card")
        message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory or your storage.")
      end
    else
      message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
    end

  else
    message.channel:send("Sorry, but the c!smell command expects 1 argument. Please see c!help for more details.")
  end
end
return command
