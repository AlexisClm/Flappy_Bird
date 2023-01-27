local gameState = require("gameState")
local screen = require("screen")
local background = require("background")
local ground = require("ground")
local player = require("player")
local pipe = require("pipe")
local collision = require("collision")
local score = require("score")
local menu = require("menu")
local gameOver = require("gameOver")
local sound = require("sound")

function love.load()
  screen.load()
  menu.load()
  background.load()
  player.load()
  score.load()
  ground.load()
  sound.load()
  gameOver.load()
end

function love.update(dt)
  ground.update(dt)
  pipe.update(dt)
  player.update(dt)
  collision.update()
  score.update()
end

function love.draw()
  background.draw()
  pipe.draw()
  ground.draw()
  player.draw()
  menu.draw()
  gameOver.draw()
  score.draw()
end

function love.keypressed(key)
  pipe.load()
  player.keypressed(key)
  gameOver.keypressed(key)
  if (key == "escape") then
    love.event.quit()
  end
end

