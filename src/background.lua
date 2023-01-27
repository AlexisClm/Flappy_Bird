local class = {}

local image

function class.load()
  image = love.graphics.newImage("Assets/Images/Background.jpg")
end

function class.draw()
  love.graphics.draw(image)
end

return class