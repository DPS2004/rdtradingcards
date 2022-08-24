_G['pronoun'] = {}


function pronoun.getPronoun(lang,sel,pro)
  print("getting pronoun (lang: " .. lang .. ", selection: " .. sel .. ", pronoun: " .. pro .. ")")
  local langfile = dpf.loadjson("langs/" .. lang .. "/pronoun.json")
  if sel == "they" then
        if pro == "they" then
			_G['value'] = langfile.they_they
		elseif pro == "them" then
			_G['value'] = langfile.they_them
		elseif pro == "their" then
			_G['value'] = langfile.they_their
		elseif pro == "theirs" then
			_G['value'] = langfile.they_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.they_theirself
		end
	elseif sel == "he" then
		if pro == "they" then
			_G['value'] = langfile.he_they
		elseif pro == "them" then
			_G['value'] = langfile.he_them
		elseif pro == "their" then
			_G['value'] = langfile.he_their
		elseif pro == "theirs" then
			_G['value'] = langfile.he_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.he_theirself
		end
	elseif sel == "she" then
		if pro == "they" then
			_G['value'] = langfile.she_they
		elseif pro == "them" then
			_G['value'] = langfile.she_them
		elseif pro == "their" then
			print("setting _G['value']")
			_G['value'] = langfile.she_their
		elseif pro == "theirs" then
			_G['value'] = langfile.she_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.she_theirself
		end
	elseif sel == "it" then
		if pro == "they" then
			_G['value'] = langfile.it_they
		elseif pro == "them" then
			_G['value'] = langfile.it_them
		elseif pro == "their" then
			_G['value'] = langfile.it_their
		elseif pro == "theirs" then
			_G['value'] = langfile.it_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.it_theirself
		end
	elseif sel == "xe" then
		if pro == "they" then
			_G['value'] = langfile.xe_they
		elseif pro == "them" then
			_G['value'] = langfile.xe_them
		elseif pro == "their" then
			_G['value'] = langfile.xe_their
		elseif pro == "theirs" then
			_G['value'] = langfile.xe_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.xe_theirself
		end
	elseif sel == "sta" then
		if pro == "they" then
			_G['value'] = langfile.sta_they
		elseif pro == "them" then
			_G['value'] = langfile.sta_them
		elseif pro == "their" then
			_G['value'] = langfile.sta_their
		elseif pro == "theirs" then
			_G['value'] = langfile.sta_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.sta_theirself
		end
	elseif sel == "ze" then
		if pro == "they" then
			_G['value'] = langfile.ze_they
		elseif pro == "them" then
			_G['value'] = langfile.ze_them
		elseif pro == "their" then
			_G['value'] = langfile.ze_their
		elseif pro == "theirs" then
			_G['value'] = langfile.ze_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.ze_theirself
		end
	elseif sel == "vee" then
		if pro == "they" then
			_G['value'] = langfile.vee_they
		elseif pro == "them" then
			_G['value'] = langfile.vee_them
		elseif pro == "their" then
			_G['value'] = langfile.vee_their
		elseif pro == "theirs" then
			_G['value'] = langfile.vee_theirs
		elseif pro == "theirself" then
			_G['value'] = langfile.vee_theirself
		end
	end
	if not value then
		print("no value")
	end
	return value
end


return pronoun