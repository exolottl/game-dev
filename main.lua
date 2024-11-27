_G.love = require("love")
--[[
-- learning lua for fun
--]]

function love.load()
  love.graphics.setBackgroundColor(0.5, 0.4, 0.6)
  _G.pacman = {}
  pacman.x = 100
  pacman.y = 200
  pacman.eat = false

  _G.food = {}
  food.x = 400
end

function love.update(dt)
  pacman.x = pacman.x + 1

  if pacman.x >= food.x-20 then
    pacman.eat = true
  end
end

function love.draw()
  if not pacman.eat then
    love.graphics.setColor(0.7, 0.8, 0.2)
    love.graphics.rectangle("fill", food.x, 200, 50, 50)
  end

  love.graphics.setColor(0.3, 0.2, 0.2)
  love.graphics.arc("fill", pacman.x, pacman.y, 50, 1, 6)
end
