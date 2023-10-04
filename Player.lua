require 'Bullet'
Player = Class{}

function Player:init()
	self.image = love.graphics.newImage('sprites/player.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	-- position the player in the middle of the screen
	self.x = love.graphics.getWidth() / 2 - (self.width / 2)
	self.y = love.graphics.getHeight() / 2 - (self.height / 2)

	self.speed = 180
end

function Player:update(dt)
	self:handleInput(dt)
	self:notOutTheScreen()
end

function Player:render()
	local direction = math.atan2(love.mouse.getY() - self.y ,love.mouse.getX() - self.x )

	love.graphics.draw(self.image, self.x, self.y, direction, nil, nil, self.width/2, self.height/2)
end

function Player:handleInput(dt)
	if love.keyboard.isDown('d') then
		self.x = self.x + self.speed * dt
	end
	if love.keyboard.isDown('q') then
		self.x = self.x - self.speed * dt
	end
	if love.keyboard.isDown('z') then
		self.y = self.y - self.speed * dt
	end
	if love.keyboard.isDown('s') then
		self.y = self.y + self.speed * dt
	end
end

function Player:notOutTheScreen()
	if self.x + self.width >= love.graphics.getWidth() then
		self.x = love.graphics.getWidth() - self.width
	elseif self.x - self.width <= 0 then
		self.x = self.width
	end

	if self.y + self.height >= love.graphics.getHeight() then
		self.y = love.graphics.getHeight() - self.height
	elseif self.y - self.height <= 0 then
		self.y = self.height
	end
end
