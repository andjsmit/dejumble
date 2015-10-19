# Class to find words in a string of letters with know space locations

require_relative 'scramble.rb'

class ScramblePattern < Scramble
  
  attr_reader :letters, :splits
  
  def initialize(letters, splits)
    super(letters)
    @splits = splits
  end
  
  def variant (var_num)
    var_str = super(var_num)
    phrase = var_str
    pos = 0
    @splits.each.with_index do |wrd_count, n|
      pos = pos + wrd_count + n
      phrase = phrase.insert(pos, " ") if @splits.size > n + 1
    end
    return phrase
  end
  
  def descramble
    speller = FFI::Aspell::Speller.new('en_US')
    phrases = Array.new()
    0.upto(@variant_count - 1) do |i|
      phrase = variant(i)
      phrase_words = phrase.split(" ")
      phrase_pass = true
      phrase_words.each do |wrd|
        phrase_pass = false if !speller.correct?(wrd)
      end
      phrases << phrase if phrase_pass && !phrases.include?(phrase)
    end
    speller.close
    return phrases
  end
  
end