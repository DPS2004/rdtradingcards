local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    cj =  io.open("data/cards.json", "r")
    _G['cdata'] = json.decode(cj:read("*a"))
    cj:close()
    --generate pull table
    _G['ptable'] = {}
    _G['cdb'] = {}
    for i,v in ipairs(cdata.groups) do
      for w,x in ipairs(v.cards) do
        
        for y=1,(cdata.basemult*v.basechance*x.chance) do
          table.insert(ptable,x.filename)
        end
        table.insert(cdb,x)
        print(x.name.. " loaded!")
      end
    end
    print("here is cdb")
    print(inspect(cdb))
    print("here is ptable")
    print(inspect(ptable))

    print("loading collector's info")
    _G['coll'] = dpf.loadjson("data/coll.json",defaultjson)
    print("loading medaldb")
    _G['medaldb'] = dpf.loadjson("data/medals.json",defaultjson)
    print("loading medal requires")
    _G['medalrequires'] = dpf.loadjson("data/medalrequires.json",defaultjson)
    print("loading functions")
    message.channel:send('All databases have been reloaded.')
  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
  print(message.author.name .. " did !reloaddb")
end
return command
  