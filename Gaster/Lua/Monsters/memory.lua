comments = {"Smells like entropy."}
commands = {"act 1","act 2","act 3","act 4"}
randomdialogue = {"[novoice]"}
id = 0

sprite = "empty" --Always PNG. Extension is added automatically.
name = "Bad Memory"
hp = 30
atk = 6
def = 1
check = "<ERR:INVALID FILE PATH>"
dialogbubble = "empty" -- See documentation for what bubbles you have available.
canspare = false
cancheck = false
SetActive(false)
spared = false
active = false
memorable = false
acted1 = false
acted2 = false
acted3 = false
acted4 = false
timer = 0
caption = {}

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
		--local gdef = enemies[1].GetVar("def")
        --Encounter.Call("LowerGDef")
    end
end

function HandleSpare()
	if canspare == true then
		spared = true
		active = false
	end
end

function OnDeath()
	Encounter.Call("LowerGDef")
	local deadmems = GetGlobal("deadmems")
	SetGlobal("deadmems",deadmems + 1)
	--DEBUG("Dead:" .. GetGlobal("deadmems") .. "...")
	active = false
	Kill()
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "CONSULT" then
		if acted1 == false then
			caption = {"The king needs your help.","He needs you to find a way to\ropen the Barrier without a \rseventh human soul.","You're skeptical, of course,\rbut you promise to look into it."}
			acted1 = true
		else
			caption = {"What? You didn't do that?"}
		end
	elseif command == "RESEARCH" then
		if acted2 == false then
				caption = {"You decide to search the\rrecords for some sort of clue.","You notice a word that's often\rmentioned in historical accounts\rof the war:[w:10] Determination.","You decide to ask the king\rif you can borrow something\rfrom his[waitall:5]...[w:10][waitall:1]collection."}
			acted2 = true
		else
			caption = {"Are you sure that wasn't you?"}
		end
	elseif command == "EXPERIMENT" then
		if acted3 == false then
			caption = {"With the six human souls at your\rdisposal, you begin to conduct\rexperiments.","What if Determination is more\rthan just a state of mind?","Can its power be harnessed?"}
			acted3 = true
		else
			BattleDialog({"Are these memories even yours?"})
		end
	elseif command == "DESIGN" then
		if acted4 == false then
			caption = {"All the groundwork is in place.","It's time to begin constructing\ryour greatest creation since the\rCore."}
			acted4 = true
		else
			caption = {"Then whose are they?"}
		end
	elseif command == "EXTRACT" then
		if acted1 == false then
			caption = {"You were right. Determination\ris a tangible substance.","Now to see what it can do."}
			acted1 = true
		else
			caption = {"This can't be right."}
		end
	elseif command == "ADMINISTER" then
		if acted2 == false then
			caption = {"It's more powerful than you\rcould have imagined.","One of your lab assistants\rhas managed to make the fallen\rrise once more.","It's almost as if[waitall:5]...","They never fell down in\rthe first place..."}
			acted2 = true
		else
			caption = {"This shouldn't be possible."}
		end
	elseif command == "REASSIGN" then
		if acted3 == false then
			caption = {"You decide to let your lab\rassistant take over the revival\rexperiments.","She's quite capable, and\rthere's something else that\rrequires your attention.","Something very, [w:15]very [w:15]interesting."}
			acted3 = true
		else
			caption = {"This is all just a bad\rdream[waitall:5]...[w:10][waitall:1]right?"}
		end
	elseif command == "TEST" then
		if acted4 == false then
			caption = {"It's time to start a new round\rof experiments.","But this time, you'll be your\rown lab rat."}
			acted4 = true
		else
			caption = {"What else could it be?"}
		end
	elseif command == "PREDICT" then
		if acted1 == false then
			caption = {"You had your suspicions, but\rnow you're almost certain.","Something horrible is on\rits way."}
			acted1 = true
		else
			caption = {"..."}
		end
	elseif command == "DECIDE" then
		if acted2 == false then
			caption = {"The world is no longer\rsafe.","You can't stay, knowing what\rthe future holds.","But there isn't enough left\rto save everyone.","So you'll save yourself."}
			acted2 = true
		else
			caption = {"..."}
		end
	elseif command == "DISMISS" then
		if acted3 == false then
			caption = {"Your other lab assistant tries\rto stop you. Says there has\rto be another way.","He's persistent, but he can't\rchange your mind.","So eventually, he gives up.","As he leaves, he says he\rwon't forget you.","How quaint."}
			acted3 = true
		else
			caption = {"..."}
		end
	elseif command == "FALL" then
		if acted4 == false then
			caption = {"It hits you like a wave\rof magma.","You feel as though you're\rbeing torn to countless\rpieces.","But you're safe.","You're in tremendous pain,\rbut you're safe."}
			acted4 = true
		else
			caption = {"..."}
		end
	end
	if acted1 == true and acted2 == true and acted3 == true and acted4 == true then
		table.insert(caption,"[func:Vanish]The Memory fades from view,\rbut you know it's still there.")
		table.insert(caption,"Somewhat alarmingly, you're okay\rwith that.")
	end
    BattleDialog(caption)
end

function Vanish()
	local sparedmems = GetGlobal("sparedmems")
	SetGlobal("sparedmems",sparedmems + 1)
	--DEBUG("Spared:" .. GetGlobal("sparedmems") .. "!")
	active = false
	SetActive(false)
end

function SetActions()
	if id == 1 then
		commands = {"Consult","Research","Experiment","Design"}
	end
	if id == 2 then
		commands = {"Extract","Administer","Reassign","Test"}
	end
	if id == 3 then
		commands = {"Predict","Decide","Dismiss","Fall"}
	end
end