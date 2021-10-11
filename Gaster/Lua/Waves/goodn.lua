Arena.Resize(16,16)
SetGlobal("handsgone",true)

spawntimer = 0
side = 1
sprites = {"chaos/weapons/gasterfistr","chaos/weapons/gasterfistl"}
hands = {}
bullets = {}
		hand = CreateProjectile(sprites[side],Player.x,Arena.height*10)
		hand.SetVar("landed",false)
		hand.SetVar("impact",false)
		hand.SetVar("yspeed",0)
		hand.sprite.alpha = 0
		table.insert(hands,hand)

function Update()
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
					hands[i].SetVar("impact",true)
				end
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
end

function OnHit(bullet)
	Player.Hurt(1,0)
end