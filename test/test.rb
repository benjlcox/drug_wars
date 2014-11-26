require 'test/unit'
require 'yaml'
require 'byebug'
require 'mocha/test_unit'
Dir[Dir.pwd + "/lib/**/*.rb"].each { |file| require file }
Dir[Dir.pwd + "/test/config/**/*.rb"].each { |file| require file }
Dir[Dir.pwd + "/test/unit/**/*.rb"].each { |file| require file }
