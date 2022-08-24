local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local cardchannel = privatestuff.cardchannel or '793993844789870603'
  if not uj.conspt then uj.conspt = "none" end
  if #mt ~= 1 or message.attachment then
    uj.consumables["megaphone"] = uj.consumables["megaphone"] - 1
    if uj.consumables["megaphone"] == 0 then uj.consumables["megaphone"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    dpf.savejson(ujf, uj)

    local text = table.concat(mt, "/", 2):gsub("[<>]", "")

    if interaction then interaction:updateDeferred() end
    if message.guild then message:delete() end
    local newmessage = nil
    if message.attachment then
      local res, body = http.request("GET", message.attachment.url)
      newmessage = client:getChannel(cardchannel):send {
        content = lang.megaphone_message .. "\n" .. text,
        file = { message.attachment.filename, body }
      }
      newmessage:hideEmbeds()
    else
      newmessage = client:getChannel(cardchannel):send(lang.megaphone_message .. "\n" .. text)
      newmessage:hideEmbeds()
    end
    handlemessage(newmessage, text)
  else
    local replying = interaction or message
    replying:reply(lang.megaphone_unused)
  end
end

return item
