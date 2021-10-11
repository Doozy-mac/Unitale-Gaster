spawntimer = 0
side = -1
oranges = {}
blues = {}
tendrils = {}
Arena.Resize(200,65)

function Update()
	spawntimer = spawntimer + 1
	if spawntimer%35 == 0 then
		side = side * -1
		tendril = CreateProjectile("gaster/weapons/tendrilup",0.5*Arena.width*side,-Arena.height/4)
		tendril.SetVar("speed",4*side*-1)
		local colorer = math.random(0,1)
		if colorer == 0 then
			tendril.sprite.color = {0,0.64,0.91}
			table.insert(blues,tendril)
		else
			tendril.sprite.color = {0.99,0.65,0}
			table.insert(oranges,tendril)
		end
		table.insert(tendrils,tendril)
	end
	for i=1,#tendrils do
		speed = tendrils[i].GetVar("speed")
		tendrils[i].Move(speed,0)
	end
end

function OnHit(bullet)
    if Player.isMoving then
		for j=1,#blues do
			if bullet == blues[j] then
				Player.Hurt(3)
			end
		end
	else 
		for j=1,#oranges do
			if bullet == oranges[j] then
				Player.Hurt(3)
			end
		end
    end
end