spawntimer = 0
counter = 0
sign = 1
chars = {"wingdings/a","wingdings/b","wingdings/c","wingdings/d","wingdings/e","wingdings/f","wingdings/g","wingdings/h"}
--voices = {"Voices/gastervoice_1","Voices/gastervoice_2","Voices/gastervoice_3","Voices/gastervoice_4","Voices/gastervoice_5","Voices/gastervoice_6","Voices/gastervoice_7"}
shake = 2
bulletspeed = 3

bullets = {}

Arena.Resize(200,150)

lhand = CreateProjectile("gaster/weapons/gasterhand",-Arena.width,0)
rhand = CreateProjectile("gaster/weapons/gasterhandr",Arena.width,0)

realxl = lhand.x
realyl = lhand.y

realxr = rhand.x
realyr = rhand.y

function Update()
	lhand.MoveTo(realxl+math.random(-shake,shake),realyl+math.random(-shake,shake))
	rhand.MoveTo(realxr+math.random(-shake,shake),realyr+math.random(-shake,shake))
	if spawntimer%10 == 0 then
		bulletl = CreateProjectile(chars[math.random(1,#chars)],lhand.x+10,lhand.y+11)
		bulletr = CreateProjectile(chars[math.random(1,#chars)],rhand.x-10,rhand.y+11)
		bulletl.SetVar("angle",15*math.sin(counter/2)+200)
		bulletr.SetVar("angle",15*math.sin(counter/2)+100)
		--Audio.PlaySound(voices[math.random(1,#voices)])
		table.insert(bullets,bulletl)
		table.insert(bullets,bulletr)
		counter = counter + 1
	end
	spawntimer = spawntimer + 1
	for i=1,#bullets do
		local angle = bullets[i].GetVar("angle")
		bullets[i].Move(bulletspeed*math.cos(math.pi*angle/100),bulletspeed*math.sin(math.pi*angle/100))
	end
end