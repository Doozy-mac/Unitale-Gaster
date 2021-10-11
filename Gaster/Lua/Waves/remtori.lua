timer = 0

hands = {}
bullets = {}

curtain = CreateProjectileAbs("blackscreen",320,240)
Audio.PlaySound("click2")
Audio.Pause()
Arena.Resize(150,150)
fireanim = {"spr_torielflame_0","spr_torielflame_1","spr_torielflame_2","spr_torielflame_3"}

function Update()
	if timer == 60 then
		Audio.PlaySound("click2")
		curtain.sprite.alpha = 0
		back = CreateSprite("blackscreen")
		back.MoveTo(320,240)
		toriel = CreateSprite("void_toriel_1")
		toriel.SetAnimation({"void_toriel_1","void_toriel_2","void_toriel_3","void_toriel_4"})
		toriel.MoveTo(320,360)
	end
	if timer == 90 then
		hand = CreateProjectile("spr_handbullet_1",-Arena.width/2,Arena.height/2-30)
	end
	if timer > 90 then
		if hand.x < Arena.width/2 then
			hand.Move(3,(timer/50 - 2)*2)
			if timer%5 == 0 then
				bullet = CreateProjectile("spr_torielflame_0",hand.x,hand.y)
				Audio.PlaySound("click2")
			if math.random(2) == 1 then
				bullet.SetVar("green",true)
			else
				bullet.SetVar("green",false)
			end
			bullet.SetVar("xspeed",0)
			bullet.SetVar("yspeed",0)
			bullet.SetVar("animstate",1)
			bullet.SetVar("ticker",0)
			table.insert(bullets,bullet)
			end
		end
	end
	if timer == 230 then
		Audio.PlaySound("click2")
		back.Remove()
		curtain.sprite.alpha = 1
		curtain.SendToTop()
		toriel.Remove()
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
			local xspeed = bullets[i].GetVar("xspeed")
			local yspeed = bullets[i].GetVar("yspeed")
			local ticker = bullets[i].GetVar("ticker")
			bullets[i].SetVar("ticker",ticker+1)
			local animstate = bullets[i].GetVar("animstate")
			bullets[i].sprite.set(fireanim[animstate])
			if animstate == 4 then
				bullets[i].SetVar("animstate",1)
			else
				bullets[i].SetVar("animstate",animstate + 1)
			end
			if bullets[i].GetVar("green") == true then
				bullets[i].sprite.color = {0,255,0}
			end
			if ticker == 1 then
				local xdifference = Player.x - bullet.x
				local ydifference = Player.y - bullet.y
				bullet.SetVar('xspeed', xdifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
				bullet.SetVar('yspeed', ydifference/math.sqrt(xdifference^2+ydifference^2)*2.5)
			end
			if ticker > 30 then
				bullets[i].Move(xspeed,yspeed)
			end
		end
	end
	timer = timer+1
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