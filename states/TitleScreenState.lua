TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('play')
	end
end

function TitleScreenState:render()
	love.graphics.setFont(mediumFont)
	love.graphics.printf('ZombieShooter', 0, 64, love.graphics.getWidth(), 'center')
	love.graphics.printf('Press Enter', 0, 100, love.graphics.getWidth(), 'center')
end
