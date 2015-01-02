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
    result = result + available_to_sell.map { |name, quantity| i += 1; str = "#{i.to_s(36)}) #{name} - #{quantity}"; str }
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

  def ai_interface
    i = 9
    content = {}
    menu = {}
    available_to_sell.map { |name, quantity| i += 1; content["#{name}"] = quantity; menu["#{name}"] = "#{i.to_s(36)}"}
    {
      content: content,
      menu: menu
    }
  end

  private

  def available_to_sell
    available = {}
    @player.available_to_sell_in_current_city.map {|name| available[name] = @player.inventory[name]}
    available
  end
end
