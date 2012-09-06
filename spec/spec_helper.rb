require 'minitest/autorun'
require 'minitest/pride'
require File.expand_path('../../lib/flechtwerk.rb', __FILE__)

MiniTest::Unit.after_tests do
  Flechtwerk.new.reset_database!
end