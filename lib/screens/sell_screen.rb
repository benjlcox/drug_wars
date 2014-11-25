class SellScreen < Screen

  def initialize(player)
    super(player)
  end

  def name
    "Marketplace > Sell"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "What would you like to sell?"
    result << ""
    i = 9
    result = result + @player.inventory.map { |name, quantity| i += 1; str = "#{i.to_s(36)}) #{name} - #{quantity}"; str }
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    selection = handle_action(input, @player.inventory)
    if selection
      TransactionScreen.new(@player, {drug: selection, type:"sell"})
    end
  end
end
