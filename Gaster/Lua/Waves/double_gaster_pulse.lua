spawntimer = 0
timer = 0
bullets = {}

Arena.resize(200,200)

eye1x = -Arena.width/4-10
eye2x = Arena.width/4+10
eye3y = -Arena.height/4-10
eye4y = Arena.height/4+10

eye1 = CreateProjectile("gaster/weapons/eyegun",-Arena.width/4-10,Arena.height/2+8)
eye2 = CreateProjectile("gaster/weapons/eyegun",Arena.width/4+10,Arena.height/2+8)
eye3 = CreateProjectile("gaster/weapons/eyegun",-Arena.width/2-8,-Arena.height/4-10)
eye4 = CreateProjectile("gaster/weapons/eyegun",-Arena.width/2-8,Arena.height/4+10)
eye3.sprite.rotation = 90
eye4.sprite.rotation = 90

function Update()
	timer = timer+1
	eye1x = math.sin(timer/20)*Arena.width/4-Arena.width/4
	eye2x = math.sin(timer/20)*Arena.width/4+Arena.width/4
	eye3y = math.cos(timer/20)*Arena.height/4-Arena.height/4
	eye4y = math.cos(timer/20)*Arena.height/4+Arena.height/4
	eye1.MoveTo(eye1x,Arena.height/2+8)
	eye2.MoveTo(eye2x,Arena.height/2+8)
	eye3.MoveTo(-Arena.width/2-8,eye3y)
	eye4.MoveTo(-Arena.width/2-8,eye4y)
	if spawntimer%10 == 0 then
		bullet1 = CreateProjectile("gaster/weapons/eye0",eye1.x,Arena.height/2+8)
		bullet2 = CreateProjectile("gaster/weapons/eye0",eye2.x,Arena.height/2+8)
		bullet3 = CreateProjectile("gaster/weapons/eye0",eye3.x,eye3.y)
		bullet4 = CreateProjectile("gaster/weapons/eye0",eye4.x,eye4.y)
		bullet1.SetVar("xspeed",0)
		bullet2.SetVar("xspeed",0)
		bullet1.SetVar("yspeed",-5)
		bullet2.SetVar("yspeed",-5)
		bullet3.SetVar("xspeed",5)
		bullet4.SetVar("xspeed",5)
		bullet3.SetVar("yspeed",0)
		bullet4.SetVar("yspeed",0)
		Audio.PlaySound("gun")
		table.insert(bullets,bullet1)
		table.insert(bullets,bullet2)
		table.insert(bullets,bullet3)
		table.insert(bullets,bullet4)
	end
	for i=1,#bullets do
		local xspeed = bullets[i].GetVar("xspeed")
		local yspeed = bullets[i].GetVar("yspeed")
		local xdifference = Player.x - bullets[i].x
		local ydifference = Player.y - bullets[i].y
		bullets[i].Move(xspeed,yspeed)
		bullets[i].sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)
	end
	spawntimer = spawntimer + 1
end