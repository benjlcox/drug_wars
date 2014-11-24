class City
  attr_reader :name
  attr_accessor :drugs

  def initialize(name, drugs)
    @name = name
    @drugs = drugs
  end

  def new_day
    @drugs.each_pair do |name, drug|
      drug.change_price
    end
  end
end
