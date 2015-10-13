#Ruby Test Class

class Scramble
  
  require 'ffi/aspell'

  attr_reader :letters, :variant_count

  def initialize(letters)
    @letters = String.new(letters)
    @variant_count = (1..(@letters.length.zero? ? 1 : @letters.length)).inject(:*)
    @letter_count = @letters.length
  end

  #Return a variant
  def variant (var_num)
    #make sure variant request is in bounds
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
        #puts "letter2get:" + letter2get.to_s() + " | var_num:" + var_num.to_s() + " | " + var_str
      }
      var_str = var_str + letter_array[0].to_s()
      return var_str    
    else
      "Out of Range Error"
    end
  end
  
  #Return array of words found in letters
=begin
  def descramble
    wordfile = "words" + @letter_count.to_s() + ".txt"
    words = Array.new
    0.upto(@variant_count - 1){ |i|
      this_var = variant(i)
      file = File.open("words/" + wordfile) if File.exists?("words/" + wordfile)
      file.each{|line|
        word = line.delete "\n"
        if word == this_var
          words.push this_var
        end
      }
      file.close
    }    
    return words
  end
=end

  def descramble
    words = Array.new
    speller = FFI::Aspell::Speller.new('en_US')
    0.upto(@variant_count - 1) do |i|
      this_var = variant(i)
      words.push this_var if speller.correct?(this_var)
      #if word_check_aspell(this_var)
      #  words.push this_var
      #end 
    end
    speller.close
    return words 
  end
  
  #Use pattern to split letters into words
  def descramble_pattern(pattern)

  end

private

  def word_check_file(this_var)  
    wordfile = "words" + @letter_count.to_s() + ".txt"
    file = File.open("words/" + wordfile) if File.exists?("words/" + wordfile)
    file.each{|line|
      word = line.delete "\n"
      if word == this_var
        return true
      end
    }
    file.close
    return false
  end
  
  def word_check_aspell(this_var)
    speller = FFI::Aspell::Speller.new('en_US')
    if speller.correct?(this_var)
      return true
    else
      return false
    end
    speller.close
  end

end

