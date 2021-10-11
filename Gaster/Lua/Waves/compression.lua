Arena.resize(310,130)
grabl = CreateProjectile("chaos/weapons/grabl",-Arena.width/2,11)
grabr = CreateProjectile("chaos/weapons/grabr",Arena.width/2,11)
grabl.sprite.alpha = 0
grabr.sprite.alpha = 0
multip = 1
width = 310
spawntimer = 0
spawn = 20
playedsound = false
angle1 = {234,248,276,290,304}
angle2 = {241,255,269,283}
bullets = {}
speed = 4
iter = 1
iterations = 5
start = 0

SetGlobal("handsgone",true)

grabs = {grabl,grabr}

function Update()
	for i=1,#grabs do
		if grabs[i].sprite.alpha < 1 then
			local transp = grabs[i].sprite.alpha
			grabs[i].sprite.alpha = transp + 0.04
		end
	end
	if grabl.sprite.alpha >= 1 then
		if playedsound == false then
			SetGlobal("usingpowers",true)
			Audio.PlaySound("collapse")
			playedsound = true
		end
		if spawntimer%spawn == 0 then
			if iter == -1 then
				start = 234
				iterations = 4
			end
			if iter == 1 then
				start = 225
				iterations = 5
			end
			--DEBUG("iter = " .. iter .. "!")
			--DEBUG("iterations = " .. iterations .. "!")
			--DEBUG("start = " .. start .. "!")
			for i=0,iterations do
				local direction = start + 18*i
				bullet = CreateProjectileAbs("chaos/weapons/ichor",GetGlobal("formx"),GetGlobal("formy")-30)
				bullet.SetVar("ang",direction)
				bullet.sprite.rotation = direction + 90
				table.insert(bullets,bullet)
			end
			iter = iter*-1
		end
		width = width-1
		multip = multip*-1
		spawntimer = spawntimer + 1
		Arena.resizeImmediate(width,130+(multip*2))
		grabl.MoveTo(-Arena.width/2,11+math.random(-2,2))
		grabr.MoveTo(Arena.width/2,11+math.random(-2,2))
		for k=1,#bullets do
			local angle = bullets[k].GetVar("ang")
			bullets[k].Move(4*math.cos(math.rad(angle)),4*math.sin(math.rad(angle)))
			--DEBUG("bullet " .. k .. " angle: " .. angle .. "deg")
		end
	end
end