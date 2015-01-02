class UI

  def initialize(player)
    @player = player
  end

  def start
    @current_screen = BuyScreen.new(@player)
    loop do
      if game_is_over?
        GameoverScreen.new(@player).paint
        wait = gets.chomp
        break
      else
        @current_screen.paint
        user_input = get_input
        break if user_input == "quit"
        handle_user_input(user_input)
      end
    end
  end

  private

  def get_input
    if @player.is_ai?
      @player.ai_perform(@current_screen)
    else
      gets.chomp
    end
  end

  def game_is_over?
    @player.game_over? ? true : false
  end

  def handle_user_input(user_input)
    if @current_screen.allow_global_actions?
      success = global_screen_router(user_input)
    end

    return if success

    if @current_screen.respond_to?(:submenu)
      subscreen = @current_screen.submenu(user_input)
    else
      print "Invalid input. Try again."
      sleep 1.5
    end
    @current_screen = subscreen if subscreen.is_a?(Screen)
  end

  def global_screen_router(input)
    case input
    when "1"
      @current_screen = MarketplaceScreen.new(@player)
    when "2"
      @current_screen = InventoryScreen.new(@player)
    when "3"
      @current_screen = TravelScreen.new(@player)
    when "4"
      # loan_screen
    when "5"
      # fence_screen
    else
      return false
    end
    return true
  end
end
