class BackpackTest < Test::Unit::TestCase

  def setup
    @player = Player.new("Ben", "Toronto")
    @drug = @player.current_city.drugs["Weed"]
    @backpack = Backpack.new(100)
  end

  def test_change_size_should_change_backpack_size
    assert !@backpack.add(@drug, 200)
    @backpack.change_size(200)
    assert @backpack.add(@drug, 200)
  end

  def test_total_inventory_quantity_returns_amount_in_backpack
    @backpack.add(@drug, 20)
    assert_equal 20, @backpack.total_inventory_quantity
  end

  def test_add_adds_drug_to_backpack
    original = @backpack.contents.dup
    @backpack.add(@drug, 10)
    assert_not_same original, @backpack.contents
  end

  def test_find_returns_item_quantity_from_backpack
    @backpack.add(@drug, 10)
    assert_equal 10, @backpack.find("Weed")
  end

  def test_decrement_removes_quantity_of_item_from_inventory
    @backpack.add(@drug, 10)
    @backpack.decrement(@drug, 2)
    assert_equal 8, @backpack.find("Weed")
  end

  def test_remove_removes_an_item_from_inventory
    @backpack.add(@drug, 10)
    assert !@backpack.contents.empty?
    @backpack.remove(@drug.name)
    assert @backpack.contents.empty?
  end

  def test_space_remaining_returns_space_left_in_backpack
    backpack = Backpack.new(10)
    backpack.add(@drug, 2)
    assert_equal 8, backpack.space_remaining
  end

  def test_contents_returns_inventory_hash
    @backpack.add(@drug, 10)
    assert_not_nil @backpack.contents["Weed"]
    assert @backpack.contents.is_a?(Hash)
  end

end
