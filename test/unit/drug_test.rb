class DrugTest < Test::Unit::TestCase

  def setup
    @player = Player.new("Ben", "Toronto", true)
    @drug = @player.current_city.drugs["Weed"]
  end

  def test_drug_has_name
    assert_equal @drug.name, "Weed"
  end

  def test_drug_has_price
    assert_not_nil @drug.price
  end

  def test_drug_has_trend
    assert [true,false].include?(@drug.trend)
  end

  #def test_change_price_actually_changes_price
  #  old_price = @drug.price
  #  @drug.change_price
  #  puts "#{old_price} ===> #{@drug.price}"
  #  assert_not_equal @drug.price, old_price
  #end

  def test_probablity_of_trend_change_matches_volatility_setting
    old_trend = @drug.trend
    counter = 0
    1000.times do
      @drug.change_price
      if @drug.trend != old_trend
        counter += 1
        old_trend = @drug.trend
      end
    end
    assert ((counter > 525) && (counter < 675))
  end

end
