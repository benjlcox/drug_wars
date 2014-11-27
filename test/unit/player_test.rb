class PlayerTest < Test::Unit::TestCase

  def setup
    @player = Player.new("Ben", "Toronto")
    @drug = @player.current_city.drugs["Weed"]
  end

  def test_player_has_a_name
    assert_not_nil @player.name
  end

  def test_player_has_current_city
    assert_not_nil @player.current_city
  end

  def test_player_has_world
    assert_not_nil @player.world
  end

  def test_buy_drug_adds_to_inventory
    before_inventory = @player.inventory.dup
    @player.buy(@drug.name, 1)
    assert_not_equal @player.inventory, before_inventory
  end

  def test_buy_removes_money_from_player
    before_money = @player.check_money
    @player.buy(@drug.name, 1)
    assert_not_equal @player.check_money, before_money
  end

  def test_buy_fails_if_not_enough_money
    assert_equal false, @player.buy(@drug.name, 9999999)
  end

  def test_buy_fails_if_not_enough_space_in_backpack
    @player.add_money(999999)
    assert_equal false, @player.buy(@drug.name, 101)
  end

  def test_sell_drug_removes_from_inventory
    @player.add_to_inventory(@drug, 1)
    before_inventory = @player.inventory.dup
    @player.sell(@drug.name, 1)
    assert_not_equal @player.inventory, before_inventory
  end

  def test_sell_adds_money_to_player
    @player.add_to_inventory(@drug, 1)
    before_money = @player.check_money
    @player.sell(@drug.name, 1)
    assert_not_equal @player.check_money, before_money
  end

  def test_sell_fails_if_not_enough_inventory
    assert_equal false, @player.sell(@drug.name, 9999999)
  end

  def test_travel_changes_players_city
    current = @player.city
    @player.travel("Chicago")
    assert_not_equal current, @player.city
  end

  def test_travel_raises_invalid_city_if_passed_invalid_city
    assert_raises World::InvalidCity do
      @player.travel("Boston")
    end
  end

  def test_market_returns_hash_of_drugs_in_city
    drugs = @player.market
    assert_not_nil drugs["Weed"]
    assert drugs.is_a?(Hash)
  end

  def test_city_returns_citys_name
    assert_equal "Toronto", @player.city
  end

  def test_quantity_in_inventory_returns_number_in_inventory
    @player.buy(@drug.name, 1)
    assert_equal 1, @player.quantity_in_inventory(@drug.name)
  end

  def test_quantity_in_inventory_returns_zero_if_nil
    assert_equal 0, @player.quantity_in_inventory("Bacon")
  end

  def test_add_to_inventory_adds_item_to_inventory
    @player.add_to_inventory(@drug, 1)
    assert_not_empty @player.inventory
  end

  def test_subtract_from_inventory_subtracts_item_from_inventory
    @player.add_to_inventory(@drug, 2)
    assert_not_empty @player.inventory
    @player.subtract_from_inventory(@drug, 1)
    assert_equal 1,  @player.quantity_in_inventory(@drug.name)
  end

  def test_subtract_from_inventory_removes_item_if_quantity_hits_zero
    @player.add_to_inventory(@drug, 1)
    assert_not_empty @player.inventory
    @player.subtract_from_inventory(@drug, 1)
    assert_empty @player.inventory
  end

  def test_subtract_returns_false_if_not_enough_in_inventory
    @player.add_to_inventory(@drug, 1)
    assert_equal false, @player.subtract_from_inventory(@drug, 2)
  end

  def test_remove_from_inventory_removes_all_from_inventory
    @player.add_to_inventory(@drug, 2)
    assert_not_empty @player.inventory
    @player.remove_from_inventory(@drug.name)
    assert_empty @player.inventory
  end

  def test_add_money_adds_money_to_wallet
    before = @player.check_money
    @player.add_money(10)
    assert_equal before + 10, @player.check_money
  end

  def test_remove_money_removes_money_from_wallet
    before = @player.check_money
    @player.remove_money(10)
    assert_equal before - 10, @player.check_money
  end

  def test_removing_more_money_than_in_wallet_returns_false
    money = @player.check_money
    assert_equal false, @player.remove_money(money + 10)
  end

  def test_enough_money_ensures_money_is_greater_than_or_equal_to_amount
    money = @player.check_money
    assert @player.enough_money?(money)
    assert @player.enough_money?(money - 10)
    assert !@player.enough_money?(money + 10)
  end

  def test_enough_inventory_checks_if_enough_inventory
    @player.add_to_inventory(@drug, 1)
    assert @player.enough_inventory?(@drug.name, 1)
    assert_equal false, @player.enough_inventory?(@drug.name, 2)
  end

  def test_check_money_returns_amount_of_money_player_has
    assert_equal 100, @player.check_money
  end

  def test_check_day_returns_current_day
    assert_equal 1, @player.check_day
  end

  def test_game_over_returns_false_if_game_is_not_over
    assert_equal false, @player.game_over?
  end
end
