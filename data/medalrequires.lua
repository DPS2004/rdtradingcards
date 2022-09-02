return {
  {
    receive = "unlucky",
    require = function(uj)
      for k, v in pairs(uj.storage) do
        if v >= 10 then return true end
      end
    end
  },
  {
    receive = "pyramidal",
    require = function(uj)
      for k, v in pairs(uj.storage) do
        if v >= 50 then return true end
      end
    end
  },
  {
    receive = "bronzecollector",
    require = function(uj)
      local rarecount = 0

      for k, v in pairs(uj.storage) do
        if cdb[k].type == 'Rare' then rarecount = rarecount + v end
        if rarecount >= 20 then return true end
      end
    end
  },
  {
    receive = "silversaver",
    require = function(uj)
      local superrarecount = 0

      for k, v in pairs(uj.storage) do
        if cdb[k].type == 'Super Rare' then superrarecount = superrarecount + v end
        if superrarecount >= 20 then return true end
      end
    end
  },
  {
    receive = "goldhoarder",
    require = function(uj)
      local ultrararecount = 0

      for k, v in pairs(uj.storage) do
        if cdb[k].type == 'Ultra Rare' then ultrararecount = ultrararecount + v end
        if ultrararecount >= 20 then return true end
      end
    end
  },
  {
    receive = "shredsavvy",
    require = function(uj)
      if uj.timesshredded == nil then uj.timesshredded = 0 end
      print('total shredded is ' .. uj.timesshredded)
      return uj.timesshredded >= 25
    end
  },

  {
    receive = "itainteasybeinggreen",
    require = function(uj)
      return uj.storage['roomsdc_r'] and
          uj.storage['roomsdc_sr'] and
          uj.storage['roomsdc_ur']
    end
  },
  {
    receive = "editorenthusiast",
    require = function(uj)
      return uj.storage['roomsr'] and
          uj.storage['roomssr'] and
          uj.storage['roomsur'] and
          uj.storage['rowsr'] and
          uj.storage['rowssr'] and
          uj.storage['rowsur'] and
          uj.storage['vfxr'] and
          uj.storage['vfxsr'] and
          uj.storage['vfxur'] and
          uj.storage['soundr'] and
          uj.storage['soundsr'] and
          uj.storage['soundur'] and
          uj.storage['decor'] and
          uj.storage['decosr'] and
          uj.storage['decour']
    end
  },
  {
    receive = "mememaestro",
    require = function(uj)
      return uj.storage['beansr'] and
          uj.storage['beansur'] and
          uj.storage['oeufr'] and
          uj.storage['oeufur'] and
          uj.storage['doctahr'] and
          uj.storage['doctahur'] and
          uj.storage['iantrashcanr'] and
          uj.storage['iantrashcanur'] and
          uj.storage['wallclockr'] and
          uj.storage['wallclockur'] and
          uj.storage['logunr'] and
          uj.storage['logunsr'] and
          uj.storage['logunur'] and
          uj.storage['pogsomniacr'] and
          uj.storage['pogsomniacur'] and
          uj.storage['kanyer'] and
          uj.storage['kanyeur']
    end
  },
  {
    receive = "s1maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[1]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s2maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[2]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s3maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[3]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s4maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[4]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s5maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[5]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s6maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[6]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s7maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[7]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s8maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[8]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "s9maestro",
    require = function(uj)
      for i, v in ipairs(seasontable[9]) do
        if not uj.storage[v] then return false end
      end

      return true
    end
  },
  {
    receive = "cardmaestro",
    require = function(uj)
      local excludedcards = { "rdcards", "key" }

      for k, v in pairs(cdb) do
	    if not table.search(excludedcards, k) and not uj.storage[k] and v.season <= 8 then
          print('Missing ' .. k)
          return false
        end
      end

      return true
    end
  },
  {
    receive = "easytogetdebugmedal",
    require = function(uj)
      -- print(inspect(uj))
      if uj.storage['samurair'] then
        return false
      else
        return false
      end
    end
  }
}
