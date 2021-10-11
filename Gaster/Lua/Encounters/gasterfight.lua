-- A basic encounter script skeleton you can copy and modify for your own creations.
voicer = require "randomvoice"
music = "mus_st_him" --Always OGG. Extension is added automatically. Remove the first two lines for custom music.
encountertext = "[font:monster][effect:shake][color:ffffff]GASTER[font:uidialog] emerges from the dark." --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"break_fight"}
lastwaves = {"whiteout"}
wavetimer = 4.0
arenasize = {155, 130}
voicer.setvoices({"gastervoice_1","gastervoice_2","gastervoice_3","gastervoice_4","gastervoice_5","gastervoice_6","gastervoice_7"})
gasterfonts = {"[font:monster]","font:wingdings"}
currentstate = "NONE"

rememberwaves = {"remtori","rempaps","remundyne","remalphys","remsans"}

m1 = {"[effect:twitch,50]I (SAW/SEE/\nWILL SEE)...\nPURITY IN\nYOU.",
	"IT (WAS/IS/WILL BE)\nRATHER...\nUNFORTUNATE\nTHAT YOUR\nWEAKEST FORM IS\nALSO YOUR\nMOST INNOCENT."}
m2 = {"[effect:twitch,50]REGARDLESS,\nYOU CANNOT BE\nALLOWED TO LIVE.",
	"YOUR EXISTENCE\n(INTRODUCED/\nINTRODUCES/\nWILL INTRODUCE)\nA NON-ZERO\nPROBABILITY\nTHAT THE UNIVERSE\nAND EVERYTHING\nIN IT WILL [color:ff0000]END."
	}
m3 = {"[effect:twitch,50]DO YOU HAVE ANY\nIDEA WHAT I (HAD/\nHAVE/WILL HAVE)\nSACRIFICED?"}
m4 = {"[effect:twitch,50]MY WORK. MY LIFE.",
	  "[effect:twitch,50]THE MERE NOTION\nOF MY EXISTENCE.",
	"[effect:twitch,50]ALL TO STOP THE\nLIKES OF [color:ff0000]YOU."}
m5 = {"[effect:twitch,50]I (FORESAW/\nFORSEE/\nWILL FORSEE) YOUR\nARRIVAL.", 
"MY EXPERIMENTS\n(REVEALED/\nREVEAL/WILL\nREVEAL) THE\nINEVITABILITY OF\nA HUMAN GAINING\nTHE POWER TO\nCONTROL [color:d535d9]TIME\nITSELF.",
"THE POWER TO\nSINGLEHANDEDLY\nCONTROL THE\nFATE OF EVERY\nSOUL, HUMAN OR\nMONSTER."}
m6 = {"[effect:twitch,50]SO I (HID/HIDE/\nWILL HIDE)\nIN THE ONLY\nPLACE SAFE FROM\nYOUR CORRUPTION.","[color:d535d9]THE VOID.",
	"AND JUST LIKE \nTHAT, MY LIFE'S \nWORK (WAS/IS\n/WILL BE) GONE, AS\nTHOUGH ALL THE\nHOURS I (SPENT/\nSPEND/WILL SPEND)\nON IT NEVER\nTRANSPIRED."}
m7 = {"[effect:twitch,50]BUT THAT (WASN'T\n/ISN'T/WON'T BE)\nTHE WORST PART.","[[noskip][SetGlobal,gaze,0][next]","[effect:shake]THE WORST PART\n(WAS/IS/WILL BE)\nWATCHING THE\nWORLD GET ALONG\nJUST FINE\nWITHOUT ME."}
m8 = {"[effect:twitch,50]EXCEPT, THAT\nIS, FOR THE\nTIMELINES\nIN WHICH YOU\n(DECIDED/\nDECIDE/\nWILL DECIDE)\nTO SHOW YOUR\n[color:ff0000]TRUE NATURE..."}
m9 = {"[effect:twitch,50]IT (WAS/IS/\nWILL BE)\nEVEN MORE...[wait,10]\nHORRIFYING\nTHAN MY\nPREDICTIONS.","[effect:shake]I (WATCHED/\nWATCH/WILL\nWATCH) YOU KILL\n[color:ff0000]ALL OF THEM.","FRIENDS.\nCOLLEAGUES.\nLOVED ONES.\n","EVERYONE."}
m10 = {"[effect:twitch,50]WELL, I (WAS/\nAM/WILL\nBE) DONE\nSTANDING IDLY\nBY.","[noskip][func:SetGlobal,UsingPowers,true][next]","[color:ff0000][waitall,5]IT'S TIME TO\nEND THIS\nBEFORE IT\nBEGINS."}

