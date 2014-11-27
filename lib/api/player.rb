class Player
  attr_reader :name, :current_city, :world

  def initialize(name, city)
    @name = name
    @world = World.new
    @current_city = @world.find(city)
    @backpack = Backpack.new(100)
    @wallet = Wallet.new(100)
  end

  def buy(name, quantity)
    drug = @current_city.drugs["#{name}"]
    cost = drug.price * quantity
    if enough_money?(cost) && add_to_inventory(drug, quantity)
      remove_money(cost)
    else
      false
    end
  end

  def sell(name, quantity)
    drug = @current_city.drugs["#{name}"]
    value = drug.price * quantity
    if enough_inventory?(name, quantity)
      subtract_from_inventory(drug, quantity)
      add_money(value)
    else
      false
    end
  end

  def travel(new_city)
    @current_city = @world.find(new_city)
    @world.new_day
    @current_city
  end

  def market
    @current_city.drugs
  end

  def city
    @current_city.name
  end

  def inventory
    @backpack.contents
  end

  def quantity_in_inventory(name)
    quantity = @backpack.find(name)
    quantity.nil? ? 0 : quantity
  end

  def add_to_inventory(item, quantity)
    @backpack.add(item, quantity)
  end

  def subtract_from_inventory(item, quantity)
    @backpack.decrement(item, quantity)
  end

  def remove_from_inventory(item)
    @backpack.remove(item)
  end

  def add_money(amount)
    @wallet.increment(amount)
  end

  def remove_money(amount)
    if enough_money?(amount)
      @wallet.decrement(amount)
    else
      false
    end
  end

  def enough_money?(amount)
    @wallet.money >= amount
  end

  def enough_inventory?(name, quantity)
    item = @backpack.find(name)
    return false if item.nil?
    @backpack.find(name) >= quantity
  end

  def check_money
    @wallet.money
  end

  def check_day
    @world.day
  end

  def game_over?
    @world.game_over
  end
end
