local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !use")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if #mt == 1 or mt[1] == "" then

    if string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" then 
      if uj.tokens == nil then
        uj.tokens = 0
      end
      if uj.tokens > 0 then
        message.channel:send {
          content = 'Will you put a **Token** into the **Strange Machine?** (tokens remaining: ' .. uj.tokens .. ')'
        }
      else
        message.channel:send {
          content = 'You try to turn the crank, but it does not budge. There is a slot above it. If only you had something to put in there...'
        }
      end
    elseif string.lower(mt[1]) == "token"  then 
      local rnum = math.random(0,1)
      local cflip = ":doctah:"
      if rnum == 0 then
        cflip = "heads"
      else
        cflip = "tails"
      end
      
      message.channel:send {
        
        content = 'You flip a **Token** in the air. It lands on **' .. cflip .. '**.'
      }
    elseif string.lower(mt[1]) == "panda"  then       
      message.channel:send {
        
        content = ':flushed:'
      }
    elseif string.lower(mt[1]) == "throne" then       
      message.channel:send {
        
        content = 'It appears that the **Throne** is already in use by the **Panda**.'
      }



    else
      message.channel:send("Sorry, but I don't know how to use " .. mt[1] .. ".")
    end




  else
    message.channel:send("Sorry, but the c!use command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  