monologue = {m1,m2,m3,m4,m5,m6,m7,m8,m9,m10}

SetGlobal("debugmode",true) --LeAVE tHiS FALSE. You HAvE BeEn WARNED.

enemies = {
	"gaster" 
}

enemypositions = {}

if GetGlobal("debugmode") == true then
enemies = {
	"gaster",
	"memory",
	"memory",
	"memory",
	"debug"
}
else
enemies = {
	"gaster",
	"memory",
	"memory",
	"memory"
}
end

alphabet = {"A","B","C"}

for i=1,#enemies do
	table.insert(enemypositions,{0,0})
end

possible_attacks_0 = {"gasterblaster_both","gaster_gun"}
possible_attacks = {"gasterblaster_both","gaster_gun","dark_tendrils","vigilance","out_of_time"--[[,"gasterblaster_sweep"]],"gaster_pulse","clairvoyance","gasterblaster_grid","beware","gasterblaster_colorful"}

SetGlobal("maxturns",25)
SetGlobal("turnnumber",0)
SetGlobal("intro", true)
SetGlobal("phase",0)
SetGlobal("fightbroken",false)
SetGlobal("itemuses",7)
SetGlobal("darkerresumed",false)
SetGlobal("gastergo",false)
SetGlobal("usingpowers",false)
SetGlobal("monostate",0)
SetGlobal("formx",0)
SetGlobal("formy",0)
SetGlobal("handsgone",false)
SetGlobal("face",0)
SetGlobal("gaze",0)
SetGlobal("wavetime",4)
SetGlobal("entropy",0)
SetGlobal("remembered",false)
SetGlobal("prevhp",Player.hp)
SetGlobal("doRememberWave",false)
SetGlobal("remwave",1)
SetGlobal("willrem",false)
SetGlobal("remcount",0)
SetGlobal("deadmems",0)
SetGlobal("sparedmems",0)
SetGlobal("path",0) --0 = not selected, 1 = neutral good, 2 = neutrual bad, 3 = pacifist, 4 = max exp, 5 = sooper secret!
SetGlobal("pathstate",0)
timer = 0
memactive = {false,false,false}

function Update()
	if GetGlobal("intro") == false then
		AnimateGaster()
	else
		HideGaster()
	end
end

function EncounterStarting()
	Audio.Stop()
	State("ENEMYDIALOGUE")
	require "Animations/gaster_anim"
	gasterbody.Set("gaster/phase1facingback")
	local randomdialogue = enemies[1].GetVar("randomdialogue") 
    enemies[1].SetVar("randomdialogue", voicer.randomizetable(randomdialogue)) 
	for i=1,#enemies do
		local id = i-1
		if i > 1 and i < 5 then
			enemies[i].SetVar("id",id)
			enemies[i].SetVar("name","Bad Memory " .. alphabet[id] .. " ")
			enemies[i].Call("SetActions")
		end
	end
end

function BadRemember()
	if GetGlobal("remcount")/2 + 1 < 5 then
		enemies[GetGlobal("remcount")/2 + 1].Call("SetActive",true)
		enemies[GetGlobal("remcount")/2 + 1].SetVar("active",true)
	end
end

function LowerGDef()
	local gdef = enemies[1].GetVar("def")
	enemies[1].SetVar("def",gdef-6000)
end

function OnHit(bullet)
	for i=1,#ioverlays do
		
	end
end

