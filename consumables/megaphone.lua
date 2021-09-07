local item = {}

function item.run(uj,ujf,message,mt)
  local cardchannel = privatestuff.cardchannel or '793993844789870603'
  if not uj.conspt then uj.conspt = "none" end
  if #mt ~= 1 or message.attachment then
    uj.consumables["megaphone"] = uj.consumables["megaphone"] - 1
    if uj.consumables["megaphone"] == 0 then uj.consumables["megaphone"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    dpf.savejson(ujf, uj)
    
    local text = table.concat(mt, "/", 2):gsub("[<>]", "")

    if message.guild then message:delete() end
    local newmessage = nil
    if message.attachment then
      local res, body = http.request("GET", message.attachment.url)
      newmessage = client:getChannel(cardchannel):send{
        content = "A message comes through the **Megaphone**:\n" .. text,
        file = {message.attachment.filename, body}
      }
      newmessage:hideEmbeds()
    else
      newmessage = client:getChannel(cardchannel):send("A message comes through the **Megaphone**:\n" .. text)
      newmessage:hideEmbeds()
    end
    handlemessage(newmessage, text)
  else
    message.channel:send("The megaphone was not used. Please attach a message with c!use megaphone/(YOUR MESSAGE HERE)")
  end
end
return item