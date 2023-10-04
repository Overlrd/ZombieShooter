ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('play')
	end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
	love.graphics.setFont(mediumFont)
    love.graphics.printf('Oof! You lost!', 0, 64, love.graphics.getWidth(), 'center')

    love.graphics.setFont(smallFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 140, love.graphics.getWidth(), 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 180, love.graphics.getWidth(), 'center')
end
