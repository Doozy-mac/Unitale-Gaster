SetGlobal("usingpowers",true)
red = {1,0,0}
cyan = {0.26,0.89,1}
orange = {0.99,0.65,0}
purple = {0.81,0.21,0.85}
white = {1,1,1}
colors = {red,cyan,orange,purple,white}
cratersprites = {"chaos/weapons/crater","chaos/weapons/crater1","chaos/weapons/crater2"}
timer = 0
spawntime = 20
lasers = {}
craters = {}
chunks = {}
xpos = 0
ypos = 0
Arena.resize(155,130)

function Update()
	if timer%spawntime == 0 then
		for i=1,2 do
			if i==1 then
				xpos = GetGlobal("formx")-30
			else
				xpos = GetGlobal("formx")+30
			end
			ypos = GetGlobal("formy")
			laser = CreateProjectileAbs("chaos/weapons/eyelaser",xpos,ypos)
			--laser.sprite.SetAnchor(0,0.5)
			laser.sprite.SetPivot(0,0.5)
			local xdifference = Player.x - laser.x
			local ydifference = Player.y - laser.y
			laser.sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)+90
			laser.SetVar('xspeed', xdifference/math.sqrt(xdifference^2+ydifference^2)*6)
			laser.SetVar('yspeed', ydifference/math.sqrt(xdifference^2+ydifference^2)*6)
			table.insert(lasers,laser)
		end
		Audio.PlaySound("pew")
	end
	for j=1,#lasers do
		local xspeed = lasers[j].GetVar("xspeed")
		local yspeed = lasers[j].GetVar("yspeed")
		lasers[j].sprite.color = colors[math.random(1,#colors)]
		lasers[j].Move(xspeed,yspeed)
	end
	timer = timer+1
end