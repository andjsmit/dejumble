require_relative 'scramble.rb'
require 'test/unit'

class TestScramble < Test::Unit::TestCase
  
  def test_single_word
    assert_equal(['trashy'], Scramble.new("htarsy").descramble)
    assert_equal(['elephant'], Scramble.new('phtnalee').descramble)
    assert_equal(['less'], Scramble.new("sles").descramble)
  end
  
end
