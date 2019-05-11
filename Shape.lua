Shape = class(
    function(self, x, y, width, height)
        self.x = x
        self.y = y
        self.oldX = x
        self.oldY = y
        self.width = width
        self.height = height
    end
)

function Shape:isCollidingWith(x, y, width, height)
    --if only one parameter given assume it's an object
    if x and y then
        if not width then width = self.width end
        if not height then height = width end
        return (self.x + width > x and self.x < x + width
        and self.y + height > y and self.y < y + height)
    end
    return (self.x + self.width > x.x and self.x < x.x + x.width
    and self.y + self.height > x.y and self.y < x.y + x.height)
end

                                ----       MAIN USE        ----
                                ---- tiled based collision ----
function Shape:wasOverlappingX(obj2) return (self.oldX + self.width > obj2.x and self.oldX < obj2.x + obj2.width) end
function Shape:wasOverlappingY(obj2) return (self.oldY + self.height > obj2.y and self.oldY < obj2.y + obj2.height) end
function Shape:isOverlappingY(obj2) return (self.y + self.height > obj2.y and self.y < obj2.y + obj2.height) end
function Shape:isOverlappingX(obj2) return (self.x + self.width > obj2.x and self.x < obj2.x + obj2.width) end
function Shape:collidedFromTop(blockY) return (self.oldY + self.height <= blockY) end
function Shape:collidedFromBottom(blockY, blockH) return (self.oldY >= blockY + blockH) end
function Shape:collidedFromLeft(blockX) return (self.oldX + self.width <= blockX) end