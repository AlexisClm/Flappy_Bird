local screen = require("screen")
local gameState = require("gameState")
local sound = require("sound")

local class = {}
local images = {}
local data = {}

function class.getHitbox()
  local hitbox = {}

  hitbox.x = data.x
  hitbox.y = data.y 
  hitbox.h = data.h
  hitbox.w = data.w 

  return hitbox
end

local function loadImages()
  images.data1 = love.graphics.newImage("Assets/Images/Player1.png")
  images.data2 = love.graphics.newImage("Assets/Images/Player2.png")
  images.data3 = love.graphics.newImage("Assets/Images/Player3.png")
end

local function init()
  data.image = images.data1
  data.w = data.image:getWidth()
  data.h = data.image:getHeight()
  data.x = screen.getWidth()/4
  data.y = screen.getHeight()/2
  data.speed = 200
  data.jump = -325
  data.gravity = 700
  data.timer = 0
  data.timerMax = 0.12
  data.flag = true
end

local function gravity(dt)
  data.speed = data.speed + data.gravity * dt
  data.y = data.y + data.speed * dt
end

local function deathAnimation(dt)
  data.speed = data.speed + data.gravity * dt
  data.y = data.y + data.speed * dt
end

local function animation(dt)
  data.timer = data.timer + dt
  if (data.timer > data.timerMax) and (data.image == images.data1) then
    data.image = images.data2
    data.timer = 0
  elseif (data.timer > data.timerMax) and (data.image == images.data2) then
    data.image = images.data3
    data.timer = 0
  elseif (data.timer > data.timerMax) and (data.image == images.data3) then
    data.image = images.data1
    data.timer = 0
    if (gameState.getState() ~= "menu") then
      data.flag = false
    end
  end
end

function class.load()
  if (gameState.getState() == "menu") or (gameState.getState() == "gameOver") then
    loadImages()
    init()
  end
end

function class.update(dt)
  if (gameState.getState() == "game") or (gameState.getState() == "playerDeath") then
    gravity(dt)
  end
  if (data.flag) then
    animation(dt)
  end
end

function class.draw()
  if (gameState.getState() == "game") then
    if (math.rad(data.speed * 0.15) < math.rad(90)) then
      love.graphics.draw(data.image, data.x, data.y, math.rad(data.speed * 0.15), 1, 1, data.w/2, data.h/2)
    else
      love.graphics.draw(data.image, data.x, data.y, math.rad(90), 1, 1, data.w/2, data.h/2)
    end
  elseif (gameState.getState() == "playerDeath")  or (gameState.getState() == "gameOver") then
    if (math.rad(data.speed * 0.5) < math.rad(90)) then
      love.graphics.draw(data.image, data.x, data.y, math.rad(data.speed * 0.5), 1, 1, data.w/2, data.h/2)
    else
      love.graphics.draw(data.image, data.x, data.y, math.rad(90), 1, 1, data.w/2, data.h/2)
    end
  elseif (gameState.getState() == "menu") then
    love.graphics.draw(data.image, data.x, data.y, 0, 1, 1, data.w/2, data.h/2)
  end
end

function class.keypressed(key)
  if (gameState.getState() == "game") or (gameState.getState() == "menu") then
    gameState.setState("game")
    if (data.y > 75) then
      sound.getJump()
      data.speed = data.jump
      data.flag = true
    end
  elseif (gameState.getState() == "gameOver") then  
    class.load()
  end
end

return class