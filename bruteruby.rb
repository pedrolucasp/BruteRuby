#!/bin/ruby

class Cracker
  def initialize(char_array, password_range)
    @char_array = char_array
    @password_range = password_range
  end
  
  def password_correct?(test_password)
    test_password == "DCBAAAA"
  end

  def generate_password( perm_number, password_length )
    password=""
    (1..password_length).each do |char_number| # loop through characters
      char_reference = (perm_number / @char_array.length**(char_number-1)).floor % @char_array.length
      character = @char_array[char_reference]
      password << character
    end
    password
  end

  def do_combination( num_combinations, password_length )
    (0..num_combinations-1).each do |perm_number| # loop through combinations for a given length      
      password = generate_password( perm_number, password_length )
      return password, perm_number if password_correct?(password)
    end
  end 

  def crack()
    (@password_range).each do |password_length|  # loop to gradually increase password length
      num_combinations=@char_array.length**password_length
      password, perm_number = do_combination(num_combinations, password_length)
      if password
        puts "#{password} | Access Granted | #{perm_number} / #{num_combinations}"
        return password
      end
    end
  end
end

cracker = Cracker.new( "ABCD".split(//), (5..15) )
password = cracker.crack()
