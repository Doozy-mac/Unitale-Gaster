require "gasterblasters"
StartBlasters()
spawntimer = 0
bullets = {}
beams = {}
i = 0
j = 0
isleft = false
count = 0
broken = false
screenalpha = 0
screenexists = false
CreateBlasterAbs(87,115,1,0,1,true)
--SetGlobal("usingpowers",false)

Arena.resize(155,130)
function Update()--[[87,115]]
	if CheckFired(1) == true and screenexists == false then
		screen = CreateProjectileAbs("whitescreen",0,0)
		screen.sprite.alpha = 0
		screenexists = true
	end
--[[spawntimer = spawntimer + 1
	if broken == false then
		
	for i=1,#bullets do
	local xspeed = 0
	local posx = bullets[i].x
	local posy = bullets[i].y
	local alpha = bullets[i].sprite.alpha
	local rot = bullets[i].sprite.rotation
	bullets[i].sprite.alpha = alpha + 0.1
	if bullets[i].sprite.rotation != 0 then
		rot = bullets[i].sprite.rotation
		bullets[i].sprite.rotation = rot-1
		yspeed = -0.05
	else
		yspeed = 0
		bullets[i].sprite.Set("gaster/weapons/spr_gasterblaster_5")
		if bullets[i].GetVar("shot") == false then
			beam = CreateProjectile("gaster/weapons/beamy",bullets[i].x,bullets[i].y-300)
			beam.SetVar("timer",0)
			beam.SendToBottom()
			screen = CreateProjectileAbs("whitescreen",0,0)
			screen.sprite.alpha = 0
			screenexists = true
				--beam.sprite.alpha = 1
				if bullets[i].GetVar("playedsound") == false then
					Audio.PlaySound("blasterfire")
					bullets[i].SetVar("playedsound",true) 
				end
				bullets[i].SetVar("shot",true)
				SetGlobal("fightbroken",true)
				table.insert(beams,beam)
				else
					--local beamalpha = beam.sprite.alpha
					--bullets[i].sprite.alpha = alpha -0.01
				--if beam.sprite.alpha == 0 then
					--bullets[i].Move(0,99999)
					--beam.Move(0,99999)
				--else
					--beamalpha = beamalpha-0.04
					--beam.sprite.alpha = bullets[i].sprite.alpha
				--end
			end
		end
	bullets[i].MoveTo(posx,bullets[i].y+yspeed)
	count = count + 1]]

	if screenexists == true then
		screenalpha = screen.sprite.alpha
		screen.sprite.xscale = 81
		screen.sprite.yscale = 81
		screen.sprite.alpha = screenalpha+0.1
		if screen.sprite.alpha == 1 then
			SetGlobal("fightbroken",true)
		end
	end
	HandleBlasters()
end