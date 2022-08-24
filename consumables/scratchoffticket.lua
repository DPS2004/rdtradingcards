local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
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
  replying:reply(lang.scratchoffticket_use)
  local chance = math.random(100)
  if chance <= 2 then
    local winnings = math.random(3, 6) * 10
    uj.tokens = uj.tokens + winnings
    message:reply(lang.scratchoffticket_won_1 .. uj.id .. lang.scratchoffticket_won_2 .. winnings .. lang.scratchoffticket_won_3)
  elseif chance == 3 then
    message:reply{
      content = lang.scratchoffticket_lost,
      file = "assets/keep_gambling.jpg"
    }
  else
    message:reply(lang.scratchoffticket_lost)
  end
  dpf.savejson(ujf, uj)

end

return item
