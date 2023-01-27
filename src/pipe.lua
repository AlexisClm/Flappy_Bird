local gameState = require("gameState")
local screen = require("screen")
local ground = require("ground")

local class = {}
local images = {}
local data = {}

local timer = 0
local timerMax = 1.8

function class.getHitboxes()
  local hitboxes = {}
  for pipeId, pipe in ipairs(data) do
    local hitbox = {}
    hitbox.x = pipe.x
    hitbox.y = pipe.y
    hitbox.w = pipe.w
    hitbox.h = pipe.h
    table.insert(hitboxes, hitbox)
  end
  return hitboxes
end

function class.getFlag()
  local flag = {}
  for pipeId, pipe in ipairs(data) do
    table.insert(flag, pipe.flag)
  end
  return flag
end

function class.setFlag(Id)
  data[Id].flag = false
end

local function loadImages()
  images.top = love.graphics.newImage("Assets/Images/EnemyTop.png")
  images.bot = love.graphics.newImage("Assets/Images/EnemyBot.png")
end

local function createPipe(type)
  local pipe = {}
  pipe.type = type

  if (pipe.type == "top") then
    pipe.image = images.top
    pipe.h = pipe.image:getHeight()
    pipe.y = love.math.random(-700, -400)

  elseif (pipe.type == "bot") then
    pipe.image = images.bot
    pipe.h = pipe.image:getHeight()
    pipe.y = data[#data].y + pipe.h + 135
  end

  pipe.w = pipe.image:getWidth()
  pipe.x = screen.getWidth()
  pipe.flag = true

  table.insert(data, pipe)
end

local function spawn(dt)
  timer = timer + dt
  if (timer > timerMax) and (#data == 2) then
    createPipe("top")
    createPipe("bot")
    timer = 0
  end
end

local function move(dt)
  for pipeId, pipe in ipairs(data) do
    pipe.x = pipe.x - ground.getSpeed() * dt
  end
end

local function wrapAround()
  for pipeId, pipe in ipairs(data) do
    if (pipe.type == "top") then
      if (pipe.x + pipe.w < 0) then
        table.remove(data, pipeId)
        createPipe("top")
      end
    elseif (pipe.type == "bot") then
      if (pipe.x + pipe.w < 0) then
        table.remove(data, pipeId)
        createPipe("bot")
      end
    end
  end
end

function class.load()
  if (gameState.getState() == "menu") then
    data = {}
    loadImages()
    createPipe("top")
    createPipe("bot")
  end
end

function class.update(dt)
  if (gameState.getState() == "menu") then
    timer = 0
  elseif (gameState.getState() == "game") then
    spawn(dt)
    move(dt)
    wrapAround()
  end
end

function class.draw()
  if (gameState.getState() ~= "menu") then
    for pipeId, pipe in ipairs(data) do
      love.graphics.draw(pipe.image, pipe.x, pipe.y)
    end
  end
end

return class