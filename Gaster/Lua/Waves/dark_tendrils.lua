spawntimer = 0
tendrils = {}
Arena.resize(170,120)

function Update()
	if spawntimer%47 == 0 then
		up = CreateProjectile("gaster/weapons/tendrilup",-Arena.width*0.6,-Arena.height/2+20)
		down = CreateProjectile("gaster/weapons/tendrildown",Arena.width*0.6,Arena.height/2-20)
		up.SetVar("xspeed",2)
		down.SetVar("xspeed",-2)
		table.insert(tendrils,up)
		table.insert(tendrils,down)
	end
	spawntimer = spawntimer + 1
	
	for i=1,#tendrils do
			if tendrils[i].isactive == true then
			local xspeed = tendrils[i].GetVar("xspeed")
			tendrils[i].Move(xspeed,0)
			if math.abs(tendrils[i].x) > (Arena.width*0.61) then
				tendrils[i].Remove()	
			end
		end
	end
end