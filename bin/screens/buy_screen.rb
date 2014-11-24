class BuyScreen < Screen

  def initialize(player, drug)
    super
    @player = player
    @drug = drug
  end

  def name
    "Marketplace > Buy"
  end

  def allow_global_actions?
    false
  end

  def content
    result = []
    result << "How much #{@drug} would you like to buy?"
    result << ""
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    if @player.buy(@drug, input.to_i)
      @message = "It was good doing business."
      MarketplaceScreen.new(@player)
    else
      @message = "You don't have enough money to buy #{input}. Try buying less."
    end
  end
end
