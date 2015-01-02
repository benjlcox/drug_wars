  class Screen
    attr_accessor :submenu_text

    def initialize(player, options={})
      @player = player
      @options
      @big_separator = "=" * 100
      @small_separator = "-" * 100
    end

    def has_action?(user_input)
      actions.include?(user_input)
    end

    def paint
      system "clear" or system "cls"
      grid = []
      grid << header
      grid << content_whitespace_padding(content)
      grid << footer(submenu_text)
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
      raise RuntimeError.new("Subclass should implement 'name' method")
    end

    def allow_global_actions?
      raise RuntimeError.new("Subclass should implement 'allow_global_actions?' method")
    end

    def ai_interface
      raise RuntimeError.new("Sublass should implement 'ai_interface' method")
    end

    def header
      [@big_separator,
      "#{@player.name} | $#{@player.check_money} | Day: #{@player.check_day} | City: #{@player.city} | Screen: #{name}",
      @small_separator]
    end

    def footer(submenu)
      footer = []
      footer << @small_separator
      footer << submenu
      if allow_global_actions?
        footer << @small_separator
        footer << "(1) Marketplace | (2) Inventory | (3) Travel | (4) Loan Shark | (5) Fence" if allow_global_actions?
      else
        footer << ""
        footer << ""
      end
      footer << @big_separator
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

    def handle_action(input, list)
      i = 9
      options = list.keys.inject({}) { |result, option| i += 1; result[i.to_s(36)] = option; result }
      options[input].nil? ? false : options[input]
    end

  end
