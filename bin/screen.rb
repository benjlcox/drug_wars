  class Screen
    def initialize(player)
      @player = player
      @big_separator = "=" * 100
      @small_separator = "-" * 100
    end

    def has_action?(user_input)
      actions.include?(user_input)
    end

    def paint(submenu=nil)
      system "clear" or system "cls"
      grid = []
      grid << header
      grid << content_whitespace_padding(content)
      grid << footer(submenu)
      grid.flatten!.each do |row|
        print "#{row}\n"
      end
      grid.clear
    end

    private

    def content
      raise RuntimeError.new("Subclass should implement 'content' method")
    end

    def name
      raise RuntimeError.new("Subclass should implement 'content' method")
    end

    def allow_global_actions?
      raise RuntimeError.new("Subclass should implement 'content' method")
    end

    def header
      [@big_separator,
      "#{@player.name} | $#{@player.check_money} | Day: #{@player.check_day} | City: #{@player.city} | Screen: #{name}",
      @small_separator]
    end

    def footer(submenu)
      [@small_separator,
      submenu,
      "(1) Marketplace | (2) Inventory | (3) Travel | (4) Loan Shark | (5) Fence",
      @big_separator]
    end

    def content_whitespace_padding(data)
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
