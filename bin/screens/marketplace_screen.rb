class MarketplaceScreen < Screen

  def initialize(player)
    super
    @player = player
  end

  def name
    "Marketplace"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "What can your friendly local drug dealer sell you today?"
    result << ""
    i = 9
    result = result + @player.current_city.drugs.map { |name, drug| i += 1; str = "#{i.to_s(36)}) #{name} - $#{drug.price}"; str }
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    drug = handle_action(input, @player.current_city.drugs)
    BuyScreen.new(@player, drug)
  end
end
