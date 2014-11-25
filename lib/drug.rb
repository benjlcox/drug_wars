class Drug

  attr_reader :name
  attr_reader :price
  attr_reader :trend

  def initialize(name, lower_bound, upper_bound, volatility)
    @name = name
    @upper_bound = upper_bound
    @lower_bound = lower_bound
    @volatility = volatility
    @trend = [true, false].sample
    @price = rand(@lower_bound..@upper_bound)
  end

  def change_price
    set_trend
    if @trend
      @price = @price + (rand(0..@upper_bound) / 10)
    else
      @price = @price - (rand(0..@upper_bound) / 10)
    end
    ensure_price_within_bound
  end

  private

  def set_trend
    if rand(1..10) > @volatility
      @trend
    else
      @trend = !@trend
    end
  end

  def ensure_price_within_bound
    if @price > @upper_bound
      @price = @upper_bound
    elsif @price < @lower_bound
      @price = @lower_bound
    elsif @price < 1
      @price = 1
    end
    @price
  end
end

