command = {}
function command.run(message, mt)
local time = sw:getTime()
  --message.channel:send('haha wowie! discord user '.. message.member.mentionString .. ' whos discord ID happens to be ' .. message.member.user.id ..' you got a card good job my broski')
  print(message.member.name .. " did !pull")
  local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
  if uj.lastpull + 10 <= time:toMinutes() then
    message.channel:send('Pulling card...')
    local newcard = ptable[math.random(#ptable)]
    local ncn = fntoname(newcard)
    print(ncn)
    message.channel:send {
        content = 'Woah! '.. message.member.mentionString ..' got a **'.. ncn ..'!** The **'.. ncn ..'** card has been added to their inventory.',
        file = "card_images/" .. newcard .. ".png"
      }

    local uj = dpf.loadjson("savedata/" .. message.member.user.id .. ".json",defaultjson)
    if uj.inventory[newcard] == nil then
      uj.inventory[newcard] = 1
    else
      uj.inventory[newcard] = uj.inventory[newcard] + 1
    end
    uj.name = message.member.username .. "#".. message.member.discriminator
    uj.id = message.member.user.id
    uj.lastpull = time:toMinutes()
    print(message.member.username .. "#" .. message.member.discriminator .. " is the username")
    print("number of cards is " .. uj.inventory[newcard])
    dpf.savejson("savedata/" .. message.member.user.id .. ".json",uj)
  else
    message.channel:send('Please wait ' .. math.ceil(uj.lastpull + 10 - time:toMinutes()) .. ' minutes before pulling again.')
  end
end
return command
  