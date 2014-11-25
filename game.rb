require 'pry'
require 'yaml'
require 'byebug'

Dir[Dir.pwd + "/**/*.rb"].each { |file| require file }

game = UI.new(Player.new("Ben", "Toronto"))
game.start
#player = Player.new("Ben", "Toronto")
#binding.pry
