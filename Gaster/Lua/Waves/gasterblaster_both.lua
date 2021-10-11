require "gasterblasters"
StartBlasters()
spawntimer = 0
if GetGlobal("turnnumber") >= 5 then
	maxtime = 60
else
	maxtime = 70
end
horizdir = math.random(0,1)

function Update()
	if spawntimer%maxtime == 0 then
		horizdir = math.random(0,1)
		CreateBlaster(Player.x + math.random(0,4),Arena.height/2+60,1,0,1,False)
		if horizdir == 0 then
			CreateBlaster(-Arena.width/2-60,Player.y + math.random(0,4),0,0,1)
		else
			CreateBlaster(Arena.width/2+60,Player.y + math.random(0,4),2,0,1)
		end
		Audio.PlaySound("blaster")
	end
	HandleBlasters()
	spawntimer = spawntimer + 1
end