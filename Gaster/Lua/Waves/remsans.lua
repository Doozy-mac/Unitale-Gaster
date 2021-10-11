require "gasterblasters"
StartBlasters()

timer = 0

curtain = CreateProjectileAbs("blackscreen",320,240)
Audio.PlaySound("click2")
Audio.Pause()
Arena.Resize(150,150)

function Update()
	if timer == 60 then
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		back = CreateSprite("blackscreen")
		back.MoveTo(320,240)
		sans = CreateSprite("void_sans_1")
		sans.SetAnimation({"void_sans_1","void_sans_2","void_sans_3","void_sans_4"})
		sans.MoveTo(320,360)
	end
	if timer == 180 then
		CreateBlaster(0,Arena.height*0.6,1,0,0,true)
	end
	if timer == 300 then
		Audio.PlaySound("click2")
		back.Remove()
		curtain.sprite.alpha = 1
		curtain.SendToTop()
		sans.Remove()
	end
	if timer == 360 then
		Audio.Play()
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		if curtain.isactive then
			curtain.Remove()
		end
		SetGlobal("wavetime",4)
		EndWave()	
	end
	HandleBlasters()
	timer = timer + 1
end

function OnHit(bullet)
	if bullet != curtain then
		Player.Hurt(1)
	end
end