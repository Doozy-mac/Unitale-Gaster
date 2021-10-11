gasterbase = CreateSprite("empty")
gasterbody = CreateSprite("empty")
brokenfight = CreateSprite("empty")
face = CreateSprite("empty")
gaze = CreateSprite("gaster/face_eyes")
gaze.SetParent(face)
gaze.alpha = 0
pvemote = {"chaos/prevoid_neutral","chaos/prevoid_eyesclosed","chaos/prevoid_smiling","chaos/prevoid_sad"}

fixed = false

faces = {"gaster/face_idle","gaster/face_usingpowers","gaster/face_distort","gaster/face_empty"}

skullglitches = {"chaos/skullglitch_1","chaos/skullglitch_2","chaos/skullglitch_3","chaos/skullglitch_4","chaos/skullglitch_5"}

skull = CreateSprite("chaos/pixelgasterskull")
lowerjaw = CreateSprite("chaos/pixelgasterlowerjaw")
upperjaw = CreateSprite("chaos/pixelgasterupperjaw")
eyes = CreateSprite("chaos/pixelgastereyes")
lhand = CreateSprite("chaos/meltyhand_r_1")
rhand = CreateSprite("chaos/meltyhand_l_1")

rhand.SetAnimation({"chaos/meltyhand_l_1","chaos/meltyhand_l_2","chaos/meltyhand_l_3","chaos/meltyhand_l_4","chaos/meltyhand_l_5","chaos/meltyhand_l_6","chaos/meltyhand_l_7"},0.1)
lhand.SetAnimation({"chaos/meltyhand_r_1","chaos/meltyhand_r_2","chaos/meltyhand_r_3","chaos/meltyhand_r_4","chaos/meltyhand_r_5","chaos/meltyhand_r_6","chaos/meltyhand_r_7"},0.1)

chaosdefault = {skull,lhand,rhand}
chaospowered = {lowerjaw,upperjaw,eyes}
chaosparts = {skull,lowerjaw,upperjaw,eyes,lhand,rhand}
hands = {lhand,rhand}

red = {1,0,0}
cyan = {0.26,0.89,1}
orange = {0.99,0.65,0}
purple = {0.81,0.21,0.85}
white = {1,1,1}

colors = {red,red,cyan,orange,purple,white}

chaosy = 360

memories = {}
memoryangles = {}
manim = {"memory/mem_appear_1","memory/mem_appear_2","memory/mem_appear_3","memory/mem_appear_4","memory/mem_appear_5","memory/mem_appear_6","memory/mem_appear_7"}
manimindecies = {} 
manimset = {}
radius = 120

for i=0,2 do
	local circlepos = 120*i
	memory = CreateSprite("memory/spr_memoryhead_0")
	memory.SetAnchor(0.5,0.5)
	memory.SetPivot(0.5,0.5)
	memory.SetParent(skull)
	memory.MoveTo(math.cos(math.rad(circlepos))*radius,math.sin(math.rad(circlepos))*radius)
	memory.alpha = 0
	table.insert(memoryangles,circlepos)
	table.insert(memories,memory)
	table.insert(manimindecies,1)
	table.insert(manimset,false)
end

for i=1,#chaosparts do
	chaosparts[i].alpha = 0
end

for i=1,#chaospowered do
	chaospowered[i].SetAnchor(0.5,0.5)
	chaospowered[i].SetParent(skull)
	chaospowered[i].y = -10
end

skull.SetAnchor(0.5,0.5)
skull.y = chaosy
lhand.SetAnchor(0,1)
rhand.SetAnchor(1,1)
lhand.SetPivot(0,1)
rhand.SetPivot(1,1)
lhand.SetParent(skull)
rhand.SetParent(skull)
lhand.x = -150
rhand.x = 150
lhand.y = -90
rhand.y = -90
upperjaw.SendToBottom()

chaosx = skull.x

chaosform = false

gasterbody.SetParent(gasterbase)
face.SetParent(gasterbody)

face.y = 83
brokenfight.x = 87
brokenfight.y = 27

init = false

breakanim = {"Brokenfight","Brokenfight1","Brokenfight2","Brokenfight3"}

gasterbody.y = -50

gasterbody.setAnchor(0.5,0.5)
gasterbody.setPivot(0.5,0.5)
gasterbase.SetPivot(0.5, 0)

glitches = {"gaster/distort","gaster/distort1","gaster/distort2"}
weakened = {"gaster/weakened1","gaster/weakened2","gaster/weakened3","gaster/weakened4"}
	
function GasterSidelong()
	gasterbody.Set("gaster/phase1sidelong")
end

function StartGaster()
	gasterbody.set("gaster/0")
	gasterbody.SetAnimation({"gaster/0", "gaster/1", "gaster/2", "gaster/3", "gaster/4"},0.1)
end

function HideGaster()
	if gasterbody.alpha > 0 then
		gasterbody.alpha = 0
	end
	if GetGlobal("path") == 3 and GetGlobal("pathstate") == 1 then
		gasterbody.xscale = 0
		gasterbody.yscale = 0
	end
end

gasterbody.setAnchor(0.5,0.5)
gasterbody.setPivot(0.5,0.5)
gasterbase.SetPivot(0.5, 0)

