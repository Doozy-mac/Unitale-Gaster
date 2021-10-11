--Congradulations! You've found the secret gaster blaster library by u/DeusZedMachina. Not posting this to the subreddit because 
--a) the code looks like goddamned spaghetti cuz I made it back when I first started coding lua; 
--   its internal workings are a mystery even to me and
--b) we need more originality on the sub. If you must use gaster blasters, please at least /try/ to code your own c: these blasters are far
--   from perfect and they don't work very much like the ones in the actual game. 

bullets_horiz = {}
bullets_vert = {}
pulsers = {}
beams_horiz = {}
beams_vert = {}
eyes = {}
i = 0
j = 0
count = 0

function StartBlasters()	
	bullets = {}
	pulsers = {}
	beams = {}
	eyes = {}
	blastanim = {"gaster/weapons/spr_gasterblaster_1","gaster/weapons/spr_gasterblaster_2","gaster/weapons/spr_gasterblaster_3","gaster/weapons/spr_gasterblaster_4","gaster/weapons/spr_gasterblaster_5"}
	altblastanim = {"gaster/weapons/blaster_narrow_1","gaster/weapons/blaster_narrow_2","gaster/weapons/blaster_narrow_3","gaster/weapons/blaster_narrow_4","gaster/weapons/blaster_narrow_5"}
	beamsprites = {"gaster/weapons/beamx","gaster/weapons/beamy"}
	beamxanim = {"gaster/weapons/beamx","gaster/weapons/beamxnarrow"}
	beamyanim = {"gaster/weapons/beamy","gaster/weapons/beamynarrow"}
	bigbeamxanim = {"gaster/weapons/bigbeamx","gaster/weapons/bigbeamx1"}
	bigbeamyanim = {"gaster/weapons/bigbeamy","gaster/weapons/bigbeamy1"}
	playsound1 = false
	playsound2 = false
	i = 0
	j = 0
	count = 0
end 

function CreateBlaster(xtarget,ytarget,facing,shape,beamsize,dosound) --facing: 0 = pointing right, 1 = pointing down, 2 = pointing left, 3 = pointing up
	local blastspr = "gaster/weapons/spr_gasterblaster_0"
	local blastframes = blastanim
	if shape == 0 then
		blastspr = "gaster/weapons/spr_gasterblaster_0"
		blastframes = blastanim
	else
		blastspr = "gaster/weapons/blaster_narrow_0"
		blastframes = altblastanim
	end
	bullet = CreateProjectile(blastspr,xtarget,ytarget)
	--if facing > 0 then
		bullet.sprite.rotation = 360 - 90*facing
		local rot = bullet.sprite.rotation
		bullet.SetVar("target",rot)
	--[[else
		bullet.sprite.rotation = 0
		local rot = bullet.sprite.rotation
		bullet.SetVar("target",360)
	end]]
	--local rot = bullet.sprite.rotation
	bullet.sprite.rotation = rot + 180
	if facing == 0 then
		bullet.SetVar("xmotion",1)
		bullet.SetVar("ymotion",0)
	elseif facing == 1 then
		bullet.SetVar("xmotion",0)
		bullet.SetVar("ymotion",-1)
	elseif facing == 2 then
		bullet.SetVar("xmotion",-1)
		bullet.SetVar("ymotion",0)
	elseif facing == 3 then
		bullet.SetVar("xmotion",0)
		bullet.SetVar("ymotion",1)
	end
	--bullet.sprite.alpha = 0
	if dosound == true then
		Audio.PlaySound("blaster")
	end
	bullet.SetVar("count",0)
	bullet.SetVar("playedsound",false)
	bullet.SetVar("speed",1440/81)
	bullet.SetVar("reached",false)
	bullet.SetVar("shot",false)
	bullet.SetVar("gone",false)
	bullet.SetVar("orient",facing)
	bullet.SetVar("xtarget",bullet.x)
	bullet.SetVar("ytarget",bullet.y)
	bullet.SetVar("animtimer",0)
	bullet.SetVar("animindex",1)
	bullet.SetVar("blastframes",blastframes)
	bullet.SetVar("beamsize",beamsize)
	local xmotion = bullet.GetVar("xmotion")
	local ymotion = bullet.GetVar("ymotion")
	bullet.Move(-470*xmotion,-470*ymotion)
	table.insert(bullets,bullet)
	playsound1 = true
end

