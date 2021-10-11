screenalpha = 0
timer = 0

screen = CreateProjectileAbs("whitescreen",0,0)
screen.sprite.alpha = 0
screen.sprite.xscale = 81
screen.sprite.yscale = 81
Audio.PlaySound("slice")

function Update()
	screenalpha = screen.sprite.alpha
	screen.sprite.alpha = screenalpha +0.04
	if GetGlobal("gastergo") == false then
		SetGlobal("gastergo",true)
	end
end