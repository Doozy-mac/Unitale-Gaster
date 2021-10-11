whiteout = CreateProjectileAbs("whiteout",320,240)
whiteout.sprite.alpha = 0
timer = 0
fragments = {}
radius = 400
fadeout = false
clicked = false
Audio.PlaySound("stinger")

function Update()
	whiteout.SendToTop()
	if fadeout == false then
		local alpha = whiteout.sprite.alpha
		whiteout.sprite.alpha = alpha + 0.05
	else
		local alpha = whiteout.sprite.alpha
		whiteout.sprite.alpha = alpha - 0.05
	end
	if timer == 121 then 
		Audio.LoadFile("mus_dontgiveup")
		SetGlobal("usingpowers",true)
		fadeout = true
		blackout = CreateProjectileAbs("blackscreen",320,-160)
		blackout.SendToBottom()
		for i=0,2 do
			local circlepos = 120*i
			fragment = CreateProjectileAbs("memory/spr_memoryhead_0",math.cos(math.rad(circlepos))*radius,math.sin(math.rad(circlepos))*radius+150)
			table.insert(fragments,fragment)
			fragment.SetVar("procession",0)
			fragment.SetVar("angle",circlepos)
		end
	end
	if timer > 130 then
		radius = radius - 0.5
		if radius <= 0 then
			radius = 0
			if clicked == false then
				Audio.PlaySound("click2")
				clicked = true
			end
		end
	end
	if timer == 1000 then
		Audio.PlaySound("mysteryman_vanish")
		Audio.Stop()
		fadeout = false
	end
	if timer == 1220 then
		SetGlobal("pathstate",1)
		SetGlobal("phase",4)
		EndWave()
	end
	for i=1,#fragments do
		local angle = fragments[i].GetVar("angle") + 1
		fragments[i].SetVar("angle",angle)
		fragments[i].MoveTo(math.cos(math.rad(angle))*radius,math.sin(math.rad(angle))*radius+150)
	end
	timer = timer + 1
end

function OnHit(bullet)

end