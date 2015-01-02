class TransactionScreen < Screen

  def initialize(player, options)
    super(player)
    @drug = options[:drug]
    @type = options[:type]
  end

  def name
    "Transaction"
  end

  def allow_global_actions?
    false
  end

  def content
    result = []
    result << "How much #{@drug} would you like to #{@type}?"
    result << ""
    result << "You currently have #{@player.quantity_in_inventory(@drug)} and it's worth $#{@player.market[@drug].price}/each"
    if @type == "buy"
      max = (@player.check_money / @player.market[@drug].price)
      @max_possible = max > @player.inventory_space_remaining ? @player.inventory_space_remaining : max
      result << "The maximum you can purchase is: #{@max_possible}"
    else @type == "sell"
      @max_possible = @player.quantity_in_inventory(@drug)
    end
    result << ""
    if @message
      result << ""
      result << @message
    end
    result
  end

  def submenu(input)
    unless ["buy","sell"].include?(@type)
      raise StandardError.new("#{@type} is not a valid transaction type")
    end
    if @type == "buy"
      if @player.buy(@drug, input.to_i)
        BuyScreen.new(@player)
      else
        BuyScreen.new(@player, "You cannot do that.")
      end
    else
      SellScreen.new(@player) if @player.sell(@drug, input.to_i)
    end
  end

  def ai_interface
    {
      content: {"type" => @type, "drug" => @drug, "quantity_in_inventory" => @player.quantity_in_inventory(@drug), "price" => @player.market[@drug].price, "max" => @max_possible},
      menu: nil
    }
  end
end
