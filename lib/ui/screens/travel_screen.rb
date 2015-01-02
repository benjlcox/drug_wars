class TravelScreen < Screen
  def initialize(player)
    super
    @player = player
  end

  def name
    "Travel"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "Where do you want to travel to?"
    result << ""
    i = 9
    result = result + @player.world.list.keys.map { |city| i += 1; str = "#{i.to_s(36)}) #{city}"; str << " <<<" if @player.city == city; str }
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    city = handle_action(input, @player.world.list)
    unless city.nil? || city == @player.city || city == false
      @player.travel(city)
    end
    paint
  end

  def ai_interface
    i = 9
    menu_options = {}
    @player.world.list.keys.map { |city| i += 1; menu_options["#{city}"] = "#{i.to_s(36)}" }
    {
      content: menu_options,
      menu: menu_options
    }
  end
end
