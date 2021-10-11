require "gasterblasters"
StartBlasters()
spawntimer = 0
bullets_horiz = {}
bullets_vert = {}
beams_horiz = {}
beams_vert = {}
i = 0
j = 0
k = 0
isleft = false
count = 0
Arena.resize(140,140)
grid = {}
grid1 = {-Arena.width/2,0,Arena.width/2}
grid2 = {-Arena.width/4,Arena.width/4}
gridstatus = 1

function Update()
maxtime = 70
if spawntimer%maxtime == 0 then
	Audio.PlaySound("blaster")
	if gridstatus == 1 then
		grid = grid1
	else
		grid = grid2
	end
	for k=1,#grid do
		CreateBlaster(-Arena.width*0.85,grid[k],0,1,1,false)
	
		CreateBlaster(grid[k],Arena.width*0.85,1,1,1,false)
	end
		Audio.PlaySound("blaster")
		gridstatus = gridstatus*-1
	end
	HandleBlasters()
	spawntimer = spawntimer + 1
end