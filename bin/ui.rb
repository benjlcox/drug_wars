class UI

  def self.start(player)
    @player = player
    @current_screen = market_screen
    loop do
      @current_screen = user_input(gets.chomp)
      if @current_screen == "quit"
        break
      end
    end
  end

  private

  def self.user_input(input)
    case input
    when "1"
      market_screen
    when "2"
      inventory_screen
    when "3"
      travel_screen
    when "4"
      loan_screen
    when "5"
      fence_screen
    when "quit"
      @current_screen = "quit"
    else
      @current_screen
    end
  end

  def self.market_screen(special=false)
    output = []
    drugs = @player.current_city.drugs
    drugs.each_pair do |name, drug|
      output << "#{drug.name}#{dots(drug.name.length)}$#{drug.price}"
    end
    GameScreen.new(@player,output).display
  end

  def self.buy_and_sell_screen
    output = "Fuck yes"
    GameScreen.new(@player,output).display
  end

  def self.inventory_screen
    output = []
    drugs = @player.inventory
    drugs.each_pair do |name, drug|
      output << "#{drug.name}#{dots(drug.name.length)}#{drug.quantity}"
    end
    GameScreen.new(@player,output).display
  end

  def self.travel_screen
    output = []
    cities = @player.world.list
    cities.each_pair do |name, city|
      output << "#{city.name}" unless @player.city == city.name
    end
    GameScreen.new(@player,output).display
  end

  def self.loan_screen
  end

  def self.fence_screen
  end

  def self.dots(chars)
    "." * (40 - chars)
  end

  class GameScreen
    def initialize(player, data)
      @player = player
      @data = data
      @grid = []
      @big_separator = "=" * 100
      @small_separator = "-" * 100
    end

    def display(message=nil)
      system "clear" or system "cls"
      @grid << header
      @grid << content(@data)
      @grid << footer(message)
      @grid.flatten!.each do |row|
        print "#{row}\n"
      end
      @grid.clear
    end

    private

    def header
      [@big_separator,
      "#{@player.name} | $#{@player.check_money} | Day: #{@player.check_day} | City: #{@player.city}",
      @small_separator]
    end

    def footer(message)
      [@small_separator,
      message,
      @small_separator,
      "(1) Marketplace | (2) Inventory | (3) Travel | (4) Loan Shark | (5) Fence",
      @big_separator]
    end

    def content(data)
      content = []
      data_size = data.size
      whitespace_size = (20 - data_size) / 2
      whitespace_size.times do
        content << nil
      end
      content << data
      whitespace_size.times do
        content << nil
      end
      content
    end
  end

end
