local item = {}

function item.run(uj, ujf, message, mt, interaction)
  uj.consumables.scratchoffticket = uj.consumables.scratchoffticket - 1
  if uj.consumables.scratchoffticket == 0 then
    uj.consumables.scratchoffticket = nil
  end
  if not uj.timesitemused then
    uj.timesitemused = 1
  else
    uj.timesitemused = uj.timesitemused + 1
  end
  local replying = interaction or message
  replying:reply("You scratch off the marked spaces with a borrowed **Token**.")
  local chance = math.random(100)
  if chance <= 2 then
    local winnings = math.random(3, 6) * 10
    uj.tokens = uj.tokens + winnings
    message:reply("**We have a winner!** <@" .. uj.id .. '> just won **' .. winnings .. ' Tokens**!')
  elseif chance == 3 then
    --do something funny here
    message:reply("Your ticket was not a winning one... Better luck next time!")
  else
    message:reply("Your ticket was not a winning one... Better luck next time!")
  end
  dpf.savejson(ujf, uj)

end

return item
