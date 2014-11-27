class World
  attr_reader :day, :game_over

  def initialize
    @cities = {}
    @day = 1
    @game_over = false
    load_from_file
  end

  def list
    @cities
  end

  def find(name)
    if @cities[name].nil?
      raise InvalidCity
    else
      @cities[name]
    end
  end

  def new_day
    @cities.each_pair do |name, city|
      city.new_day
    end
    @day += 1
    if @day > 30
      @game_over = true
    end
  end

  def end_game
    @game_over = true
  end

  private

  class InvalidCity < StandardError
  end

  def load_from_file
    if $TEST
      city_db = YAML.load_file("./test/fixtures/cities.yml")
      drug_db = YAML.load_file("./test/fixtures/drugs.yml")
    else
      city_db = YAML.load_file("./config/cities.yml")
      drug_db = YAML.load_file("./config/drugs.yml")
    end
    city_db.each_pair do |city, drugs|
      city_drugs = {}
      drugs.each do |drug|
        city_drugs[drug_db[drug]["name"]] = Drug.new(drug_db[drug]["name"], drug_db[drug]["lower_bound"], drug_db[drug]["upper_bound"], drug_db[drug]["volatility"])
      end
      @cities["#{city}"] = City.new("#{city}", city_drugs)
    end
  end
end
