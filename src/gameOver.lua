local screen = require("screen")
local gameState = require("gameState")
local score = require("score")

local class = {}
local images = {}
local gameOver = {}
local hud = {}
local coin = {}

local function loadImages()
  images.gameOver = love.graphics.newImage("Assets/Images/GameOver.png")
  images.hud = love.graphics.newImage("Assets/Images/HUD.png")
  images.coin = love.graphics.newImage("Assets/Images/Coin.png")
end

local function loadGameOver()
  gameOver.image = images.gameOver
  gameOver.w = gameOver.image:getWidth()
  gameOver.h = gameOver.image:getHeight()
  gameOver.x = screen.getWidth()/2
  gameOver.y = screen.getHeight()/3
end

local function loadHUD()
  hud.image = images.hud
  hud.w = hud.image:getWidth()
  hud.h = hud.image:getHeight()
  hud.x = screen.getWidth()/2
  hud.y = 435
end

local function loadCoin()
  coin.image = images.coin
  coin.w = coin.image:getWidth()
  coin.h = coin.image:getHeight()
  coin.x = 117
  coin.y = 446
end

function class.load()
  loadImages()
  loadGameOver()
  loadHUD()
  loadCoin()
end

function class.draw()
  if (gameState.getState() == "gameOver") then
    love.graphics.draw(gameOver.image, gameOver.x, gameOver.y, 0, 1, 1, gameOver.w/2, gameOver.h/2)
    love.graphics.draw(hud.image, hud.x, hud.y, 0, 1, 1, hud.w/2, hud.h/2)
    if (score.getScore() > 9) then
      love.graphics.draw(coin.image, coin.x, coin.y, 0, 1, 1, coin.w/2, coin.h/2)
    end
  end
end

function class.keypressed()
  if (gameState.getState() == "gameOver") then
    gameState.setState("menu")
  end
end

return class