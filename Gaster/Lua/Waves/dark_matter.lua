require "gasterblasters"
StartBlasters()
spawntimer = 0
blastertimer = 0
toggle = -1
tendrils = {}
Arena.resize(275,120)

function Update()
	if spawntimer%47 == 0 then
		up = CreateProjectile("gaster/weapons/tendrilup",-Arena.width*0.6,-Arena.height/2+20)
		down = CreateProjectile("gaster/weapons/tendrildown",Arena.width*0.6,Arena.height/2-20)
		up.SetVar("xspeed",2)
		down.SetVar("xspeed",-2)
		table.insert(tendrils,up)
		table.insert(tendrils,down)
	end
	if blastertimer%80 == 0 then
		toggle = toggle*-1
		CreateBlaster(toggle*Arena.width/2,toggle*Arena.height/4,toggle+1,0,0,true)
	end
	spawntimer = spawntimer + 1
	blastertimer = blastertimer + 1
	for i=1,#tendrils do
			if tendrils[i].isactive == true then
			local xspeed = tendrils[i].GetVar("xspeed")
			tendrils[i].Move(xspeed,0)
			tendrils[i].SendToBottom()
			if math.abs(tendrils[i].x) > (Arena.width*0.61) then
				tendrils[i].Remove()
			end
		end
	end
	HandleBlasters()
end