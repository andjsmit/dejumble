require_relative 'scramble_pattern.rb'
require 'test/unit'

class TestScramblePattern < Test::Unit::TestCase
  
  def test_pattern
    assert_equal(['a by'], ScramblePattern.new('bya',[2]).descramble)
  end
  
end