function CreateBlasterAbs(xtarget,ytarget,facing,shape,beamsize,dosound) --facing: 0 = pointing right, 1 = pointing down, 2 = pointing left, 3 = pointing up
	local blastspr = "gaster/weapons/spr_gasterblaster_0"
	local blastframes = blastanim
	if shape == 0 then
		blastspr = "gaster/weapons/spr_gasterblaster_0"
		blastframes = blastanim
	else
		blastspr = "gaster/weapons/blaster_narrow_0"
		blastframes = altblastanim
	end
	bullet = CreateProjectileAbs(blastspr,xtarget,ytarget)
	--if facing > 0 then
		bullet.sprite.rotation = 360 - 90*facing
		local rot = bullet.sprite.rotation
		bullet.SetVar("target",rot)
	--[[else
		bullet.sprite.rotation = 0
		local rot = bullet.sprite.rotation
		bullet.SetVar("target",360)
	end]]
	--local rot = bullet.sprite.rotation
	bullet.sprite.rotation = rot + 180
	if facing == 0 then
		bullet.SetVar("xmotion",1)
		bullet.SetVar("ymotion",0)
	elseif facing == 1 then
		bullet.SetVar("xmotion",0)
		bullet.SetVar("ymotion",-1)
	elseif facing == 2 then
		bullet.SetVar("xmotion",-1)
		bullet.SetVar("ymotion",0)
	elseif facing == 3 then
		bullet.SetVar("xmotion",0)
		bullet.SetVar("ymotion",1)
	end
	--bullet.sprite.alpha = 0
	if dosound == true then
		Audio.PlaySound("blaster")
	end
	bullet.SetVar("count",0)
	bullet.SetVar("playedsound",false)
	bullet.SetVar("speed",1440/81)
	bullet.SetVar("reached",false)
	bullet.SetVar("shot",false)
	bullet.SetVar("gone",false)
	bullet.SetVar("orient",facing)
	bullet.SetVar("xtarget",bullet.x)
	bullet.SetVar("ytarget",bullet.y)
	bullet.SetVar("animtimer",0)
	bullet.SetVar("animindex",1)
	bullet.SetVar("blastframes",blastframes)
	bullet.SetVar("beamsize",beamsize)
	local xmotion = bullet.GetVar("xmotion")
	local ymotion = bullet.GetVar("ymotion")
	bullet.Move(-470*xmotion,-470*ymotion)
	table.insert(bullets,bullet)
	playsound1 = true
end

function CreatePulser(xcoord,ycoord,facing,eyespeed) --0 = right, 1 = left, 2 = down
	if facing == 0 then
		face = 90
	elseif facing == 1 then
		face = 270
	else
		face = 0
	end
	pulser = CreateProjectile("gaster/weapons/eyegun",xcoord,ycoord)
	pulser.sprite.rotation = face
	pulser.sprite.alpha = 0.5
	pulser.SetVar("facing",facing)
	pulser.SetVar("eyespeed",eyespeed)
	pulser.SetVar("shot",false)
	table.insert(pulsers,pulser)
end

