local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/pyrowmid/machine.json","")
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    if uj.tokens < 3 then
      interaction:reply(lang.error_no_tokens)
      return
    end

    local itempt = {}
    for k in pairs(itemdb) do
      if uj.items["fixedmouse"] then
        if not uj.items[k] and k ~= "brokenmouse" then table.insert(itempt, k) end
      else
        if not uj.items[k] and k ~= "fixedmouse" then table.insert(itempt, k) end
      end
    end
    print(inspect(itempt))

    if #itempt == 0 then
      interaction:reply(lang.error_allitems)
      return
    end

    local newitem = itempt[math.random(#itempt)]
    uj.items[newitem] = true
    uj.tokens = uj.tokens - 3
    if uj.lang == "ko" then		    
		local dep = {"입금하고", "삽입하고", "넣고", "슬롯에 집어넣고"}
		local cdep = math.random(1, #dep)
		local speen = {" 돌리", " 사용하", " 회전시키"}
		local cspeen = math.random(1, #speen)
		local size = {" 큰 ", " 작은 ", " ", " "}
		local csize = math.random(1, #size)
		local action = {"나옵니다", "떨어져 나옵니다", "튕겨져 나옵니다", "굴려 나옵니다"}
		local caction = math.random(1, #action)
		message.channel:send(lang.used_machine_1 .. dep[cdep] .. lang.used_machine_2 .. speen[cspeen] .. lang.used_machine_3 .. size[csize] .. lang.used_machine_4 .. action[caction] .. lang.used_machine_5 .. itemdb[newitem].name .. lang.used_machine_6 .. itemdb[newitem].name .. lang.used_machine_7)
	else
		message.channel:send(trf("crank") .. itemdb[newitem].name .. lang.used_machine_1 .. itemdb[newitem].name .. lang.used_machine_2)
	end
    dpf.savejson(ujf,uj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.denied_message)
  end
end
return reaction
