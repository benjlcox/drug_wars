class WalletTest < Test::Unit::TestCase

  def setup
    @wallet = Wallet.new(100)
  end

  def test_wallet_has_money_read_attribtue
    assert_equal 100, @wallet.money
    assert_raise NoMethodError do
      @wallet.money = 200
    end
  end

  def test_increment_adds_money_to_wallet
    assert_equal 200, @wallet.increment(100)
  end

  def test_decrement_removes_money_from_wallet
    assert_equal 50, @wallet.decrement(50)
  end

  def test_raise_if_decrement_more_than_money_in_wallet
    assert_raise Wallet::NotEnoughMoney do
      @wallet.decrement(200)
    end
  end
end
