class MarketplaceScreen < Screen
  def name
    "Marketplace"
  end

  def content
    @player.current_city.drugs
  end

  def allow_global_actions?
    true
  end
end