function EnemyDialogueStarting()
	if GetGlobal("usingpowers") == true then
		SetGlobal("usingpowers",false)
	end
    if GetGlobal("intro") == true then 
		enemies[1].SetVar('currentdialogue', {
			"[font:monster][effect:twitch,20]SO.",
			"[noskip][func:SetSprite,gaster/phase1sidelong][next]",
			"YOU (WERE/ARE/\nWILL BE) THE\n[color:ff0000]'ANOMALY'\n[color:000000]I'VE HEARD SO\nMUCH ABOUT.",
			"[noskip][func:SetSprite,gaster/phase1forward][next]",
			"DON'T BOTHER\nDENYING IT.\nI (COULD/CAN/\nWILL BE ABLE\nTO) PRACTICALLY\n[color:ff0000]SMELL[color:000000] YOUR\nDETERMINATION.",
			"[noskip][func:SetSprite,gaster/phase1eyesopen][next]",
			"[effect:shake][waitall:5]IT [color:ff0000]DISGUSTS[color:000000] ME.","[noskip][func:SetSprite,empty][next]"
		})
		local enemydialogue = enemies[1].GetVar("currentdialogue") 
		enemies[1].SetVar('currentdialogue', voicer.randomizetable(enemydialogue)) 
	end
	if GetGlobal("turnnumber") == 5 then
		Audio.Pause()
		enemies[1].SetVar("currentdialogue",{"[font:monster][effect:twitch]...AND YET, YOU\n(PERSIST/\nPERSISTED/\nWILL PERSIST).","(DID/DO/WILL) YOU\nNOT UNDERSTAND,\nCHILD?","[effect:shake][waitall:3][color:ff0000]YOU (WERE/ARE/\nWILL BE) A\nTHREAT TO THE\nENTIRE WORLD."})
	local enemydialogue = enemies[1].GetVar("currentdialogue") 
	enemies[1].SetVar('currentdialogue', voicer.randomizetable(enemydialogue)) 
	end
	if GetGlobal("attacked") == true and GetGlobal("fightbroken") == false then
		if GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
			SetGlobal("usingpowers",true)
			enemies[1].SetVar("currentdialogue",{"[noskip][voice:help][effect:shake,3][color:ff0000][waitall:5]DON'T YOU\nDARE TOUCH\nME."})
		end
	else if GetGlobal("turnnumber") >= 6 and GetGlobal("monostate") < #monologue then
		local mstate = GetGlobal("monostate")
		mstate = mstate + 1
		SetGlobal("monostate",mstate)
		enemies[1].SetVar("currentdialogue",monologue[mstate])
		local enemydialogue = enemies[1].GetVar("currentdialogue") 
		enemies[1].SetVar('currentdialogue', voicer.randomizetable(enemydialogue)) 
	end
	end
	if GetGlobal("turnnumber") == GetGlobal("maxturns") then 
		Audio.Stop()
		SetGlobal("phase",2)
		possible_attacks = {"compression","double_gaster_pulse","gastersays","eyebeams","gasterpunch","dark_matter","colortendrils"}
		enemies[1].SetVar("currentdialogue",{"[func:Audio.Stop][effect:shake]OH DEAR.",
		"IT (SEEMED/SEEMS/\nWILL SEEM) AS\nTHOUGH I (WOULD/\nWILL) NOT\nBE ABLE TO\nMAINTAIN THIS\nFORM FOR MUCH\nLONGER.",
		"BUT IF I (WAS/\nAM/WILL BE) TO\nRETURN TO [color:d535d9]THE\nVOID,[color:000000] THE LEAST I \nCAN DO...",
		"[effect:shake,2][waitall:6][color:ff0000]IS TAKE YOU WITH\nME.[next]",
		"[noskip][w:10][next]"})
		SetGlobal("wavetime",math.huge)
		local enemydialogue = enemies[1].GetVar("currentdialogue") 
		enemies[1].SetVar('currentdialogue', voicer.randomizetable(enemydialogue)) 
		enemies[1].SetVar("def",-6666)
		enemies[1].SetVar("commands",{"Check","Remember"})
		enemies[1].SetVar("comments",{"Welcome to your special hell."})
		enemies[1].SetVar("randomdialogue",{"[font:wingdings][effect:shake]PAIN PAIN\nPAIN PAIN\nPAIN PAIN", "[font:wingdings][effect:shake]DIE PLEASE","[font:wingdings][effect:shake]IT IT IT\nIT'S ALL\nYOUR\nFAULT","[font:wingdings][effect:shake]DON'T MAKE\nME USE MY\n[color:ff0000]SPECIAL\nATTACK!"})
		SetGlobal("monostate",math.huge)
		enemies[1].SetVar("name","[color:d535d9]Gaster")
		enemies[1].SetVar("check","[color:d535d9]Don't forget.")
	end
	if GetGlobal("turnnumber") > GetGlobal("maxturns") then 
		local randomdialogue = enemies[1].GetVar("randomdialogue") 
		enemies[1].SetVar("randomdialogue", voicer.randomizetable(randomdialogue)) 
	end
	if GetGlobal("sparedmems") + GetGlobal("deadmems") == 3 then
		if GetGlobal("path") < 1 then
			if math.max(GetGlobal("sparedmems"),GetGlobal("deadmems")) < 3 then
				SetGlobal("path",1)
				Audio.Pause()
				enemies[1].SetVar("currentdialogue",{"[effect:shake]I...[w:10]I (HAD/HAVE/WILL\nHAVE) HAD\nENOUGH OF\nTHIS.","I (WOULD/WILL)\nGIVE YOU ONE\nLAST CHANCE\nTO SURRENDER...","BEFORE I USE\nMY [color:ff0000]SPECIAL\nATTACK.","LAY DOWN YOUR\nWEAPON OR...\n[w:10]WELL, YOU (WOULD/\nWILL) NOT LIKE\nWHAT (WOULD/WILL)\nHAPPEN NEXT."})
				local randomdialogue = enemies[1].GetVar("currentdialogue") 
				enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
			elseif GetGlobal("sparedmems") == 3 then
				SetGlobal("path",3)
				Audio.Pause()
				enemies[1].SetVar("currentdialogue",{"[effect:shake]WAIT, WH...","WHAT...WHAT DID\nYOU DO?","I FEEL...[w:10]\nSO...[w:10]"})
				local randomdialogue = enemies[1].GetVar("currentdialogue") 
				enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
			end
		end
	end
	if GetGlobal("path") == 1 then
		if GetGlobal("pathstate") == 1 then
			enemies[1].SetVar("currentdialogue",{"[effect:shake]WHAT A...\n[w:10]FOOLISH CHOICE.","[effect:shake]YET ULTIMATELY,\nIT (WAS/IS/WILL BE)\nTHE RIGHT ONE."})
			SetGlobal("pathstate",2)
			local randomdialogue = enemies[1].GetVar("currentdialogue") 
			enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
		end
	end
	if	GetGlobal("path") == 2 then
		if GetGlobal("pathstate") == 0 then
			SetGlobal("pathstate",1)
			enemies[1].SetVar("currentdialogue",{"[effect:shake][waitall:2](DID/DO/WILL)\nYOU KNOW...[wait:10]\nWHAT (WOULD/WILL)\n(HAVE) HAPPEN(ED) \nIF YOU (HAD)\nKILL(ED) ME?","[effect:shake][waitall:2]YOU (WOULD/WILL)\nHAVE TRAPPED\nYOURSELF IN\nTHE VOID\n[color:ff0000]FOREVER.","[waitall:4]...","[effect:shake][waitall:2]...YOU (DIDN'T/\nDON'T/WON'T) \nREALLY CARE,\nTHOUGH, (DID/DO/\nWILL) YOU?","[waitall:2]I (HAD/HAVE/\nWILL HAVE) NO\nOTHER CHOICE,\nTHEN.","[waitall:2]TIME TO USE MY\n[color:ff0000]SPECIAL ATTACK.","[waitall:3]GET READY TO\nWITNESS THE FULL\nEXTENT OF MY\nPOWER!"})
			local randomdialogue = enemies[1].GetVar("currentdialogue") 
			enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
		end
	end
	if GetGlobal("path") == 3 then
		if GetGlobal("pathstate") == 1 then
			HideGaster()
			enemies[1].SetVar("commands",{"Check"})
			enemies[1].SetVar("check","You remember now.")
			enemies[1].SetVar("randomdialogue",{"[effect:none]..."})
			enemies[1].SetVar("comments",{"Gaster is sparing you."})
			enemies[1].SetVar("canspare",true)
			SetGlobal("pathstate",2)
			enemies[1].SetVar("def",-999999)
			enemies[1].SetVar("cancheck",false)
			enemies[1].SetVar("commands",{"Check"})
			overworld = CreateSprite("overworld_bg")
			overworld.SendToBottom()
			overworld.SetAnchor(0.5,0.5)
			overworld.MoveTo(320,240)
			enemies[1].SetVar("currentdialogue",{
				"[effect:none][func:SetSprite,chaos/prevoid_eyesclosed]...",
				"[func:SetSprite,chaos/prevoid_neutral]I'M...[w:10]\nYOU...","[func:SetSprite,chaos/prevoid_smiling]YOU SAVED ME.",
				"[func:SetSprite,chaos/prevoid_eyesclosed]...",
				"[func:SetSprite,chaos/prevoid_thinking]INTRIGUING...",
				"[func:SetSprite,chaos/prevoid_eyesclosed]IT SEEMS THE\nONLY REMEDY FOR\nMY...[w:10]\nCONDITION...",
				"[func:SetSprite,chaos/prevoid_neutral]WAS THE VERY\nTHING I SWORE\nTO DESTROY...",
				"[func:SetSprite,chaos/prevoid_sad]HUMAN...",
				"[func:SetSprite,chaos/prevoid_eyesclosed]I SUPPOSE I\nOWE YOU AN\nAPOLOGY.",
				"[func:SetSprite,chaos/prevoid_guilty]YOU SAW MY\nMEMORIES.",
				"[func:SetSprite,chaos/prevoid_thinking]DESPITE WHAT I\nUSED TO TELL\nMYSELF, MY\nACTIONS WERE\nNOT HEROIC...",
				"[func:SetSprite,chaos/prevoid_sad]BUT COWARDLY.",
				"[func:SetSprite,chaos/prevoid_neutral]IN MY PARANOIA,\nI MISJUDGED YOU.",
				"[func:SetSprite,chaos/prevoid_guilty]AND FOR THAT,\nI'M SORRY.",
				"WILL YOU\nFORGIVE ME?"
				})
			local randomdialogue = enemies[1].GetVar("currentdialogue") 
			enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
		end
		if enemies[1].GetVar("dying") == true then
			if GetGlobal("path") == 3 then
				SetGlobal("pathstate",3)
				enemies[1].SetVar("currentdialogue",{"[waitall:4][effect:shake][func:SetSprite,chaos/prevoid_dying]WELL.","[waitall:4][effect:shake][func:SetSprite,chaos/prevoid_hate]I PROBABLY\nSHOULD HAVE\nSEEN THAT\nCOMING."})
				local randomdialogue = enemies[1].GetVar("currentdialogue") 
				enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
			end
		end
	end
	if GetGlobal("path") != 3 and enemies[1].GetVar("dying") == true then
		SetGlobal("path",4)
		enemies[1].SetVar("currentdialogue",{"[effect:shake][waitall:3]YOU VIOLENT\nFOOL!",
		"[waitall:3](DID/DO/WILL)\nYOU KNOW WHAT\nYOU (HAD/HAVE/\nWILL HAVE) JUST\nDONE?",
		"[waitall:3]WITHOUT ME,\nYOU (HAD/HAVE/\nWILL HAVE) NO WAY\nTO RETURN TO\nYOUR WORLD.",
		"[waitall:3]AND I...",
		"[waitall:3]...OH GOD.",
		"[waitall:5]I...I DON'T\nWANT TO DIE..."})
		local randomdialogue = enemies[1].GetVar("currentdialogue") 
		enemies[1].SetVar("currentdialogue", voicer.randomizetable(randomdialogue)) 
		wavetime = math.huge
		SetGlobal("wavetimer",math.huge)
	end
