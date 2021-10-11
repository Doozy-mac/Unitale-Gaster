spawntimer = 0
freq = 31
bullets = {}
iter=1
Arena.resize(120,120)

function Update()
	spawntimer = spawntimer + 1
	if spawntimer%freq == 0 then
		for i=1,6 do
			bullet = CreateProjectile("gaster/weapons/shot",0,200)
			bullet.SetVar("timer",0)
			bullet.SetVar("animated",false)
			bullet.SetVar("offset",i*math.pi/3)
			bullet.SetVar("dir",iter)
		--Audio.PlaySound("gun")
			table.insert(bullets,bullet)
		end
		iter = iter*-1
	end
	for i=1,#bullets do
		local offset = bullets[i].GetVar("offset")
		local timer = bullets[i].GetVar("timer")
		local dir = bullets[i].GetVar("dir")
		bullets[i].SetVar("timer",timer + 1)
		bullets[i].MoveTo(math.cos(0.51*timer*dir/23+offset)*(timer),math.sin(0.51*timer*dir/23+offset)*(timer)+Arena.height)
	end
end