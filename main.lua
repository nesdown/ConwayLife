function love.load()
    love.graphics.setBackgroundColor(255, 255, 255)

    cellSize = 12

    gridXCount = 70
    gridYCount = 50

    grid = {}
    for y = 1, gridYCount do
        grid[y] = {}
        for x = 1, gridXCount do
            grid[y][x] = false
        end
    end

    love.keyboard.setKeyRepeat(true)
end

function love.update()
    selectedX = math.floor(love.mouse.getX() / cellSize) + 1
    selectedY = math.floor(love.mouse.getY() / cellSize) + 1

    if love.mouse.isDown(1)
    and selectedX <= gridXCount
    and selectedY <= gridYCount then
        grid[selectedY][selectedX] = true
    elseif love.mouse.isDown(2) then
        grid[selectedY][selectedX] = false
    end
end

function love.draw()
    for y = 1, 50 do
        for x = 1, 70 do
            local cellDrawSize = cellSize - 1

            if x == selectedX and y == selectedY then
                love.graphics.setColor(24, 240, 12)
            elseif grid[y][x] then
                love.graphics.setColor(24, 240, 12)
            else
                love.graphics.setColor(230, 230, 230)
            end

            love.graphics.rectangle(
                'fill',
                (x - 1) * cellSize,
                (y - 1) * cellSize,
                cellDrawSize,
                cellDrawSize
            )
        end
    end
end

function love.keypressed()
    local nextGrid = {}
    for y = 1, gridYCount do
        nextGrid[y] = {}
        for x = 1, gridXCount do
            local neighbors = 0

            for dy = -1, 1 do
                for dx = -1, 1 do
                    if not (dy == 0 and dx == 0)
                    and grid[y + dy]
                    and grid[y + dy][x + dx] then
                        neighbors = neighbors + 1
                    end
                end
            end

            nextGrid[y][x] = neighbors == 3 or (grid[y][x] and neighbors == 2)
        end
    end

    grid = nextGrid
end
