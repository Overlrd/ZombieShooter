Zombie = Class{}

local ZOMBIE_IMAGE = love.graphics.newImage('sprites/zombie.png')

function Zombie:init()
	local spawnPos = self:spawn()
	self.x,	self.y = spawnPos[1], spawnPos[2]
	self.width = ZOMBIE_IMAGE:getWidth()
	self.height = ZOMBIE_IMAGE:getHeight()
	self.speed = 80
	self.radius = 20
	self.dead = false
end

function Zombie:update(dt, player_x, player_y)
	local direction = math.atan2(player_y - self.y, player_x - self.x)

	local maxRandomAngle = math.pi / 6  -- Adjust this value as needed
	local randomAngle = (math.random() - 0.5) * 2 * maxRandomAngle
	-- direction = direction + randomAngle

	self.x = self.x + math.cos(direction) * self.speed * dt
	self.y = self.y + math.sin(direction) * self.speed * dt
end

function Zombie:spawn()
	local side = math.random(1, 4)
	local spawnX, spawnY

	if side == 1 then
		spawnX = -30
		spawnY = math.random(0, love.graphics.getHeight())
	elseif side == 2 then
		spawnX = love.graphics.getWidth() + 30
		spawnY = math.random(0, love.graphics.getHeight())
	elseif side == 3 then
		spawnX = math.random(0, love.graphics.getWidth())
		spawnY = -30
	elseif side == 4 then
		spawnX = math.random(0, love.graphics.getWidth())
		spawnY = love.graphics.getHeight() + 30
	end
	return {spawnX, spawnY}
end

function Zombie:render()
	love.graphics.draw(ZOMBIE_IMAGE, self.x, self.y)
end
