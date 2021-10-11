timer = 0

bones = {}

curtain = CreateProjectileAbs("blackscreen",320,240)
Audio.PlaySound("click2")
Audio.Pause()
Arena.Resize(150,150)
sizes = {"bone1","bone2","bone3","bone4","bone5"}

function Update()
	if timer == 60 then
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		back = CreateSprite("blackscreen")
		back.MoveTo(320,240)
		paps = CreateSprite("void_paps_1")
		paps.SetAnimation({"void_paps_1","void_paps_2","void_paps_3","void_paps_4"})
		paps.MoveTo(320,360)
	end
	if timer > 90 and timer < 230 then
		if timer%10 == 0 then
			bone = CreateProjectile(sizes[math.random(#sizes)],Arena.width/2,0)
			local toggler = (2 * math.random(0,1)-1)
			bone.Move(0,Arena.height/2*toggler - bone.sprite.height/2 * toggler)
			if math.random(3) <= 2 then
				bone.SetVar("green",true)
				bone.sprite.color = {0,255,0}
			else
				bone.SetVar("green",false)
			end
			bone.SetVar("speed",math.random(-5,-2))
			table.insert(bones,bone)
		end
		for i=1,#bones do
			if bones[i].isactive then
				local speed = bones[i].GetVar("speed")
				bones[i].Move(speed,0)
				if bones[i].x <= -Arena.width/2 then
					bones[i].Remove()
				end
			end
		end
	end
	if timer == 230 then
		Audio.PlaySound("click2")
		back.Remove()
		curtain.sprite.alpha = 1
		curtain.SendToTop()
		paps.Remove()
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
	timer = timer+1
end

function OnHit(bullet)
	if bullet != curtain then
		for i=1,#bones do
				if bones[i].isactive then
				if bones[i].GetVar("green") == true and bones[i] == bullet then
					Player.Heal(2)
					bones[i].Remove()
				else
					Player.Hurt(1)
				end
			end
		end
	end
end
