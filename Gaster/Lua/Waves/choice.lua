Arena.Resize(400,120)
fight = CreateProjectile("UI/buttons/fightbt_0",-Arena.width/4,0)
mercy = CreateProjectile("UI/buttons/mercybt_0",Arena.width/4,0)
heart = CreateProjectile("ut-heart",0,0)
heart.sprite.color = {1,0,0}
slice = CreateProjectile("spr_slice_o_3",0,200)
slice.sprite.alpha = 0
slicing = false
slicetimer = 0
fight.SetVar("hovering",false)
mercy.SetVar("hovering",false)
options = {fight,mercy}
defaultsprites = {"UI/buttons/fightbt_0","UI/buttons/mercybt_0"}
hoversprites = {"UI/buttons/fightbt_1","UI/buttons/mercybt_1"}
sliceanim = {"spr_slice_o_0","spr_slice_o_1","spr_slice_o_2","spr_slice_o_3","spr_slice_o_4","spr_slice_o_5"}
for i=1,#options do
	options[i].SendToBottom()
end

function Update()
	heart.MoveTo(Player.x,Player.y)
	for i = 1, #options do
		if options[i].isactive then
		if options[i].GetVar("hovering") == true then
			options[i].sprite.Set(hoversprites[i])
		else
			options[i].sprite.Set(defaultsprites[i])
		end
		if options[i].GetVar("hovering") == true then
			if Input.Confirm == 1 then
				Choose(options[i])
			end
			options[i].SetVar("hovering",false)
		end
		end
	end
	if slicing == true then
		if slicetimer <= #sliceanim*2 then
				if slicetimer % 2 == 0 then
					slice.sprite.Set(sliceanim[slicetimer/2])
				end
				if slicetimer == #sliceanim*2 then
					Audio.PlaySound("hitsound")
				end
		else
			slice.sprite.alpha = 0
		end
		slicetimer = slicetimer + 1
	end
end

function OnHit(bullet)
	if bullet == fight then
		fight.SetVar("hovering",true)
	end
	if bullet == mercy then
		mercy.SetVar("hovering",true)
	end
end

function Choose(choice)
	Audio.PlaySound("menuconfirm")
	for i = 1,#options do
		options[i].Remove()
	end
	if choice == fight then
		--Audio.PlaySound("slice")
		SetGlobal("path",2)
		--slice.sprite.alpha = 1
		--slicing = true
	else
		SetGlobal("pathstate",1)
	end
	EndWave()
end