require 'pry'
require 'yaml'
require 'byebug'

require_relative "bin/drug"
require_relative "bin/city"
require_relative "bin/world"
require_relative "bin/backpack"
require_relative "bin/wallet"
require_relative "bin/player"
require_relative "bin/ui"
require_relative "bin/screen"
require_relative "bin/screens/travel_screen"
require_relative "bin/screens/marketplace_screen"
require_relative "bin/screens/inventory_screen"
require_relative "bin/screens/buy_screen"
require_relative "bin/screens/sell_screen"
require_relative "bin/screens/transaction_screen"

game = NewUI.new(Player.new("Ben", "Toronto"))
game.start
#player = Player.new("Ben", "Toronto")
#binding.pry
