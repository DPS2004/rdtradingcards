local item = {}

function item.run(uj,ujf,message,mt)
  local cardchannel = privatestuff.cardchannel or '793993844789870603'
  if not uj.conspt then uj.conspt = "none" end
  if #mt == 2 then
    uj.consumables["megaphone"] = uj.consumables["megaphone"] - 1
    if uj.consumables["megaphone"] == 0 then uj.consumables["megaphone"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    local text = mt[2]:gsub("<","")
    text = text:gsub(">","")
    dpf.savejson(ujf, uj)
    client:getChannel(cardchannel):send("A message comes through the **Megaphone**:\n" .. text)
    if message.guild then message:delete() end
  else
    message.channel:send("The megaphone was not used. Please attach a message with c!use megaphone/(YOUR MESSAGE HERE)")
  end
end
return item