require_relative 'scramble'

scramble = Scramble.new("htarsy")
var_num = 2
puts "Scramble : " + scramble.letters
puts "Variant Count : " + scramble.variant_count.to_s()
#rubyputs "Variant " + var_num.to_s + " : " + scramble.variant(var_num)
puts "------Words--------"
puts scramble.descramble.to_s()