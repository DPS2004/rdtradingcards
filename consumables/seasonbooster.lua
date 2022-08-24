local item = {}

function item.run(uj, ujf, message, mt, interaction, fn)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local itemname = consdb[fn].name
  local itemtext = consdb[fn].text_en
  if uj.lang == "ko" then
	itemtext = consdb[fn].text_ko
  end
  local season = consdb[fn].season
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables[fn] = uj.consumables[fn] - 1
    if uj.consumables[fn] == 0 then uj.consumables[fn] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "season" .. season
    replying:reply(itemtext)
    --[[local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')]]--
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.seasonbooster_conspt_1 .. itemname .. lang.seasonbooster_conspt_2)
  end
end

return item
