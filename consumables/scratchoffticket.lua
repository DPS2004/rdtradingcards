local item = {}

function item.run(uj,ujf,message,mt)
  local time = sw:getTime()
  uj.consumables.scratchoffticket = uj.consumables.scratchoffticket - 1
  if uj.consumables.scratchoffticket == 0 then
    uj.consumables.scratchoffticket = nil
  end
  if not uj.timesitemused then 
    uj.timesitemused = 1 
  else
    uj.timesitemused = uj.timesitemused + 1
  end
  message.channel:send("You scratch off the marked spaces with a **Token**.")
  if math.random(1,50) == 1 then
    local winnings = math.random(3,6) *10
    uj.tokens = uj.tokens + winnings
    message.channel:send("**We have a winner!** <@" .. uj.id .. '> just won **' .. winnings .. ' Tokens**!')
  else
    message.channel:send("Your ticket was not a winning one... Better luck next time!")
  end
  dpf.savejson(ujf,uj)
  
  
  
  
end
return item