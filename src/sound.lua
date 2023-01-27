local gameState = require("gameState")

local class = {}
local data = {}

function class.getJump()
  data.jumpClone = data.jump:clone()
  return data.jumpClone:play()
end

function class.getScore()
  return data.score:play()
end

function class.getHit()
  return data.hit:play()
end

local function initJump() 
  data.jump = love.audio.newSource("Assets/Sounds/Jump.wav", "static")
  data.jump:setVolume(1)
end

local function initScore() 
  data.score = love.audio.newSource("Assets/Sounds/Score.wav", "static")
  data.score:setVolume(0.4)
end

local function initHit() 
  data.hit = love.audio.newSource("Assets/Sounds/Hit.wav", "static")
  data.hit:setVolume(0.3)
end

function class.load()
  initJump()
  initScore()
  initHit() 
end

return class