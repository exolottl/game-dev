_G.love = require("love")
--[[
-- learning lua for fun
--]]

function love.load()
  Gandalf = {
    x = 10,
    y = 10,
    sprite = love.graphics.newImage("/spirtesheet/spritesheet.png"),
    animation = {
      direction = "right",
      idle = true,
      frame = 4,
      max_frames = 6,
      speed = 50,
      timer = 0.1,
    },
  }

  Width, Height = 3000, 2000

  QuadWidth, QuadHeight = 1000, 1000
  Quads = {}

  for row = 0, 1 do
    for col = 0, 2 do
      local index = row * 3 + col + 1
      Quads[index] =
          love.graphics.newQuad(QuadWidth * col, QuadHeight * row, QuadWidth, QuadHeight, Width, Height)
    end
  end
end

function love.update(dt)
  if love.keyboard.isDown("d") then
    Gandalf.animation.idle = false
    Gandalf.animation.direction = "right"
  elseif love.keyboard.isDown("a") then
    Gandalf.animation.idle = false
    Gandalf.animation.direction = "left"
  else
    Gandalf.animation.idle = true
    Gandalf.animation.frame = 4
  end

  if not Gandalf.animation.idle then
    Gandalf.animation.timer = Gandalf.animation.timer + dt

    if Gandalf.animation.timer > 0.2 then
      Gandalf.animation.timer = 0.1

      Gandalf.animation.frame = Gandalf.animation.frame + 1

      if Gandalf.animation.direction == "right" then
        Gandalf.x = Gandalf.x + Gandalf.animation.speed
      elseif Gandalf.animation.direction == "left" then
        Gandalf.x = Gandalf.x - Gandalf.animation.speed
      end
      if Gandalf.animation.frame > Gandalf.animation.max_frames then
        Gandalf.animation.frame = 1
      end
    end
  end
end

function love.draw()
  love.graphics.scale(0.1)

  if Gandalf.animation.direction == "right" then
    love.graphics.draw(Gandalf.sprite, Quads[Gandalf.animation.frame], Gandalf.x, Gandalf.y)
  else
    love.graphics.draw(Gandalf.sprite, Quads[Gandalf.animation.frame], Gandalf.x, Gandalf.y, 0 , -1, 1, QuadWidth, 0)
  end
end
