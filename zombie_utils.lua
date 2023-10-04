function checkCollision(zombie1, zombie2)
    local dx = zombie1.x - zombie2.x
    local dy = zombie1.y - zombie2.y
    local distance = math.sqrt(dx * dx + dy * dy)
    local minDistance = zombie1.radius + zombie2.radius

    if distance < minDistance then
        return true
    end

    return false
end

function moveZombies(zombies)
    for i, zombie1 in ipairs(zombies) do
        for j, zombie2 in ipairs(zombies) do
            if i ~= j and checkCollision(zombie1, zombie2) then
                -- Handle collision avoidance here
                -- For example, move zombie1 away from zombie2
                local dx = zombie1.x - zombie2.x
                local dy = zombie1.y - zombie2.y
                local distance = math.sqrt(dx * dx + dy * dy)
                local minDistance = zombie1.radius + zombie2.radius
                local moveX = (dx / distance) * (minDistance - distance) / 2
                local moveY = (dy / distance) * (minDistance - distance) / 2

                zombie1.x = zombie1.x + moveX
                zombie1.y = zombie1.y + moveY
            end
        end
    end
end

return {
	checkCollision = checkCollision,
	moveZombies = moveZombies
}
