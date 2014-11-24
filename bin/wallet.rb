class Wallet
  attr_reader :money

  def initialize(money)
    @money = money
  end

  def increment(amount)
    @money += amount
  end

  def decrement(amount)
    ensure_not_negative(amount)
    @money -= amount
  end

  private

  def ensure_not_negative(amount)
    if (@money -= amount) < 0
      raise NotEnoughMoney
    end
  end

  class NotEnoughMoney < StandardError
  end

end
