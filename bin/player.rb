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
    if enough_money?(cost)
      add_to_inventory(drug, quantity)
      remove_money(cost)
    else
      "Not enough money"
    end
  end

  def sell(name, quantity)
    drug = @current_city.drugs["#{name}"]
    value = drug.price * quantity
    if enough_inventory?(name, quantity)
      subtract_from_inventory(drug, quantity)
      add_money(value)
    else
      "Not enough inventory"
    end
  end

  def travel(new_city)
    if @current_city = @world.find(new_city)
      @world.new_day
      @current_city
    else
      @current_city
    end
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
    @wallet.decrement(amount)
  end

  def enough_money?(amount)
    @wallet.money >= amount
  end

  def enough_inventory?(name, quantity)
    @backpack.find(name) >= quantity
  end

  def check_money
    @wallet.money
  end

  def check_day
    @world.day
  end

end
