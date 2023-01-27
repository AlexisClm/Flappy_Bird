local screen = require("screen")
local gameState = require("gameState")

local class = {}
local data = {}

local image = love.graphics.newImage("Assets/Images/Ground.png")

function class.getY()
  local hitbox = {}

  hitbox.y = data.y
  
  return hitbox
end

function class.getSpeed()
  return data.speed
end

local function init()
  data.image = image
  data.w = data.image:getWidth()
  data.h = data.image:getHeight()
  data.x = 0
  data.y = screen.getHeight() - data.h
  data.speed = 140
end

local function move(dt)
  data.x = data.x - data.speed * dt
end

local function wrapAround()
  if (data.x < 0) then
    data.x = data.x + screen.getWidth()
  end
end

function class.load()
  init()
end

function class.update(dt)
  if (gameState.getState() == "game") or (gameState.getState() == "menu") then
    move(dt)
    wrapAround()
  end
end

function class.draw()
  love.graphics.draw(data.image, data.x, data.y)
  love.graphics.draw(data.image, data.x - screen.getWidth(), data.y)
end

return class