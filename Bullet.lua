Bullet = Class {}

function Bullet:init(x, y)
	self.image = love.graphics.newImage('sprites/bullet.png')
	self.x = x
	self.y = y
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.speed = 500
	self.direction = math.atan2(love.mouse.getY()-y, love.mouse.getX()-x)
	self.dead = false
end

function Bullet:update(dt)
	self.x = self.x + (math.cos( self.direction ) * self.speed * dt)
	self.y = self.y + (math.sin( self.direction ) * self.speed * dt)
end

function Bullet:render()
	love.graphics.draw(self.image, self.x, self.y, nil, 0.5, nil, self.width / 2, self.height / 2)
end


