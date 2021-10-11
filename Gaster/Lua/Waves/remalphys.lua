timer = 0

curtain = CreateProjectileAbs("blackscreen",320,240)
Audio.PlaySound("click2")
Audio.Pause()
Arena.Resize(150,150)

bullets = {}

function Update()
	if timer == 60 then
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		back = CreateSprite("blackscreen")
		back.MoveTo(320,240)
		alphys = CreateSprite("void_alphys_1")
		alphys.SetAnimation({"void_alphys_1","void_alphys_2","void_alphys_3","void_alphys_4"})
		alphys.MoveTo(320,360)
	end
	if timer > 60 and timer < 230 then
		if timer % 10 == 0 then
			bullet = CreateProjectile("alphysbullet",math.random(-70,70),400)
			if math.random(2) == 1 then
				bullet.SetVar("green",true)
				bullet.sprite.color = {0,255,0}
			else
				bullet.SetVar("green",false)
			end
			table.insert(bullets,bullet)
		end
		for i=1,#bullets do
			if bullets[i].isactive then
				bullets[i].Move(0,-5)
			end
		end
	end
	if timer == 230 then
		Audio.PlaySound("click2")
		back.Remove()
		curtain.sprite.alpha = 1
		curtain.SendToTop()
		alphys.Remove()
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
	timer = timer + 1
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