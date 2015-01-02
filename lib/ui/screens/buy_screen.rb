class BuyScreen < Screen

  def initialize(player, message=nil)
    super(player)
    @message = message
  end

  def name
    "Marketplace > Buy"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "What would you like to buy?"
    result << ""
    i = 9
    result = result + @player.current_city.drugs.map { |name, drug| i += 1; str = "#{i.to_s(36)}) #{name} - $#{drug.price}"; str }
    unless @message.nil?
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    selection = handle_action(input, @player.current_city.drugs)
    if selection
      TransactionScreen.new(@player, {drug: selection, type:"buy"})
    end
  end

  def ai_interface
    i = 9
    content = {}
    menu = {}
    @player.current_city.drugs.map { |name, drug| i += 1; content["#{name}"] = drug.price; menu["#{name}"] = "#{i.to_s(36)}"}
    {
      content: content,
      menu: menu
    }
  end
end
