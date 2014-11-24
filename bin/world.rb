class World
  attr_reader :day

  def initialize
    @cities = {}
    @day = 1
    load_from_file
  end

  def list
    @cities
  end

  def find(city)
    if @cities[city].nil?
      raise InvalidCity
    else
      @cities[city]
    end
  end

  def new_day
    @cities.each_pair do |name, city|
      city.new_day
    end
    @day += 1
  end

  private

  class InvalidCity < StandardError
  end

  def load_from_file
    city_db = YAML.load_file("config/cities.yml")
    drug_db = YAML.load_file("config/drugs.yml")
    city_db.each_pair do |city, drugs|
      city_drugs = {}
      drugs.each do |drug|
        city_drugs[drug_db[drug]["name"]] = Drug.new(drug_db[drug]["name"], drug_db[drug]["lower_bound"], drug_db[drug]["upper_bound"], drug_db[drug]["volatility"])
      end
      @cities["#{city}"] = City.new("#{city}", city_drugs)
    end
  end

end
