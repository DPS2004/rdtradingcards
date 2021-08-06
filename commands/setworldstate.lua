local command = {}
function command.run(message, mt)
  print("bruh")
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
    --betterworldstates: 
    
    --0: pre-s5
	
	--501: s5 intro, a tiny hole appears
	--502: hole grows larger
    --503: ditto
    --504: ditto
    --505: ditto
	--506: hole grows to max size, capsule machine starts vibrating
	--507: ladder is placed into the hole, lab can now be acessed
    --508: terminal has been sucessfully logged in to, default pre-s7 state.
    
    --701: s7 intro, c!terminal logs unlocked
    
    
    --801: s8 intro, The cat poster can be pulled away.
    --802: the cat poster has been pulled away and relocated to reveal the scanner, the terminal is waiting to be pulled from (by kin).
    --803: key card pulled by kin
    --804: key card has been used with scanner by kin. anyone can now obtain a key card, not that it is needed to access anything anymore.
    --users can now go to and interact with new area: DARK HALLWAY.
    --Dark hallway contains:
    --door: can be opened by flipping a coin in front of it. If one person flips it, it opens the door for everyone.
    --lights: flicker in the classic valve light flicker pattern (looking at it returns a gif)
    --note: provides some good ol flavor text.
    
    
    --805: someone has flipped a coin in the hallway, and the Shady Casino can be entered:
    --806: The shady casino has been entered for the first time.
    --Shady Casino contains:
    --The Druid: an npc in a similar vein to The Panda. Sits behind the counter at the Shady Casino. more details tbd.
    --Battle Box: If the player has less than 20 unique cards in their storage, it puts in common cards to fill in the blanks. Here so that new players can play the card game immediately. Also dispenses the Rules Card, which is a hotlink to a manual for the trading card game.
    --Security Camera: flavor text probably
    --New Machine: chick stuff, see #chick-planning
    --ATM (Automatic Token Machine): flavor text
    
    --Misc notes:
    --attempting to look at the factory will alias as c!look hallway or casino when in the hallway or casino. This is because the hallway, and the casino, are located in the factory.
    

    wj.ws = tonumber(mt[1]) 
    
    --old states, do not use!: 
    
    --prehole: pre-s5
    --tinyhole: s5 intro
    --smallhole: ditto
    --mediumhole: ditto
    --largehole: ditto
    --largerhole: ditto
    --largesthole: waiting for ladder
    --labopen: lab is initially open
    --terminalopen: terminal has been logged in to
    
    dpf.savejson("savedata/worldsave.json", wj)
    message.channel:send("world updated")
  else
    message.channel:send("despite your efforts, the world remains the same")
  end
end
return command
  