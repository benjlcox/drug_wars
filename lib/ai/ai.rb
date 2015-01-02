class AI

  def initialize(player)
    @player = player
  end

  def perform(screen)
    @current_screen = screen
    if @current_screen.ai_interface[:menu] != nil && @current_screen.name != "Transaction"
      if (1..2).to_a.sample == 1
        return_value = submenu_rando
        puts "Submenu -> #{return_value}"
      else
        return_value = global_rando.to_s
        puts "Global -> #{return_value}"
      end
    elsif @current_screen.name == "Transaction"
      return_value = @current_screen.ai_interface[:content]["max"]
      puts "Max -> #{return_value}"
    else
      return_value = global_rando.to_s
      puts "Global -> #{return_value}"
    end
    sleep 0.25
    return return_value
  end

  private

  def global_rando
    (1..3).to_a.sample
  end

  def submenu_rando
    @current_screen.ai_interface[:menu].values.sample
  end
end
