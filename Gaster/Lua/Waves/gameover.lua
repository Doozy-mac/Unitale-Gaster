timer = 0
SetGlobal("usingpowers",true)
SetGlobal("handsgone",true)
Audio.PlaySound("stinger")
whiteout = CreateProjectileAbs("whiteout",320,240)
whiteout.sprite.alpha = 0
crash = CreateProjectileAbs("errorcorrupt6",320,240)
spinner = CreateProjectileAbs("gaster/mysteryman",580,60)
crash.sprite.alpha = 0
spinner.sprite.alpha = 0


function Update()
	if whiteout.sprite.alpha < 1 then
		local alpha = whiteout.sprite.alpha
		whiteout.sprite.alpha = alpha + 0.05
	else
		spinner.sprite.rotation = spinner.sprite.rotation + 1
	end
	if timer == 120 then
		Audio.PlaySound("bsod")
		crash.sprite.alpha = 1
		spinner.sprite.alpha = 1
		crash.SendToTop()
		spinner.SendToTop()
	end
	timer = timer + 1
end

function OnHit(bullet)

end