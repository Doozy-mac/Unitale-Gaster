timer = 0
blues = {}
oranges = {}
Arena.resize(150,150)
xcoord = 0
Player.MoveTo(38,38,false)
slow = 0
--clockface = CreateProjectile("clockface",0,0)

for i=0,12 do
	blue = CreateProjectile("gaster/weapons/shot",0,0)
	blue.SetVar("yfactor",0)
	orange = CreateProjectile("gaster/weapons/shot",0,0)
	orange.SetVar("xfactor",0)
	if i%2 == 0 then
		blue.SetVar("yfactor",11)
		orange.SetVar("xfactor",11)
	else
		blue.SetVar("yfactor",-11)
		orange.SetVar("xfactor",-11)
	end
	blue.sprite.color = {0,0.64,0.91}
	orange.sprite.color = {0.99,0.65,0}
	blue.MoveTo(-Arena.width/2,i*blue.GetVar("yfactor")-Arena.height/2)
	orange.MoveTo(i*orange.GetVar("xfactor")-Arena.width/2,-Arena.height/2)
	blue.SetVar("radius",i*blue.GetVar("yfactor"))
	orange.SetVar("radius",i*orange.GetVar("xfactor"))
	table.insert(blues,blue)
	table.insert(oranges,orange)
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

function Update()
		timer = timer + 1
	for j=1,#blues do
		local radius = blues[j].GetVar("radius")
		blues[j].MoveTo(math.cos(timer/30)*radius,math.sin(timer/30)*radius)
	end
	for j=1,#oranges do
		local radius = oranges[j].GetVar("radius")
		oranges[j].MoveTo(math.cos(timer/-30)*radius,math.sin(timer/-30)*radius)
	end
end