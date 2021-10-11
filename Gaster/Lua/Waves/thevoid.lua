blackout = CreateSprite("blackscreen")
blackout.MoveTo(320,240)
blackout.alpha = 0
Audio.PlaySound("enemydust")

function Update()
	if blackout.alpha < 1 then
		local alpha = blackout.alpha + 0.025
		blackout.alpha = alpha
	end
end