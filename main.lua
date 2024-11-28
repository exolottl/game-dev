_G.love = require("love")
--[[
-- learning lua for fun
--]]

function love.load()
  love.graphics.setBackgroundColor(0.5, 0.4, 0.6)
  _G.pacman = {}
  pacman.x = 100
  pacman.y = 200
  pacman.x_angle = 5
  pacman.y_angle = 1
  pacman.eat = false

  _G.food = {}
  food.x = 400
  food.eaten = false
end

function love.update(dt)
  if love.keyboard.isDown("down") and love.keyboard.isDown("d") then
    pacman.y_angle = pacman.y_angle - (math.pi * dt)
    pacman.x_angle = pacman.x_angle - (math.pi * dt)
    pacman.x = pacman.x + 10
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("a") then
    pacman.y_angle = pacman.y_angle - (math.pi * dt)
    pacman.x_angle = pacman.x_angle - (math.pi * dt)
    pacman.x = pacman.x - 10
  end

  if love.keyboard.isDown("a") then
    pacman.x = pacman.x - 1
  end
  if love.keyboard.isDown("s") then
    pacman.y = pacman.y + 1
  end
  if love.keyboard.isDown("d") then
    pacman.x = pacman.x + 1
  end
  if love.keyboard.isDown("w") then
    pacman.y = pacman.y - 1
  end

  if pacman.x >= food.x - 20 then
    food.eaten = true
  end
end

function love.draw()
  if not food.eaten then
    love.graphics.setColor(0.7, 0.8, 0.2)
    love.graphics.rectangle("fill", food.x, 200, 50, 50)
  end

  love.graphics.setColor(0.3, 0.2, 0.2)
  love.graphics.arc("fill", pacman.x, pacman.y, 50, pacman.y_angle, pacman.x_angle)
end
