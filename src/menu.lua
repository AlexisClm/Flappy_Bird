local screen = require("screen")
local gameState = require("gameState")

local class = {}
local images = {}
local getReady = {}
local tap = {}

local function loadImages()
  images.getReady = love.graphics.newImage("Assets/Images/GetReady.png")
  images.tap = love.graphics.newImage("Assets/Images/Tap.png")
end

local function loadGetReady()
  getReady.image = images.getReady
  getReady.w = getReady.image:getWidth()
  getReady.h = getReady.image:getHeight()
  getReady.x = screen.getWidth()/2
  getReady.y = screen.getHeight()/3
end

local function loadTap()
  tap.image = images.tap
  tap.w = tap.image:getWidth()
  tap.h = tap.image:getHeight()
  tap.x = screen.getWidth()*2/3
  tap.y = screen.getHeight()/2
end

function class.load()
  gameState.setState("menu")
  loadImages()
  loadGetReady()
  loadTap()
end

function class.draw()
  if (gameState.getState() == "menu") then
    love.graphics.draw(getReady.image, getReady.x, getReady.y, 0, 1, 1, getReady.w/2, getReady.h/2)
    love.graphics.draw(tap.image, tap.x, tap.y, 0, 1, 1, tap.w/2, tap.h/2)
  end
end

return class