SetGlobal("handsgone",true)

Arena.Resize(300,110)

spawntimer = 0
side = 1
sprites = {"chaos/weapons/gasterfistr","chaos/weapons/gasterfistl"}
debris = {"chaos/weapons/debris","chaos/weapons/debris1","chaos/weapons/debris2"}
hands = {}
bullets = {}
shaker = -3

function Update()
	if spawntimer%45 == 0 then
		if Player.x < 0 then 
			side = 1
		else
			side = 2
		end
		hand = CreateProjectile(sprites[side],Player.x+math.random(-5,5),Arena.height*2)
		hand.SetVar("landed",false)
		hand.SetVar("impact",false)
		hand.SetVar("yspeed",0)
		hand.sprite.alpha = 0
		table.insert(hands,hand)
	end
	for i=1,#hands do
		if hands[i].isactive == true then
			if hands[i].y - 20 <= -Arena.height/2 then
				hands[i].SetVar("landed",true)
			end
			if hands[i].sprite.alpha < 1 and hands[i].GetVar("landed") == false then
				local alpha = hands[i].sprite.alpha
				hands[i].sprite.alpha = alpha + 0.05
			elseif hands[i].GetVar("landed") == false then
				local yspeed = hands[i].GetVar("yspeed")
				hands[i].SetVar("yspeed",yspeed-1)
			end
			if hands[i].GetVar("landed") == true then
				hands[i].SetVar("yspeed",0)
				if hands[i].GetVar("impact") == false then
					Audio.PlaySound("impact")
					for j=1,5 do
						bullet = CreateProjectile(debris[math.random(1,3)],hands[i].x+math.random(-10,10),hands[i].y-20)
						bullet.SetVar("direction",180+math.random(j*10,j*26))
						bullet.SetVar("speed",3)
						bullet.SetVar("spin",math.random(-30,30))
						bullet.SendToBottom()
						table.insert(bullets,bullet)
					end
					hands[i].SetVar("impact",true)
				end
				if hands[i].sprite.alpha > 0 then
					local alpha = hands[i].sprite.alpha
					hands[i].sprite.alpha = alpha - 0.05
				else
					hands[i].Remove()
				end
				Arena.ResizeImmediate(300,110+shaker)
			end
			hands[i].Move(0,hands[i].GetVar("yspeed"))
		end
	end
	for i=1,#bullets do
		local angle = bullets[i].GetVar("direction")
		local bulletspeed = bullets[i].GetVar("speed")
		bullets[i].move(bulletspeed*math.cos(math.pi*angle/100),bulletspeed*math.sin(math.pi*angle/100))
		local rotation = bullets[i].sprite.rotation
		bullets[i].sprite.rotation = rotation + bullets[i].GetVar("spin")
	end
	spawntimer = spawntimer + 1
	shaker = shaker * -1
end