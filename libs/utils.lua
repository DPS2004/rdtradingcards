local mRandom = math.random
local tInsert = table.insert
-------------------------------------------
-- Shuffle a table
-------------------------------------------
table.shuffle = function (t)
  local n = #t
  while n > 2 do
    -- n is now the last pertinent index
    local k = mRandom(1, n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
end

function table.deepcopy(t)
    if type(t) ~= 'table' then return t end
    local mt = getmetatable(t)
    local res = {}
    for k,v in pairs(t) do
        if type(v) == 'table' then
            v = table.deepcopy(v)
        end
        res[k] = v
    end
    setmetatable(res,mt)
    return res
end

function string.trim(s)
    local from = s:match"^%s*()"
    return from > #s and "" or s:match(".*%S", from)
end

function string.startswith(s, piece)
    return string.sub(s, 1, string.len(piece)) == piece
end

function string.endswith(s, send)
    return #s >= #send and s:find(send, #s-#send+1, true) and true or false
end

function string.split(p,d)
  local t, ll, l
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        tInsert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        tInsert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end

function math.clamp(value, low, high)
    if low and value <= low then
        return low
    elseif high and value >= high then
        return high
    end
    return value
end

function math.inBounds(value, low, high)
    if value >= low and value <= high then
        return true
    else
        return false
    end
end

function math.round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end





function table.removeByRef(t, obj)
    table.remove(t, table.indexOf(t, obj))
end