class GameoverScreen < Screen

  def initialize(player)
    super
    @player = player
  end

  def name
    "Game Over"
  end

  def allow_global_actions?
    false
  end

  def content
    result = []
    result << "Game Over."
    result << ""
    result << "You ended the game with $#{@player.check_money}"
    result << ""
    result << ""
    result << ""
    result << "Press enter to quit."
    result
  end

  def ai_interface
    {
      content: "game over",
      menu: nil
    }
  end
end
