class MarketplaceScreen < Screen

  def initialize(player)
    super(player)
  end

  def name
    "Marketplace"
  end

  def submenu_text
    "b) Buy | s) Sell"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "What can your friendly local drug dealer sell you today?"
    result << ""
    result = result + @player.current_city.drugs.map { |name, drug| str = "#{name} - $#{drug.price}"; str }
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    case input
    when "b"
      BuyScreen.new(@player)
    when "s"
      SellScreen.new(@player)
    end
  end
end
