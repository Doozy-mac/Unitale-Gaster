SetGlobal("handsgone",true)
Arena.resize(160,160)
xposns = {-Arena.width*1.5,Arena.width*1.5}
yposns = {0,0}
rotations = {0,180}
images = {"chaos/weapons/gasterpointl","chaos/weapons/gasterpointr"}
corruptions = {"chaos/weapons/corrupt1","chaos/weapons/corrupt2","chaos/weapons/corrupt3","chaos/weapons/corrupt4","chaos/weapons/corrupt5","chaos/weapons/corrupt6","chaos/weapons/corrupt7"}
hands = {}
bullets = {}
vomits = {}
sequence = {}
wavetimer = 10
phase = 1
cycletimer = 0
playedsound = false

for i=1,5 do
	table.insert(sequence,math.random(1,2)) --1 is up, 2 is down
end

for i=1,2 do
	local image = images[i]
	local xpos = xposns[i]
	local ypos = yposns[i]
	local rotation = rotations[i]
	hand = CreateProjectile(image,xpos,ypos)
	hand.sprite.rotation = rotation
	hand.sprite.SetPivot(0.5,0.5)
	hand.sprite.alpha = 0
	hand.SetVar("truex",hand.x)
	hand.SetVar("truey",hand.y)
	table.insert(hands,hand)
end

function Update()
	--DEBUG("mult: " .. Time.mult .. "!")
	--DEBUG("delta time: " .. Time.dt .. "!")
	for j=1,#hands do
		local truex = hands[j].GetVar("truex")
		local truey = hands[j].GetVar("truey")
		hands[j].MoveTo(truex + math.random(-2,2),truey + math.random(-2,2)) 
	end
	if phase < #sequence then
		if cycletimer%30 == 0 then
			hands[sequence[phase]].sprite.alpha = 0
			if playedsound == true then
				phase = phase + 1
				playedsound = false
			end
		else
			hands[sequence[phase]].sprite.alpha = 1
			if playedsound == false then
				--DEBUG("sequence value: " .. sequence[phase] .. "!")
				Audio.PlaySound("ding")
				playedsound = true
			end
		end
	elseif phase < #sequence*2 then
		if cycletimer%30 == 2 then
			phase = phase + 1
			Audio.PlaySound("bitcrush")
		elseif cycletimer%30 > 15 then
			for k=1,5 do
				if math.random(1,5) > 1 then
					bullet = CreateProjectile(corruptions[math.random(#corruptions)],-Arena.width/2-8,Arena.height-sequence[phase-5]*Arena.height/2-16*k+8)
					table.insert(bullets,bullet)
				end
			end
		end	--phase = phase + 1
	end
	cycletimer = cycletimer + 1
	for l=1,#bullets do
		if bullets[l].isactive == true then
			local bulletx = bullets[l].x
			local bullety = bullets[l].y
			--bullets[l].sprite.Set(corruptions[math.random(#corruptions)])
			bullets[l].Move(16*Time.mult,0)
			if bullets[l].x + 16*Time.mult >= Arena.width/2 then
				bullets[l].Remove()
			end
		end
	end
end

function OnHit()
	Player.hurt(2,0.5)
end