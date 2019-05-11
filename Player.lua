Player = class(
    Shape,
    function(self)
        self.init(Shape, self)
        self.x = 100
        self.y = 100
        self.xv = 400
        self.yv = 400
        self.imgRight = love.graphics.newImage("playerRight.png")
        self.imgLeft = love.graphics.newImage("playerLeft.png")
        self.imgUp = love.graphics.newImage("playerUp.png")
        self.currentImage = self.imgLeft
    end
)

function Player:draw()
    love.graphics.draw(self.currentImage, self.x, self.y)
end

function Player:update(dt)
    if love.keyboard.isDown("s") and self.y + self.currentImage:getHeight() < WH then
        self.y = self.y + self.yv * dt
        self.currentImage = self.imgRight
    end
    if love.keyboard.isDown("a") and self.x > 0 then
        self.x = self.x - self.xv * dt
        self.currentImage = self.imgLeft
    end
    if love.keyboard.isDown("d") and self.x + self.currentImage:getWidth() < WW then
        self.x = self.x + self.xv * dt
        self.currentImage = self.imgRight
    end
    if love.keyboard.isDown("w") and self.y > 0 then
        self.y = self.y - self.yv * dt
        self.currentImage = self.imgUp
    end
end