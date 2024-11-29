_G.love = require("love")
Enemy = require("Enemy")
Button = require("Button")

math.randomseed(os.time())

Game = {
  difficulty = 1,
  state = {
    menu = true,
    running = false,
    ended = false,
    paused = false,
  },
  points = 0,
  levels = { 15, 30, 60, 120 },
}

Player = {
  x = 0,
  y = 0,
  radius = 30,
}

local buttons = {
  menu_state = {},
  ended_state = {},
}

Enemies = {}

function ChangeGameState(state)
  Game.state["menu"] = state == "menu"
  Game.state["paused"] = state == "paused"
  Game.state["running"] = state == "running"
  Game.state["ended"] = state == "ended"
end

function StartGame()
  ChangeGameState("running")
  Enemies = {
    Enemy(1),
  }
end

function love.mousepressed(x, y, button, istouch, presses)
  if not Game.state["running"] then
    if button == 1 then
      if Game.state["menu"] then
        for index in pairs(buttons.menu_state) do
          buttons.menu_state[index]:checkPressed(x, y, Player.radius)
        end
      end

      if Game.state["ended"] then
        for index in pairs(buttons.ended_state) do
          buttons.ended_state[index]:checkPressed(x, y, Player.radius)
        end
      end
    end
  end
end

function love.load()
  love.mouse.setVisible(false)
end

function love.update(dt)
  Player.x, Player.y = love.mouse.getPosition()

  buttons.menu_state.play_game = Button("Play game", StartGame, nil, 120, 40)
  buttons.menu_state.exit_game = Button("Exit game", love.event.quit, nil, 120, 40)
  buttons.menu_state.settings = Button("settings", nil, nil, 120, 40)

  buttons.ended_state.play_game = Button("Retry game", StartGame, nil, 120, 40)
  buttons.ended_state.exit_game = Button("Exit game", love.event.quit, nil, 120, 40)

  if Game.state["running"] then
    for i = 1, #Enemies do
      Enemies[i]:move(Player.x, Player.y)
      for j = 1, #Game.levels do
        if math.floor(Game.points) == Game.levels[j] then
          table.insert(Enemies, 1, Enemy(Game.difficulty * (j + 1)))

          Game.points = Game.points + 1
        end
      end

      if Enemies[i]:checkTouched(Player.x, Player.y, Player.radius) then
        ChangeGameState("ended")
      end
    end
    Game.points = Game.points + dt
  end
end

function love.draw()
  if Game.state["running"] then
    love.graphics.printf(
      math.floor(Game.points),
      love.graphics.newFont(16),
      0,
      10,
      love.graphics.getWidth(),
      "center"
    )
    love.graphics.circle("fill", Player.x, Player.y, Player.radius)
    for i = 1, #Enemies do
      Enemies[i]:draw()
    end
  elseif Game.state["ended"] then
    local endGameText = "Game Over " .. "your score: " .. math.floor(Game.points)
    love.graphics.printf(endGameText, love.graphics.newFont(16), 0, 300, love.graphics.getWidth(), "center")

    buttons.ended_state.play_game:draw(10, 20, 20, 10)
    buttons.ended_state.exit_game:draw(10, 80, 20, 10)
  elseif Game.state["menu"] then
    buttons.menu_state.play_game:draw(10, 20, 20, 10)
    buttons.menu_state.exit_game:draw(10, 80, 20, 10)
    buttons.menu_state.settings:draw(10, 140, 20, 10)
  end

  if not Game.state["running"] then
    love.graphics.circle("fill", Player.x, Player.y, Player.radius / 2)
  end
end
