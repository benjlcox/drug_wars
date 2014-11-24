class NewUI

  def initialize(player)
    @player = player
  end

  def start
    @current_screen = TravelScreen.new(@player)

    loop do
      @current_screen.paint
      user_input = gets.chomp
      break if user_input == "quit"
      handle_user_input(user_input)
    end

  end

  private

  def handle_user_input(user_input)
    if @current_screen.allow_global_actions?
      success = handle_global_action(user_input)
    end

    return if success

    if @current_screen.respond_to?(:submenu)
      @current_screen.submenu(user_input)
    else
      print "Invalid input. Try again."
      sleep 1.5
    end
  end

  def handle_global_action(input)
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
