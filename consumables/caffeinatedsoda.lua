local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local time = sw:getTime()
  uj.consumables["caffeinatedsoda"] = uj.consumables["caffeinatedsoda"] - 1
  if uj.consumables["caffeinatedsoda"] == 0 then uj.consumables["caffeinatedsoda"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
  local pull = 0
  local pray = 0
  local box = 0
  local equip = 0
  if uj.sodapt then
    if uj.sodapt["pull"] then pull = uj.sodapt["pull"] end
    if uj.sodapt["pray"] then pray = uj.sodapt["pray"] end
    if uj.sodapt["box"] then box = uj.sodapt["box"] end
    if uj.sodapt["equip"] then box = uj.sodapt["equip"] end
  end

  pull = uj.lastpull - time:toHours() + 11.5 + pull
  if pull < 0 then pull = 0 end
  pray = uj.lastprayer - time:toDays() + 23 / 24 + pray
  if pray < 0 then pray = 0 end
  box = uj.lastbox - time:toHours() + 11.5 + box
  if box < 0 then box = 0 end
  equip = uj.lastequip - time:toHours() + 6 + equip
  if equip < 0 then equip = 0 end

  uj.sodapt = { pull = pull, pray = pray, box = box, equip = equip }
  uj.lastpull = -12
  uj.lastprayer = -3
  uj.lastbox = -12
  uj.lastequip = -12
  dpf.savejson(ujf, uj)
  local replying = interaction or message
  replying:reply(lang.caffeinatedsoda_message)
end

return item
