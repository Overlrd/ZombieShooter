love = require("love")

-- seed random with os.time for true random values
math.randomseed(os.time())

-- classic OOP class library
Class = require 'class'

-- player class 
require 'Player'

-- zombie class
require 'Zombie'

-- bullet class
require 'Bullet'

-- all code related to the game state and the state machine
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'

-- images we load from files to later draw onto the screen
local background_img = love.graphics.newImage('sprites/background.png')

-- a bunch of functions to move zombies as a group
local zombie_utils = require('zombie_utils')

-- mooves tables
PLAYER_MOOVES = {["up"] = "z", ["down"] = "s", ["right"] = "d", ["left"] = "q"}

function love.load()
	-- initilaize the nearest-neighbor filter [TODO]--learn more about it 
	love.graphics.setDefaultFilter('nearest', 'nearest')

	-- app window title
	love.window.setTitle('ZombieShooter')

	-- load fonts
	smallFont = love.graphics.newFont('font.ttf', 18)
	mediumFont = love.graphics.newFont('font2.ttf', 38)
	love.graphics.setFont(smallFont)

	sounds = {
		["hurt"] = love.audio.newSource('sounds/hurt.wav', 'static'),
		["shoot"] = love.audio.newSource('sounds/shoot.wav', 'static'),
		["lost"] = love.audio.newSource('sounds/lost.wav', 'static'),
		["music"] = love.audio.newSource('sounds/music.wav', 'stream')
	}

	-- instanciate state machine with all state-returning functions
	gStateMachine = StateMachine {
		['title'] = function() return TitleScreenState() end,
		['play'] = function() return PlayState() end,
		['score'] = function() return ScoreState() end
	}
	gStateMachine:change('title')
	love.keyboard.KeysPressed = {}
	-- start playing music
	sounds["music"]:setLooping(true)
	sounds["music"]:setVolume(0.2)
	sounds["music"]:play()
end

function love.keypressed(key)
	love.keyboard.KeysPressed[key] = true
	if key == 'escape' then
		love.event.quit()
	end
end

--- Listen to mouse for shoot 
function love.mousepressed(x, y, button)
	if button == 1 then
		love.keyboard.KeysPressed["shoot"] = true
	end
end


function love.keyboard.wasPressed(key)
    if love.keyboard.KeysPressed[key] then
        return true
    else
        return false
    end
end


function love.update(dt)
	gStateMachine:update(dt)
	love.keyboard.KeysPressed = {}
end

function love.draw()

	love.graphics.draw(background_img, 0, 0, 0, love.graphics.getWidth() / background_img:getWidth(), love.graphics.getHeight() / background_img:getHeight())
	gStateMachine:render()
end

function distanceBetween(x1, y1, x2, y2)
	return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end