function AnimateGaster()
	local turn = GetGlobal("turnnumber")
	if turn < GetGlobal("maxturns") - 1 and turn > 5 then
		local faceindex = GetGlobal("face")
		local gazeindex = GetGlobal("gaze")
		gaze.alpha = gazeindex
		face.set(faces[faceindex])
	else
		face.set(faces[#faces])
	end
	prevface = GetGlobal("face")
	gasterbody.alpha = 1
	gasterbase.y = 286
	gasterbase.set("empty")
	if GetGlobal("phase") == 1 then
		gasterbase.Scale(1, 1+0.1*math.sin(Time.time*2))
		if math.random(66) <= turn/6 then
			distortion = glitches[math.random(#glitches)]
			gasterbody.Scale((math.random(6,14))/10,(math.random(6,14))/10)
			gasterbody.set(distortion)
			face.set(faces[3])
			Audio.PlaySound("gasterglitch")
			--gasterbody.set("gaster/0")
		else
			gasterbody.Scale(1,1)
			SetGlobal("face",prevface)
		end
	elseif GetGlobal("phase") < 4 then
		gasterbase.y = 250
		gasterbody.set("empty")
		gasterbase.set("gaster/phase1forward")
		gasterbase.Scale(1,1+0.02*math.sin(Time.time*1.5))
		if GetGlobal("phase") == 2 then
			gasterbase.set(weakened[math.random(1,4)])
		end
	end
	if GetGlobal("fightbroken") == true then
		brokenfight.set(breakanim[math.random(#breakanim)])
	else
		brokenfight.set("empty")
	end
	if GetGlobal("usingpowers") == true and GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
		SetGlobal("face",2)
		SetGlobal("gaze",1)
		gaze.color = colors[math.random(1,#colors)]
	else
		if GetGlobal("turnnumber") > 5 and GetGlobal("turnnumber") < GetGlobal("maxturns") - 1 then
			gaze.color = white
			face.Set(faces[GetGlobal("face")])
		end
	end
	
	if GetGlobal("phase") == 3 then
		if chaosform == false then
			gasterbody.alpha = 0
			gasterbase.alpha = 0
			brokenfight.alpha = 0
			SetGlobal("fightbroken",false)
			for j=1,#chaosdefault do
				chaosdefault[j].alpha = 1
			end
			chaosform = true
		end
		chaosy = 360 + 4*math.sin(Time.time*2)
		lhand.x = -150 + 6*math.cos(Time.time*3)
		rhand.x = 150 - 6*math.cos(Time.time*3)
		for i=1,#hands do
			hands[i].y = 6*math.sin(Time.time*3) - 90
		end
		--skull.MoveTo(chaosx + math.random(-2,2),chaosy+math.random(-2,2))
		if GetGlobal("usingpowers") == true then
			skull.MoveTo(chaosx + math.random(-2,2),chaosy+math.random(-2,2))
			skull.alpha = 0
			for k=1,#chaospowered do
				chaospowered[k].alpha = 1
			end
			eyes.color = colors[math.random(1,#colors)]
		else
			for k=1,#chaospowered do
				chaospowered[k].alpha = 0
			end
			skull.MoveTo(chaosx,chaosy)
			if fixed == false then
				skull.alpha = 1
			end
			if math.random(66) <= (turn-30)/6 then
				skull.set(skullglitches[math.random(#skullglitches)])
				skull.Scale((math.random(8,12))/10,(math.random(8,12))/10)
				Audio.PlaySound("gasterglitch")
			else
				if fixed == false then
					skull.set("chaos/pixelgasterskull")
					skull.Scale(1,1)
				end
			end
		end
		if GetGlobal("handsgone") == true then
			for i=1,#hands do
				local alpha = hands[i].alpha
				if alpha > 0 then
					hands[i].alpha = alpha-0.04
				end
			end
		else
			for i=1,#hands do
				local alpha = hands[i].alpha
				if alpha <= 1 then
					if fixed == false then
						hands[i].alpha = alpha+0.04
					end
				end
			end
		end
		SetGlobal("formx",skull.x)
		SetGlobal("formy",skull.y)
		for i=1,#memories do
			local manimindex = manimindecies[i]
			local tanspeed = 1.5
			local mangle = memoryangles[i]
			memoryangles[i] = mangle + tanspeed
			mangle = mangle + tanspeed
			memories[i].MoveTo(math.cos(math.rad(mangle))*radius,math.sin(math.rad(mangle))*radius)
			if enemies[i+1].GetVar("active") == true then
				memories[i].alpha = 1	
				if manimindecies[i]/2 <= #manim then
					if manimindecies[i]%2 == 0 then
						memories[i].Set(manim[manimindex])
					end
				else
					if manimset[i] == false then
						memories[i].SetAnimation({"memory/spr_memoryhead_0","memory/spr_memoryhead_1","memory/spr_memoryhead_2","memory/spr_memoryhead_3"},0.2)
						manimset[i] = true
					end
				end
			else
				memories[i].alpha = 0
			end
			manimindecies[i] = manimindex + 1
		end
	end
	if GetGlobal("path") == 3 and GetGlobal("pathstate") > 0 then
		if fixed == false then
			for i=1,#chaospowered do
				chaospowered[i].alpha = 0
			end
			for j=1,#chaosdefault do
				chaosdefault[j].alpha = 0
			end
			gasterbody.alpha = 0
			--[[prevoid = CreateSprite("chaos/prevoid_eyesclosed")
			prevoid.setPivot(0.5,0.5)
			prevoid.setAnchor(0.5,0.5)
			prevoid.MoveTo(320,380)]]
			fixed = true
		end
	end
	if GetGlobal("path") == 4 then
		if fixed == false then
			skull.Set("chaos/pixelgasterdying")
			fixed = true
		end
		if GetGlobal("pathstate") == 6 then
			for i = 1,#chaosdefault do
				local fade = chaosdefault[i].alpha - 0.05
				chaosdefault[i].alpha = fade
				local scale = chaosdefault[i].xscale + 0.0125
				chaosdefault[i].xscale = scale
			end
		end
	end
end