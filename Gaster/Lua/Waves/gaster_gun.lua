--SAT = require "sat"

timer = 0
bullets = {}
Arena.resize(250, 130)
invul = false
invultimer = 0
invulalpha = -1

if GetGlobal("turnnumber") < 5 then
	spawntime = 35
else
	spawntime = 25
end

function Update()
	timer = timer + 1
	if timer%spawntime == 0 then
		bullet = CreateProjectile("gaster/weapons/GasterMissile", Arena.width*0.75-math.random(Arena.width*1.5), Arena.height*1.5)
		Audio.PlaySound("blaster")
		local xdifference = Player.x - bullet.x
		local ydifference = Player.y - bullet.y
		bullet.sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)+90
		bullet.SetVar("rtarget",bullet.sprite.rotation)
		local rotate = bullet.GetVar("rtarget")
		bullet.sprite.rotation = rotate + 180
		bullet.sprite.alpha = 0
		bullet.SetVar('xspeed', xdifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
		bullet.SetVar('yspeed', ydifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
		--local xspeed = bullet.GetVar('xspeed') / 2 + xdifference / 10
		--local yspeed = bullet.GetVar('yspeed') / 2 + ydifference / 10
		table.insert(bullets,bullet)
	end
	for i=1,#bullets do
		local alpha = bullets[i].sprite.alpha
		local xspeed = bullets[i].GetVar('xspeed')
		local yspeed = bullets[i].GetVar('yspeed')
		local target = bullets[i].GetVar("rtarget")
		local rotate = bullets[i].sprite.rotation
		if bullets[i].sprite.rotation < target-3 or bullets[i].sprite.rotation > target+3 then
			bullets[i].sprite.rotation = rotate + (target-rotate)/10
		end
		if alpha >= 1 then
			bullets[i].Move(xspeed, yspeed)
			bullets[i].SetVar('xspeed', 1.05*xspeed)
			bullets[i].SetVar('yspeed', 1.05*yspeed)
		else
			bullets[i].sprite.alpha = alpha + 0.05
		end
		--[[local bulletHitbox =SAT.makeUnitalePolygon(bullets[i].x,bullets[i].y,bullets[i].sprite.width,bullets[i].sprite.height,bullets[i].sprite.rotation)
		local playerHitbox = SAT.makeUnitalePolygon(Player.x,Player.y,Player.sprite.width,Player.sprite.height,Player.sprite.rotation)
		local collided = SAT.testUnitalePolygon(bulletHitbox, playerHitbox, response)
		if collided == true then
			if Player.isHurting == false then
				Player.Hurt(3)
			end
		end]]
	end
end