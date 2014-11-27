class WorldTest < Test::Unit::TestCase

  def setup
    @world = World.new
  end

  def test_world_has_a_day_reader_attribute
    assert_equal 1, @world.day
    assert_raise NoMethodError do
      @world.day = 10
    end
  end

  def test_list_returns_hash_of_cities
    assert_not_nil @world.list["Toronto"]
    assert @world.list.is_a?(Hash)
  end

  def test_find_returns_single_city_object
    assert_not_nil @world.find("Toronto")
    assert @world.find("Toronto").is_a?(City)
  end

  def test_find_raises_if_city_name_is_invalid
    assert_raise World::InvalidCity do
      @world.find("Ottawa")
    end
  end

  def test_new_day_increments_day
    @world.new_day
    assert_equal 2, @world.day
  end

  def test_new_day_calls_new_day_on_cities
    @world.find("Toronto").expects(:new_day).once
    @world.new_day
  end

  def test_world_has_a_game_over_attribute_defaulted_to_false
    assert_equal false, @world.game_over
    assert_raise NoMethodError do
      @world.game_over = true
    end
  end

  def test_end_game_sets_game_over_to_true
    before = @world.game_over
    @world.end_game
    assert @world.game_over
    assert_not_equal before, @world.game_over
  end
end
