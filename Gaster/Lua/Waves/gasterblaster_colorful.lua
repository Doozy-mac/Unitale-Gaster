spawntimer = 0
bullets = {}
beams = {}
i = 0
j = 0
isleft = false
count = 0
Arena.resize(155,130)
function Update()
if spawntimer%75 == 0 then
	if math.random(10) <= 5 then
			horiz = -2.25*Arena.width+60
			orient = 90
			bullet = CreateProjectile("gaster/weapons/blueblaster",horiz,0)
			bullet.SetVar("color",0)
		else
			horiz = 2.25*Arena.width-60
			orient = -90
			bullet = CreateProjectile("gaster/weapons/orangeblaster",horiz,0)
			bullet.SetVar("color",1)
		end
		bullet.sprite.rotation = 0
		bullet.sprite.alpha = 0
		Audio.PlaySound("charge")
		bullet.SetVar(count,0)
		bullet.SetVar("playedsound",false)
		bullet.SetVar("shot",false)
		bullet.SetVar("gone",false)
		table.insert(bullets,bullet)
	end
spawntimer = spawntimer + 1
for i=1,#bullets do
	local xspeed = 0
	local posx = bullets[i].x
	local posy = bullets[i].y
	local alpha = bullets[i].sprite.alpha
	local rot = bullets[i].sprite.rotation
	bullets[i].sprite.alpha = alpha + 0.1
	if bullets[i].x < 0 then
		if bullets[i].sprite.rotation != 90 then
			rot = bullets[i].sprite.rotation
			bullets[i].sprite.rotation = rot+2
			xspeed = 0.5
		else
			xspeed = 0
			bullets[i].sprite.Set("gaster/weapons/blueblaster_firing")
			if bullets[i].GetVar("shot") == false then
				beam = CreateProjectile("gaster/weapons/bigbeam",bullets[i].x+600,bullets[i].y)
				beam.SetVar("timer",0)
				beam.SendToBottom()
				--beam.sprite.alpha = 1
				if bullets[i].GetVar("playedsound") == false then
					Audio.PlaySound("blasterfire")
					bullets[i].SetVar("playedsound",true) 
				end
				bullets[i].SetVar("shot",true)
				beam.sprite.color = {0,0.64,0.91}
				beam.SetVar("color",0)
				table.insert(beams,beam)
				else
					--local beamalpha = beam.sprite.alpha
					bullets[i].sprite.alpha = alpha -0.05
				--if beam.sprite.alpha == 0 then
					--bullets[i].Move(0,99999)
					--beam.Move(0,99999)
				--else
					--beamalpha = beamalpha-0.04
					--beam.sprite.alpha = bullets[i].sprite.alpha
				--end
			end
		end
	else
		if bullets[i].sprite.rotation != 270 then
			rot = bullets[i].sprite.rotation
			bullets[i].sprite.rotation = rot-2
			xspeed = -0.5
		else
			xspeed = 0
			bullets[i].sprite.Set("gaster/weapons/orangeblaster_firing")
			if bullets[i].GetVar("shot") == false then
				beam = CreateProjectile("gaster/weapons/bigbeam",bullets[i].x-600,bullets[i].y)
				beam.SetVar("timer",0)
				--beam.sprite.alpha = 1
				beam.SendToBottom()
				if bullets[i].GetVar("playedsound") == false then
					Audio.PlaySound("blasterfire")
					bullets[i].SetVar("playedsound",true) 
				end
				beam.sprite.color = {0.99,0.65,0}
				beam.SetVar("color",1)
				bullets[i].SetVar("shot",true)
				table.insert(beams,beam)
			else
				--local beamalpha = beam.sprite.alpha
				bullets[i].sprite.alpha = alpha - 0.05
				--if beam.sprite.alpha == 0 then
					--bullets[i].Move(0,99999)
					--beam.Move(0,99999)
				--else
					--beam.sprite.alpha = bullets[i].sprite.alpha
				--end
			end
		end
	end
	bullets[i].MoveTo(bullets[i].x+xspeed,posy)
	count = count + 1
end
for j=1,#beams do
	local beamalpha = beams[j].sprite.alpha
	beams[j].sprite.alpha = beamalpha-0.05
	if beamalpha == 0 then
		beams[j].Move(0,99999)
	end
end
end

function OnHit(bullet)
    if Player.isMoving then
		for j=1,#beams do
			if bullet == beams[j] and beams[j].GetVar("color") == 0 then
				Player.Hurt(5)
			end
		end
	else 
		for j=1,#beams do
			if bullet == beams[j] and beams[j].GetVar("color") == 1 then
				Player.Hurt(5)
			end
		end
    end
end