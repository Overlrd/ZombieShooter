PlayState = Class{__includes = BaseState}

DEFAULT_VAGUE_ZOMBIES = 4
VAGUE_MOMENTUM = 1.5

local zombie_utils = require('../zombie_utils')

function PlayState:init()
	self.player = Player()
	self.zombies = {}
	self.bullets = {}
	self.vague = 0
	self.current_vague_zombies = DEFAULT_VAGUE_ZOMBIES
	self.spawned_zombies = 0
	self.killed_zombies = 0
	self.spawn_new = true
	self.spawn_timer = 0
	self.score = self.killed_zombies
	sounds["music"]:play()
end

function PlayState:update(dt)
	-- update spaw timer
	self.spawn_timer = self.spawn_timer + dt

	-- spaw new zombie each spawn_timer second
	if self.spawn_timer > 0.5 and self.spawn_new then
		table.insert(self.zombies, Zombie())
		self.spawned_zombies = self.spawned_zombies + 1
		self.spawn_timer = 0
	end

	-- if spawned all the current vague , stop spawning
	if self.spawned_zombies == self.current_vague_zombies then
		self.spawn_new = false
		-- if player killed all the vague update and restart spawning
		if self.killed_zombies == self.spawned_zombies then
			self.spawn_timer = -2
			self.killed_zombies = 0
			self.spawned_zombies = 0
			self.current_vague_zombies = self.current_vague_zombies + 3
			self.spawn_new = true
			self.vague = self.vague + 1
		end
	end

	-- update the player
	self.player:update(dt)

	-- for every zombie in the zombies list update zombie
	for _,z in pairs(self.zombies) do
		z:update(dt, self.player.x, self.player.y)
	end

	-- make sure zombies don't override each other
	zombie_utils.moveZombies(self.zombies)

	-- for every bullet in bulltes update bullet
	for _,b in pairs(self.bullets) do
		b:update(dt)
	end

	-- check if the player is shooting
	if love.keyboard.KeysPressed["shoot"] == true then
		local bullet = Bullet(self.player.x, self.player.y)
		table.insert(self.bullets, bullet)
		sounds["shoot"]:play()
	end

	-- Check for zombie and bullet collision and kill both if they collide
	
	for i,z in ipairs(self.zombies) do
		for j,b in ipairs(self.bullets) do
			if distanceBetween(z.x, z.y, b.x, b.y) < z.width then
				z.dead = true
				b.dead = true
				self.killed_zombies = self.killed_zombies + 1
				self.score = self.score + 1
				sounds["hurt"]:play()
			end
		end
	end

	-- update the bullets and zombies list remove the dead ones
	
	for i=#self.zombies, 1, -1 do
		local z = self.zombies[i]
		if z.dead == true then
			table.remove(self.zombies, i)
		end
	end

	for i=#self.bullets, 1, -1 do
		local b = self.bullets[i]
		if b.dead == true then
			table.remove(self.bullets, i)
		end
	end

	for i, z in ipairs(self.zombies) do
		local zombieCenterX = z.x + z.width / 2
		local zombieCenterY = z.y + z.height / 2
		local playerCenterX = self.player.x + self.player.width / 2
		local playerCenterY = self.player.y + self.player.height / 2

		local distance = distanceBetween(zombieCenterX, zombieCenterY, playerCenterX, playerCenterY)

		if distance < (z.width / 2 + self.player.width / 2) then
			gStateMachine:change('score', {
				score = self.score
			})
			sounds["music"]:stop()
			sounds["lost"]:play()
		end
	end

end

function PlayState:render()

	for _,z in pairs(self.zombies) do
		z:render()
	end

	for _,b in pairs(self.bullets) do
		b:render()
	end

	self.player:render()
	local text1 = "Vague " .. self.vague
	local text2 = "Killed " .. self.killed_zombies .. " zombies"

	love.graphics.setFont(smallFont)
	love.graphics.printf(text1, -10, 20, love.graphics.getWidth(), "right")
	

	love.graphics.printf(text2, -100, 20, love.graphics.getWidth(), "right")
end
