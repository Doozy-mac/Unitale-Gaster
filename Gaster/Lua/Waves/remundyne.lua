timer = 0
bullets = {}

curtain = CreateProjectileAbs("blackscreen",320,240)
Audio.PlaySound("click2")
Audio.Pause()
Arena.Resize(150,150)

function Update()
	timer = timer+1
	if timer == 60 then
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		back = CreateSprite("blackscreen")
		back.MoveTo(320,240)
		undyne = CreateSprite("void_undyne_1")
		undyne.SetAnimation({"void_undyne_1","void_undyne_2","void_undyne_3","void_undyne_4"})
		undyne.MoveTo(320,360)
	end
	if timer == 230 then
		Audio.PlaySound("click2")
		back.Remove()
		curtain.sprite.alpha = 1
		curtain.SendToTop()
		undyne.Remove()
	end
	if timer == 300 then
		Audio.Play()
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		if curtain.isactive then
			curtain.Remove()
		end
		SetGlobal("wavetime",4)
		EndWave()
	end
	for i=1,#bullets do
		if bullets[i].isactive then
			local ticker = bullets[i].GetVar("ticker")
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
			else
				bullets[i].sprite.alpha = alpha + 0.05
			end
			if ticker == 20 then
				Audio.PlaySound("whoosh")
			end
			bullets[i].SetVar("ticker",ticker+1)
		end
	end
	if timer > 60 then
		if timer%30 == 0 then
			bullet = CreateProjectile("undyne_spear",math.random(Arena.width*0.7,Arena.width)*(2 * math.random(0,1)-1),math.random(Arena.height*0.7,Arena.height)*(2 * math.random(0,1)-1))
			Audio.PlaySound("spearcharge")
			local xdifference = Player.x - bullet.x
			local ydifference = Player.y - bullet.y
			bullet.sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)
			bullet.SetVar("rtarget",bullet.sprite.rotation)
			local rotate = bullet.GetVar("rtarget")
			bullet.sprite.rotation = rotate + 180
			bullet.sprite.alpha = 0
			bullet.SetVar('xspeed', xdifference/math.sqrt(xdifference^2+ydifference^2)*5)
			bullet.SetVar('yspeed', ydifference/math.sqrt(xdifference^2+ydifference^2)*5)
			if math.random(2) == 1 then
				bullet.SetVar("green",true)
				bullet.sprite.color = {0,255,0}
			else
				bullet.SetVar("green",false)
			end
			bullet.SetVar("ticker",0)
			table.insert(bullets,bullet)
		end
	end
end

function OnHit(bullet)
	if bullet != curtain then
		for i=1,#bullets do
				if bullets[i].isactive then
				if bullets[i].GetVar("green") == true and bullets[i] == bullet then
					Player.Heal(2)
					bullets[i].Remove()
				else
					Player.Hurt(1)
				end
			end
		end
	end
end