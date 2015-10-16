# Class to find words in string of letters

class Scramble
  
  require 'ffi/aspell'

  attr_reader :letters, :variant_count

  def initialize(letters)
    @letters = String.new(letters)
    @variant_count = (1..(@letters.length.zero? ? 1 : @letters.length)).inject(:*)
    @letter_count = @letters.length
  end

  def variant (var_num)
    # Returns a variant
    # First make sure variant request is in bounds
    if var_num < @variant_count
      #make initial array of letters
      letter_array = @letters.split(//)
      var_str = ""
      (@letter_count - 1).downto(1){|i|
        div_mod = var_num.divmod (1..i).inject(:*)
        letter2get = div_mod[0]
        var_num = div_mod[1]
        var_str = var_str + letter_array[letter2get].to_s()
        letter_array.delete_at(letter2get)
      }
      var_str = var_str + letter_array[0].to_s()
      return var_str    
    else
      "Out of Range Error"
    end
  end

  def descramble
    # Returns all words found
    words = Array.new
    speller = FFI::Aspell::Speller.new('en_US')
    0.upto(@variant_count - 1) do |i|
      this_var = variant(i)
      words.push this_var if speller.correct?(this_var) && !words.include?(this_var)
    end
    speller.close
    return words 
  end

end

