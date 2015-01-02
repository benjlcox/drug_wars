class InventoryScreen < Screen

  def initialize(player)
    super
    @player = player
  end

  def name
    "Inventory"
  end

  def allow_global_actions?
    true
  end

  def content
    result = []
    result << "Here's what's in your backpack:"
    result << ""
    i = 9
    result = result + @player.inventory.map { |name, quantity| i += 1; str = "#{i.to_s(36)}) #{name} - #{quantity}"; str }
    if result.size == 2
      result << ""
      result << "....it's empty."
    end
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    drug = handle_action(input, @player.current_city.drugs)
    #Open ditch screen
    paint
  end

  def ai_interface
    content = {}
    {
      content: @player.inventory.map { |name, quantity| content["#{name}"] = "#{quantity}"},
      menu: nil
    }
  end
end
