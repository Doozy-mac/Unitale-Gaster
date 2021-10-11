spawntimer = 0
timer = 0
bullets = {}

eye1x = -Arena.width/4-10
eye2x = Arena.width/4+10

eye1 = CreateProjectile("gaster/weapons/eyegun",eye1x,Arena.height/2+8)
eye2 = CreateProjectile("gaster/weapons/eyegun",eye2x,Arena.height/2+8)

function Update()
	timer = timer+1
	eye1x = math.sin(timer/20)*Arena.width/4-Arena.width/4
	eye2x = math.sin(timer/20)*Arena.width/4+Arena.width/4
	eye1.MoveTo(eye1x,Arena.height/2+8)
	eye2.MoveTo(eye2x,Arena.height/2+8)
	if spawntimer%10 == 0 then
		bullet1 = CreateProjectile("gaster/weapons/eye0",eye1.x,Arena.height/2+8)
		bullet2 = CreateProjectile("gaster/weapons/eye0",eye2.x,Arena.height/2+8)
		Audio.PlaySound("gun")
		table.insert(bullets,bullet1)
		table.insert(bullets,bullet2)
	end
	for i=1,#bullets do
		local xdifference = Player.x - bullets[i].x
		local ydifference = Player.y - bullets[i].y
		bullets[i].Move(0,-5)
		bullets[i].sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)
	end
	spawntimer = spawntimer + 1
end