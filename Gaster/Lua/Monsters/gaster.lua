comments = {"Smells like retroactive temporal\rerasure.", "He knows what you (did/will\rdo).","You feel sins you have not\ryet committed weighing on your\rneck."}
commands = {"Check"}
randomdialogue = {"[font:wingdings][effect:shake]I WILL\nERASE YOU.", "[font:wingdings][effect:shake]THERE IS \nNOTHING\nLEFT FOR\nYOU IN THIS\nWORLD.", "[font:wingdings][effect:shake]THIS ISN'T \nEVEN MY \nFINAL FORM!"}

sprite = "gaster/phase1facingback" --Always PNG. Extension is added automatically.
name = "Mystery Man"
hp = 666666
atk = 66666
def = 10
check = ""
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = false
SetGlobal("attacked",false)
timer = 0
screen = CreateSprite("blackscreen")
screen.MoveTo(320,240)
screen.alpha = 0
lastremembered = 0
dying = false
sparing = false

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else 
		--[[local entropy = GetGlobal("entropy")
		if GetGlobal("turnnumber") > GetGlobal("maxturns") then
			SetGlobal("entropy",entropy + 2)
		end]]
		if GetGlobal("path") == 2 then
			SetGlobal("pathstate",2)
			State("ENEMYDIALOGUE")
		end
		if GetGlobal("path") == 3 then
			SetSprite("chaos/prevoid_hurt")
		end
	end
end

function IntroSpriteChange()
	gasterbody.Set("gaster/phase1sidelong")
end

function Update()
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "REMEMBER" then
		if GetGlobal("remcount") <= 8 then
		local remcount = GetGlobal("remcount")
		SetGlobal("remcount",remcount + 1)
		if GetGlobal("remembered") == false then
			local entropy = GetGlobal("entropy")
			BattleDialog({"Reality dissolves around you.","You can see all possible\revents happening at once.","Amidst the chaos, you start\rto remember something..."})
			SetGlobal("remembered",true)
			SetGlobal("willrem",true)
			lastremembered = GetGlobal("turnnumber")
			SetGlobal("wavetime",math.huge)
			--SetGlobal("wavetime",math.huge)
		else
			if GetGlobal("remcount")%2 == 0 then
				if GetGlobal("remcount") == 8 then
					BattleDialog({"You remember."})
					SetGlobal("wavetime",math.huge)
					SetGlobal("willrem",true)
				else
					BattleDialog({"A bad memory surfaced!"})
					Encounter.Call("BadRemember")
				end
			else
				if GetGlobal("remcount") < 8 then
					BattleDialog({"You remember."})
					SetGlobal("wavetime",math.huge)
					SetGlobal("willrem",true)
				else
					BattleDialog({"You tried to remember...","but nobody came."})
				end
			end
		end
		else
			BattleDialog({"You tried to remember...","but nobody came."})
			SetGlobal("willrem",false)
		end
	end
	if command == "CHECK" then
		if GetGlobal("path") == 3 then
			BattleDialog({"W.D. GASTER - ATK 6 DEF 60\nYou remember now."})
		elseif GetGlobal("phase") < 3 then
			BattleDialog({"MYSTERY MAN - ATK ??? DEF ???\nNo data available."})
		else
			BattleDialog("[color:d535d9]GASTER - ATK 66666 DEF 66666\nDon't forget.")
		end
	end
    --BattleDialog({"You selected " .. command .. "."})
end

function OnDeath()
	dying = true
	Audio.Stop()
	State("ENEMYDIALOGUE")
end

function StartRemember()
	SetGlobal("remembered",true)
end

function Transition()
	Audio.PlaySound("click2")
	screen.SendToTop()
	if screen.alpha == 0 then
		screen.alpha = 1
		Audio.Pause()
	else
		screen.alpha = 0
		Audio.Play()
	end
end

function Click()
	Audio.Play()
	Audio.PlaySound("click2")
end