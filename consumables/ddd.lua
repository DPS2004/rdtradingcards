local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  if not uj.conspt then uj.conspt = "none" end
  if #mt ~= 1 or message.attachment then
    uj.consumables["..."] = uj.consumables["..."] - 1
    if uj.consumables["..."] == 0 then uj.consumables["..."] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    dpf.savejson(ujf, uj)

    local item1 = texttofn(table.concat(mt, "/", 2):gsub("[<>]", ""))

    if interaction then interaction:updateDeferred() end
      if not item1 then
        message.channel:send(lang.ddd_no_item_1 .. mt[2] .. lang.ddd_no_item_2)
        return
      end

      if not uj.storage[item1] then
        message.channel:send(lang.ddd_dont_have_1 .. cdb[item1].name .. lang.ddd_dont_have_2)
        return
      end

      print("success!!!!!")
      local numcards = 1
      uj.storage[item1] = uj.storage[item1] - numcards
      if uj.storage[item1] == 0 then uj.storage[item1] = nil end
      uj.inventory[item1] = uj.inventory[item1] and uj.inventory[item1] + numcards or numcards


      if uj.lang == "ko" then
        message.channel:send(lang.ddd_use_1 .. uj.id .. lang.ddd_use_2 .. cdb[item1].name .. lang.ddd_use_3)
      else
        message.channel:send(lang.ddd_use_1 .. uj.id .. lang.ddd_use_2 .. cdb[item1].name .. lang.ddd_use_3 .. uj.pronouns["their"] .. lang.ddd_use_4)
        end
      dpf.savejson(ujf, uj)
        cmd.checkcollectors.run(message, mt)
        cmd.checkmedals.run(message, mt)
      else
    local replying = interaction or message
    replying:reply(lang.ddd_unused)
  end
end

return item
