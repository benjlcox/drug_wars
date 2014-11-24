class TravelScreen < Screen
  def initialize(player)
    super
  end

  def name
    "Travel"
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

  def allow_global_actions?
    true
  end

  def handle_action(input)
    i = 9
    options = @player.world.list.keys.inject({}) { |result, city| i += 1; result[i.to_s(36)] = city; result }
    city = options[input]
    if city.nil? || city == @player.city
      @message = "Invalid option!!!"
    else
      @player.travel(city)
    end
    paint
  end
end