function HandleBlasters()
	for i=1,#bullets do
		playsound2 = false
		local xmotion = bullets[i].GetVar("xmotion")
		local ymotion = bullets[i].GetVar("ymotion")
		local shot = bullets[i].GetVar("shot")
		local rotate = bullets[i].sprite.rotation
		local reached = bullets[i].GetVar("reached")
		local target = bullets[i].GetVar("target")
		local speed = bullets[i].GetVar("speed")
		local xtarget = bullets[i].GetVar("xtarget")
		local ytarget = bullets[i].GetVar("ytarget")
		local count = bullets[i].GetVar("count")
		local spin = -(xmotion + ymotion)
		local waitfactor = 1
		local animtimer = bullets[i].GetVar("animtimer")
		local animindex = bullets[i].GetVar("animindex")
		local spriteindex = 1
		local blastframes = bullets[i].GetVar("blastframes")
		local beamsize = bullets[i].GetVar("beamsize")
		if reached == false then
			if speed > 0 then
				--bullets[i].SetVar("count",count+1)
				if math.ceil(bullets[i].sprite.rotation) < target-1 or math.ceil(bullets[i].sprite.rotation) > target+1 then
					bullets[i].sprite.rotation = rotate + (target-rotate)/7
				else
					bullets[i].sprite.rotation = target
				end
			else
				bullets[i].SetVar("reached",true)
			end
		else
			bullets[i].sprite.rotation = target
			if count <= 22 then
				waitfactor = 0
			elseif count > 22 and count < 25 then
				bullets[i].sprite.Set(blastframes[count-22])
			elseif count == 25 then
				local anim = beamxanim
				bullets[i].sprite.Set(blastanim[3])
				bullets[i].SetVar("shot",true)
				if bullets[i].GetVar("orient")%2 == 0 then
					if beamsize == 0 then
						spriteindex = 1
						anim = bigbeamxanim
					else
						spriteindex = 1
						anim = beamxanim
					end
				else
					if beamsize == 0 then
						spriteindex = 2
						anim = bigbeamyanim
					else
						spriteindex = 2
						anim = beamyanim
					end
				end
				beam = CreateProjectile(beamsprites[spriteindex],bullets[i].x + 750*xmotion,bullets[i].y + 750*ymotion)
				beam.SendToBottom()
				beam.SetVar("parent",bullets[i])
				beam.SetVar("alarm",0)
				beam.SetVar("anim",anim)
				beam.SetVar("animtimer",0)
				beam.SetVar("animindex",1)
				table.insert(beams,beam)
				playsound2 = true
				Audio.PlaySound("blasterfire")
			else
				playsound2 = false
				waitfactor = 1
				if animtimer >= 2 then
					if animindex == 4 then
						bullets[i].SetVar("animindex",5)
					else
						bullets[i].SetVar("animindex",4)
					end
					bullets[i].SetVar("animtimer",0)
				end
				bullets[i].SetVar("animtimer",animtimer + 1)
				bullets[i].sprite.Set(blastframes[animindex])
			end
			bullets[i].SetVar("count",count+1)
		end
		bullets[i].Move(xmotion*speed*waitfactor,ymotion*speed*waitfactor)
		bullets[i].SetVar("speed",speed-32*waitfactor/81)
	end
	for i=1,#beams do
		if beams[i].isactive == true then
			local parent = beams[i].GetVar("parent")
			local xmotion = parent.GetVar("xmotion")
			local ymotion = parent.GetVar("ymotion")
			local speed = parent.GetVar("speed")
			local alarm = beams[i].GetVar("alarm")
			local xsc = beams[i].sprite.xscale
			local ysc = beams[i].sprite.yscale
			local anim = beams[i].GetVar("anim")
			local animtimer = beams[i].GetVar("animtimer")
			local animindex = beams[i].GetVar("animindex")
			local alpha = beams[i].sprite.alpha
			beams[i].SetVar("alarm",alarm + 1)
			if speed > -1440/81 then
				beams[i].MoveTo(parent.x+xmotion*750,parent.y+ymotion*750)
			end
			if animtimer >= 1 then
				if animindex == 1 then
					beams[i].SetVar("animindex",2)
				else
					beams[i].SetVar("animindex",1)
				end
				beams[i].SetVar("animtimer",0)
			end
			beams[i].SetVar("animtimer",animtimer + 1)
			beams[i].sprite.Set(anim[animindex])
			if alarm > 20 then
				beams[i].sprite.alpha = alpha - 0.05
			end
			if beams[i].sprite.alpha < 0.1 then
				beams[i].Remove()
			end
		end
	end
	if playsound1 == true then
		Audio.PlaySound("blaster")
	end
	if playsound2 == true then
		Audio.PlaySound("blasterfire")
	end
	playsound1 = false
	playsound2 = false
end

function CheckFired(index)
	if bullets[index].GetVar("shot") == true then
		return true
	else
		return false
	end
end

function HandlePulsers()
	for g=1,#pulsers do
		local facing = pulsers[g].GetVar("facing")
		local eyespeed = pulsers[g].GetVar("eyespeed")
		local direction = 0
		if pulsers[g].GetVar("shot") == false then
			if pulsers[g].sprite.alpha != 1 then
				local alpha = pulsers[g].sprite.alpha
				pulsers[g].sprite.alpha = alpha + 0.05
			else
				eye = CreateProjectile("gaster/weapons/eye0",pulsers[g].x,pulsers[g].y)
				Audio.PlaySound("gun")
				if facing == 0 then
					eye.SetVar("xspeed",eyespeed)
					eye.SetVar("yspeed",0)
				elseif facing == 1 then
					eye.SetVar("xspeed",-eyespeed)
					eye.SetVar("yspeed",0)
				else
					eye.SetVar("xspeed",0)
					eye.SetVar("yspeed",-eyespeed)
				end
				table.insert(eyes,eye)
				pulsers[g].SetVar("shot",true)
			end
		else
			local alpha = pulsers[g].sprite.alpha
			pulsers[g].sprite.alpha = alpha - 0.05
		end
	end
	for f=1,#eyes do
		local xspeed = eyes[f].GetVar("xspeed")
		local yspeed = eyes[f].GetVar("yspeed")
		local xdifference = Player.x - eyes[f].x
		local ydifference = Player.y - eyes[f].y
		eyes[f].sprite.rotation = 57.2958*math.atan2(ydifference,xdifference)
		eyes[f].Move(xspeed,yspeed)
	end
end