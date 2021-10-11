-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Smells like poorly-optimized\rcode.","Smells like a dirty hacker."}
commands = {"heal", "turn 4", "transition"}
--commands = {}
randomdialogue = {""}

sprite = "empty" --Always PNG. Extension is added automatically.
name = "debug"
hp = 100
atk = 1
def = 100
check = "Check message goes here."
dialogbubble = "empty" -- See documentation for what bubbles you have available.
canspare = false
cancheck = false

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
        -- player did actually attack
    end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "HEAL" then
		Player.Heal(20)
    elseif command == "TURN 4" then
        SetGlobal("turnnumber",4)
    elseif command == "TRANSITION" then
        SetGlobal("turnnumber",GetGlobal("maxturns") - 1)
	elseif command == "TEST N" then
		SetGlobal("sparedmems",2)
		SetGlobal("deadmems",1)
	elseif command == "TEST P" then
		SetGlobal("sparedmems",3)
		SetGlobal("deadmems",0)
	elseif command == "TEST MX" then
		for i = 1,200 do
			Encounter.Call("LowerGDef")
		end
		SetGlobal("deadmems",3)
	end
    BattleDialog({"You selected " .. command .. "."})
end