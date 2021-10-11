timer = 0
bullets = {}
Arena.resize(155, 130)

function Update()
	if timer%23 == 0 then
		bullet = CreateProjectile("gaster/weapons/eye0", math.cos(math.random(2*math.pi))*150+Player.x, math.sin(math.random(2*math.pi))*150+Player.y)
		Audio.PlaySound("gun")
		local xdifference = Player.x - bullet.x
		local ydifference = Player.y - bullet.y
		--bullet.sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)+90
		bullet.sprite.alpha = 0
		bullet.SetVar('xspeed', xdifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
		bullet.SetVar('yspeed', ydifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
		bullet.SetVar("animated",false)
		--local xspeed = bullet.GetVar('xspeed') / 2 + xdifference / 10
		--local yspeed = bullet.GetVar('yspeed') / 2 + ydifference / 10
		table.insert(bullets,bullet)
	end
	for i=1,#bullets do
		--if bullets[i].GetVar("animated") == false then
			--bullets[i].sprite.SetAnimation({"gaster/weapons/eye0","gaster/weapons/eye1","gaster/weapons/eye2","gaster/weapons/eye3","gaster/weapons/eye2","gaster/weapons/eye1"},0.1)
			--bullets[i].SetVar("animated",true)
		--end
		local xdifference = Player.x - bullets[i].x
		local ydifference = Player.y - bullets[i].y
		bullets[i].sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)
		local alpha = bullets[i].sprite.alpha
		bullets[i].sprite.alpha = alpha + 0.05
		local bullet = bullets[i]
		local xspeed = bullets[i].GetVar('xspeed')
		local yspeed = bullets[i].GetVar('yspeed')
		if alpha >= 1 then
			bullets[i].Move(xspeed, yspeed)
			--bullets[i].SetVar('xspeed', 1.05*xspeed)
			--bullets[i].SetVar('yspeed', 1.05*yspeed)
		end
	end
	timer = timer + 1
end