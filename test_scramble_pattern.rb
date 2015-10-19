require_relative 'scramble_pattern.rb'
require 'test/unit'

class TestScramblePattern < Test::Unit::TestCase
  
  def test_pattern
    assert_equal(['two bit'], ScramblePattern.new('obtitw',[3,3]).descramble)
  end
  
end