end

function Die()
	enemies[1].Call("Kill")
end

function ChangeEmotion(emotion)
	prevoid.Set(pvemote[emotion])
end

function Defend()
	State("DEFENDING")
end

function EndNeutral()
	GetGlobal("GAME OVER")
end

function UsePowers()
	if GetGlobal("usingpowers") == false then
		SetGlobal("usingpowers",true)
	else
		SetGlobal("usingpowers",false)
	end
end



function EnemyDialogueEnding()
	SetGlobal("prevhp",Player.hp)
	wavetimer = GetGlobal("wavetime")
	if GetGlobal("intro") == true then
		Audio.Play()
		SetGlobal("intro", false)
	end
	if GetGlobal("turnnumber") == 5 then
		SetGlobal("phase",1)
		nextwaves = {"whiteout"}
		wavetimer = 2.5
		State("DEFENDING")
	end
	if GetGlobal("attacked") == true and GetGlobal("fightbroken") == false then
		State("DEFENDING")
	end
		if GetGlobal("turnnumber") != 5 then
			if GetGlobal("turnnumber") > 5 then
				if GetGlobal("turnnumber") <= #possible_attacks + 5  then
					local turnnumber = GetGlobal("turnnumber")
					nextwaves = {possible_attacks[turnnumber-5]}
				else
					nextwaves = { possible_attacks[math.random(#possible_attacks)] }
				end
			else
				nextwaves = {possible_attacks_0[math.random(#possible_attacks_0)]}
			end
		end
		if GetGlobal("willrem") == true then
			if GetGlobal("remcount") == 8 then
				nextwaves = {rememberwaves[5]}
				SetGlobal("willrem",false)
			else
				local pos = GetGlobal("remwave")
				nextwaves = {rememberwaves[pos]}
				SetGlobal("remwave",pos+1)
				SetGlobal("willrem",false)
			end
		end
		--nextwaves = {"choice"}--for testing individual attacks!
		if GetGlobal("turnnumber") == GetGlobal("maxturns") then
			nextwaves = {"static"}
		end
		if GetGlobal("turnnumber") > 4 then
			SetGlobal("face",1)
			SetGlobal("gaze",1)
		end
		if GetGlobal("path") > 0 then
			nextwaves = {"skip"}
		end
		if GetGlobal("path") == 1 then
			wavetimer = math.huge
			SetGlobal("wavetime",math.huge)
			if GetGlobal("pathstate") == 0 then
				nextwaves = {"choice"}
			end
			if GetGlobal("pathstate") == 2 then
				nextwaves = {"goodn"}
			end
		end
		if GetGlobal("path") == 2 and GetGlobal("pathstate") == 1 then
			nextwaves = {"gameover"}
		end
		if GetGlobal("path") == 3 then
			wavetimer = math.huge
			SetGlobal("wavetime",math.huge)
			if GetGlobal("pathstate") == 0 then
				nextwaves = {"return"}
			end
		end
		if GetGlobal("path") == 4 then
			SetGlobal("pathstate",6)
			if GetGlobal("pathstate") == 6 then
				wavetimer = math.huge
				nextwaves = {"thevoid"}
			end
		end
		--[[if GetGlobal("debugmode") == true then
			nextwaves = {"goodn"}
		end--]]
	end

function EnteringState(newstate, oldstate)
	local turnnumber = GetGlobal("turnnumber")
	if newstate == ("ACTIONSELECT") and oldstate == ("DEFENDING") then
		SetGlobal("turnnumber",turnnumber+1)
		if GetGlobal("turnnumber") == 5 then
			State("ENEMYDIALOGUE")
		end
		if GetGlobal("path") == 1 and GetGlobal("pathstate") == 1 then
			State("ENEMYDIALOGUE")
		end
		if GetGlobal("path") == 2 and GetGlobal("pathstate") == 0 then
			State("ENEMYDIALOGUE")
		end
		if GetGlobal("path") == 3 then
			if GetGlobal("pathstate") == 1 then
				State("ENEMYDIALOGUE")
			elseif GetGlobal("pathstate") == 3 then
				enemies[1].Call("Kill")
			end
		end
	end
		if newstate == ("ATTACKING") and GetGlobal("turnnumber") > 5 then
 		if GetGlobal("attacked") == false then
			if GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
			Audio.Pause()
			SetGlobal("attacked",true)
			State("ENEMYDIALOGUE")
			end
		else
			if GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
				BattleDialog({"[font:wingdings][color:ff0000]IT'S BROKEN, JUST LIKE ALL YOUR BONES WILL BE IF\r \rYOU DON'T STOP STRUGGLING"}) --dialogue when selecting broken fight button
				Player.Hurt(1)
			end
		end
	end
	if newstate == ("DEFENDING") and GetGlobal("attacked") == true and GetGlobal("fightbroken") == false then
		if GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
			nextwaves = {"break_fight"}
		end
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
	local turns = GetGlobal("turnnumber")
	--if turns != 5 then
	--end
	local entropy = GetGlobal("entropy")
	if GetGlobal("fightbroken") == true and GetGlobal("darkerresumed") == false then
		Audio.Play()
		SetGlobal("darkerresumed",true)	
	end
	local turnnumber = GetGlobal("turnnumber")
	if turnnumber >= 5 and GetGlobal("gastergo") == true then
		StartGaster()
		Audio.LoadFile("cacodemonovania")
		wavetimer = 4.0
		SetGlobal("gastergo",false)
	end
	if GetGlobal("usingpowers") == true then
		SetGlobal("usingpowers",false)
	end
	if GetGlobal("handsgone") == true and GetGlobal("turnnumber") >= GetGlobal("maxturns") + 1 then
		SetGlobal("handsgone",false)
	end
	if GetGlobal("turnnumber") == GetGlobal("maxturns") + 1 then
		Audio.LoadFile("the void's wrath")
	end
    encountertext = RandomEncounterText()
end

function HandleSpare()
     State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	local itemuses = GetGlobal("itemuses")
	if itemuses > 0 then
		if itemuses == 7 then
			Player.Heal(10)
			BattleDialog({"Hm[waitall:3]...[w:10][waitall:1]it looks like a hot dog,\rbut something's off...","You...take a bite anyway??","Oh my. [w:5]Tastes unfinished.","At least you got some HP back."})
		else 
			if Player.hp + 10 < 20 then
				if itemuses > 2 then
					BattleDialog({"You ate " ..ItemID.. ".\nYou recovered 10 HP!","You have " ..GetGlobal("itemuses")-1 .. " placeholder items\rleft."})
				elseif itemuses == 1 then
					BattleDialog({"You ate " ..ItemID.. ".\nYou recovered 10 HP!","You're all out of placeholder\ritems."})
				else
					BattleDialog({"You ate " ..ItemID.. ".\nYou recovered 10 HP!","You have but one placeholder\ritem left."})
				end
			else
				if itemuses > 2 then
					BattleDialog({"You ate " ..ItemID.. ".\nYour HP was maxed out!","You have " ..GetGlobal("itemuses")-1 .. " placeholder items\rleft."})
				elseif itemuses == 1 then
					BattleDialog({"You ate " ..ItemID.. ".\nYou recovered 10 HP!","You're all out of placeholder\ritems."})
				else
					BattleDialog({"You ate " ..ItemID.. ".\nYou recovered 10 HP!","You have but one placeholder\ritem left."})
				end
			end
			Player.Heal(10)
	end
		SetGlobal("itemuses",itemuses - 1)
	else
		BattleDialog("Despite all appearances,\nyou're out of test dogs.")
	end
end