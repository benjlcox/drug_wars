class CityTest < Test::Unit::TestCase
  def setup
    @player = Player.new("Ben", "Toronto")
    @city = @player.current_city
  end

  def test_city_provides_name
    assert_equal "Toronto", @city.name
  end

  def test_city_has_drugs
    drugs = @city.drugs
    assert drugs.is_a?(Hash)
    assert_not_nil drugs["Weed"].price
  end

  # Need to test something with a random result...
  def test_new_day_changes_drug_prices_in_city
    drug = @city.drugs["Weed"]
    drug.stubs(:rand).returns(10)

    original_price = drug.price
    @city.new_day
    assert_not_equal drug.price, original_price
  end
end
