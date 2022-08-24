local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !items")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/items.json", "")

  local pagenumber = 1
  if tonumber(mt[1]) then
    pagenumber = math.floor(mt[1])
  end
  pagenumber = math.max(1, pagenumber)

  local numitems = 0
  if not uj.items then
    uj.items = {}
    uj.items["nothing"] = true
    uj.equipped = "nothing"
  end
  if not uj.consumables then uj.consumables = {} end
  dpf.savejson("savedata/" .. message.author.id .. ".json", uj)
  
  for k in pairs(uj.items) do numitems = numitems + 1 end
  for k in pairs(uj.consumables) do numitems = numitems + 1 end
  local maxpn = math.ceil(numitems / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)

  local invtable = {}
  local invstring = ''

  for k,v in pairs(uj.items) do
    if v then table.insert(invtable, "**" .. itemdb[k].name .. "**" .. (uj.equipped == k and " (equipped)" or "") .. "\n") end
  end
  for k,v in pairs(uj.consumables) do
    table.insert(invtable,"**".. consdb[k].name  .. "** x" .. v .. "\n")
  end
  table.sort(invtable)

  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if invtable[i] then invstring = invstring .. invtable[i] end
  end

  if not uj.tokens then uj.tokens = 0 end
  invstring = invstring .. "\n" .. lang.embed_token_1 .. uj.tokens .. lang.embed_token_2 .. (uj.tokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.embed_token_3


  if uj.lang == "ko" then
    message.channel:send{
      content = message.author.mentionString .. lang.embed_contains,
      embed = {
        color = 0x85c5ff,
        title = message.author.name .. lang.embed_title,
        description = invstring,
        footer = {
          text =  lang.embed_page_1 .. maxpn .. lang.embed_page_2 .. pagenumber .. lang.embed_page_3,
          icon_url = message.author.avatarURL
        }
      }
    }
  else
    message.channel:send{
      content = message.author.mentionString .. lang.embed_contains,
      embed = {
        color = 0x85c5ff,
        title = message.author.name .. lang.embed_title,
        description = invstring,
        footer = {
          text =  lang.embed_page_1 .. pagenumber .. lang.embed_page_2 .. maxpn .. lang.embed_page_3,
          icon_url = message.author.avatarURL
        }
      }
    }
  end
end
return command
