local item = {}

function item.run(uj, ujf, message, mt, interaction)
  message:addReaction("✅")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local boxstring = ""
  for i, v in ipairs(table.sorted(wj.boxpool)) do
    boxstring = boxstring .. "**" .. cdb[v].name .. "**\n"
  end

  uj.consumables["xraygoggles"] = uj.consumables["xraygoggles"] - 1
  if uj.consumables["xraygoggles"] == 0 then uj.consumables["xraygoggles"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

  dpf.savejson(ujf, uj)
  if interaction then interaction:updateDeferred() end
  message.author:send{embed = {
    title = "The Peculiar Box Contains:",
    description = boxstring,
    color = 0x85c5ff,
  }}
end

return item
