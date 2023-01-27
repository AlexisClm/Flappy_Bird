local screen = require("screen")
local gameState = require("gameState")

local class = {}
local images = {}
local score = {}
local bestScore = {}
local hud = {}

local image = love.graphics.newImage("Assets/Images/HUD.png")

function class.getScore()
  return score.nb
end

function class.setScore(value)
  score.nb = value
end

local function loadScore()
  score.font = love.graphics.newFont("Assets/Font/Flappy Bird.ttf", 40)
  score.nb = 0
  score.x1 = 0
  score.y1 = 50
  score.x2 = 120
  score.y2 = 395
end

local function loadBestScore()
  bestScore.font = love.graphics.newFont("Assets/Font/Flappy Bird.ttf", 40)
  bestScore.nb = 0
  bestScore.x = 120
  bestScore.y = 460
end

local function updateBestScore()
  if (score.nb > bestScore.nb) then
    bestScore.nb = score.nb
  end
end

function class.load()
  loadBestScore()
end

function class.update()
  if (gameState.getState() == "menu") then
    loadScore()
  end
  updateBestScore()
end

function class.draw()
  love.graphics.setFont(score.font)
  if (gameState.getState() == "game") or (gameState.getState() == "menu") or (gameState.getState() == "playerDeath") then
    love.graphics.printf(score.nb, score.x1, score.y1, screen.getWidth(), "center")
  elseif (gameState.getState() == "gameOver") then
    love.graphics.printf(score.nb, score.x2, score.y2, screen.getWidth(), "center")
    love.graphics.printf(bestScore.nb, bestScore.x, bestScore.y, screen.getWidth(), "center")
  end
end

return class