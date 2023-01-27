local gameState = require("gameState")
local player = require("player")
local pipe = require("pipe")
local ground = require("ground")
local score = require("score")
local sound = require("sound")

local class = {}

local function colRect(a, b)
  return (a.x + a.w/2 > b.x) and (a.x - a.w/2 < b.x + b.w) and (a.y - a.h/2 < b.y + b.h) and (a.y + a.h/2 > b.y)
end

local function colY(a, b)
  return (a.y + a.h - 6 > b.y)
end

local function colX(a, b)
  return (a.x + a.w/2 > b.x + b.w/2)
end

local function checkColPlayerPipes()
  local playerHitbox = player.getHitbox()
  local pipeHitboxes = pipe.getHitboxes()

  for pipeId, pipe in ipairs(pipeHitboxes) do
    if (colRect(playerHitbox, pipe)) then
      sound.getHit()
      gameState.setState("playerDeath")
    end
  end
end

local function checkColPlayerGround()
  local playerHitbox = player.getHitbox()
  local groundY = ground.getY()

  if (colY(playerHitbox, groundY)) then
    sound.getHit()
    gameState.setState("gameOver")
  end
end

local function checkColPlayerPipesScore()
  local playerHitbox = player.getHitbox()
  local pipeHitboxes = pipe.getHitboxes()

  for pipeId, pip in ipairs(pipeHitboxes) do
    if (colX(playerHitbox, pip)) then
      if (pipe.getFlag() [pipeId]) then
        pipe.setFlag(pipeId)
        sound.getScore()
        if (pipeId % 2 == 0) then
          score.setScore(score.getScore() + 1)
        end
      end
    end
  end
end

function class.update()
  if (gameState.getState() == "game") or (gameState.getState() == "playerDeath") then
    checkColPlayerPipes()
    checkColPlayerGround()
    checkColPlayerPipesScore()
  end
end

return class