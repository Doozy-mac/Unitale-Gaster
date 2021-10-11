require "gasterblasters"
StartBlasters()
screenalpha = 0
timer = 0
scalefactor = 0.85

crash = CreateProjectileAbs("errorscreen",320,240)
crashes = {"errorscreen","errorcorrupt1","errorcorrupt2","errorcorrupt3","errorcorrupt5"}
tendrils = {}
--screen.sprite.xscale = 35
--screen.sprite.yscale = 35

--face = CreateProjectile("")

function Update()
	--[[screenalpha = screen.sprite.alpha
	screen.sprite.alpha = screenalpha +0.04]]
	timer = timer + 1
	if timer == math.floor(120*scalefactor) then
		Audio.PlaySound("dialup")
	end
	if timer > math.floor(120*scalefactor) and timer < 780*scalefactor then
		crash.sprite.Set(crashes[math.random(#crashes)])
		if math.random(2) == 1 then
			crash.sprite.Scale(math.random(100,200)/100,math.random(100,120)/100)
			crash.sprite.color = {math.random(5,10)/10,math.random(5,10)/10,math.random(5,10)/10}
		else
			crash.sprite.Scale(1,1)
			crash.sprite.color = {1,1,1}
		end
	end
	if timer == math.floor(600*scalefactor) then
		Audio.PlaySound("roar")
		table.insert(crashes,"errorcorrupt4")
	end
	--[[if timer > 600*scalefactor and timer < 780*scalefactor then
		if math.random(2) == 1 then
			crash.sprite.Set(crashes[math.random(#crashes)])
		else
			crash.sprite.Set(crashes[#crashes])
		end
	end]]
	if timer == math.floor(780*scalefactor) then
		Audio.PlaySound("click2")
		crash.sprite.Set("blackscreen")
	end
	if timer == math.floor(900*scalefactor) then
		SetGlobal("wavetime",4)
		Audio.PlaySound("click2")
		crash.sprite.alpha = 0
		SetGlobal("phase",3)
	end
	if timer == math.floor(930*scalefactor) then
		CreateBlaster(0,Arena.height/2,1,0,0,true)
		CreateBlaster(-Arena.width/2,0,0,0,0,true)
	end
	if timer == math.floor(990*scalefactor) then
		CreateBlaster(-Arena.width/2+16,Arena.height/2,1,0,0,true)
		CreateBlaster(Arena.width/2-16,Arena.height/2,1,0,0,true)
	end
	
	if timer == math.floor(1060*scalefactor) then
		Arena.Resize(140,100)
	end
	
	if timer >= 1090*scalefactor and timer <= 1112*scalefactor then
		if timer%6 == 0 then
			tendril = CreateProjectile("gaster/weapons/tendrilup",-70,-25)
			Audio.PlaySound("skewer")
			table.insert(tendrils,tendril)
		end
	end
	if timer >= 1130*scalefactor and timer <= 1152*scalefactor then
		if timer%6 == 0 then
			tendril = CreateProjectile("gaster/weapons/tendrildown",-70,25)
			Audio.PlaySound("skewer")
			table.insert(tendrils,tendril)
		end
	end
	if timer == math.floor(1170*scalefactor) then
		CreateBlaster(-Arena.width/2,Arena.height/2,0,0,0,true)
		CreateBlaster(Arena.width/2,-Arena.height/2,2,0,0,true)
	end
	if timer == math.floor(1200*scalefactor) then
		CreateBlaster(0,74,1,0,0,true)
	end
	if timer == math.floor(1230*scalefactor) then
		--CreateBlaster(-Arena.width/2+16,Arena.height/2,1,0,0,true)
		Arena.Resize(140,140)
	end
	if timer == math.floor(1255*scalefactor) then
		CreateBlaster(Arena.width/4,-Arena.height/2,3,0,0,true)
		CreateBlaster(Arena.width/2,-Arena.height/4,2,0,0,true)
	end
	if timer == math.floor(1315*scalefactor) then
		CreateBlaster(-Arena.width/4,Arena.height/2,1,0,0,true)
		CreateBlaster(-Arena.width/2,Arena.height/4,0,0,0,true)
	end
	if timer >= 1550*scalefactor then
		crash.sprite.alpha = 0
		if crash.isactive then
			crash.Remove()
		end
		EndWave()
	end
	HandleBlasters()
	for i=1,#tendrils do
		if tendrils[i].isactive then
			tendrils[i].Move(4,0)
			if math.abs(tendrils[i].x) > 92 then
				tendrils[i].Remove()
			end
		end
	end
end

function OnHit(bullet)
	if bullet != crash then
		Player.Hurt(3,0.5)
	end
end