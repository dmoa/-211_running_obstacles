require("Class")
require("Shape")
require("Player")


function love.load()
    love.mouse.setVisible(false)
    WW, WH = love.graphics.getDimensions()
    obstacleImg = love.graphics.newImage("obstacle.png")
    obstaclesX = {}
    obstaclesY = {}
    obstaclesXV = {}
    for i = 1, 5 do 
        table.insert(obstaclesX, math.floor(love.math.random(WW - obstacleImg:getWidth()) / obstacleImg:getWidth()) * obstacleImg:getWidth() * -1)
        table.insert(obstaclesY, math.floor(love.math.random(WH - obstacleImg:getHeight()) / obstacleImg:getHeight()) * obstacleImg:getHeight())
        table.insert(obstaclesXV, love.math.random(200) + 100)
    end
    player = Player()

    playing = false
    loadingScreen = love.graphics.newImage("loadingScreen.png")

    score = 0
    highscore = 0
    font = love.graphics.newFont(30)
    scoreText = love.graphics.newText(font, "score: "..score)
    highscoreText = love.graphics.newText(font, "highscore: "..highscore)

    bgImg = love.graphics.newImage("bg.png")
    bg1x = 0
    bg2x = bgImg:getWidth()
end

function love.draw()
    if playing then
        love.graphics.draw(bgImg, bg1x, 0)
        love.graphics.draw(bgImg, bg2x, 0)
        drawObstacles()
        player:draw()
        love.graphics.draw(highscoreText)
        love.graphics.draw(scoreText, 0, 35)
    else
        love.graphics.draw(loadingScreen, 0, 0)
    end
end

function drawObstacles()
    for index, value in ipairs(obstaclesX) do
        love.graphics.draw(obstacleImg, value, obstaclesY[index])
    end
end

--yes, an update functions returning true, I know
function updateObstacles(dt)
    for index, x in ipairs(obstaclesX) do
        if player:isCollidingWith(x, obstaclesY[index], obstacleImg:getDimensions()) then 
            playing = false 
            if score > highscore then highscore = score end
            return true
        end
        obstaclesX[index] = obstaclesX[index] + obstaclesXV[index] * dt
        if x > WW then
            obstaclesX[index] = math.floor(love.math.random(WW - obstacleImg:getWidth()) / obstacleImg:getWidth()) * obstacleImg:getWidth() * -1
            obstaclesXV[index] = love.math.random(200) + 100
        end
    end
end

function love.update(dt)
    if playing then
        player:update(dt)
        updateObstacles(dt)
        score = score + dt
        scoreText = love.graphics.newText(font, "highscore: "..math.floor(score))
        highscoreText = love.graphics.newText(font, "score: "..math.floor(highscore))
        bg1x = bg1x - 500 * dt
        bg2x = bg2x - 500 * dt
        if bg1x + bgImg:getWidth() < 0 then bg1x = bgImg:getWidth() end
        if bg2x + bgImg:getWidth() < 0 then bg2x = bgImg:getWidth() end
    end
    if love.keyboard.isDown("space") and not playing then
        start(dt)
    end
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
end

function start(dt)
    obstaclesX = {}
    obstaclesY = {}
    for i = 1, 5 do 
        table.insert(obstaclesX, math.floor(love.math.random(WW - obstacleImg:getWidth()) / obstacleImg:getWidth()) * obstacleImg:getWidth() * -1)
        table.insert(obstaclesY, math.floor(love.math.random(WH - obstacleImg:getHeight()) / obstacleImg:getHeight()) * obstacleImg:getHeight())
    end
    player = Player()
    playing = true
    if updateObstacles(dt) then start(dt) end
end