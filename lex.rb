#!/usr/bin/ruby

require './words'

# Detects whether a the given word is a palindrome
def is_palindrome?(word)
  # FILL ME IN
  return false
end

# Generates an array of all the anagrams of the given word
def generate_anagrams(word)
  # FILL ME IN
  return []
end

# Generates an array of all the words that have the given word as a prefix
def prefixed_words(prefix)
  # FILL ME IN
  return []
end

# Generates the shortest possible word ladder connecting the two words
def word_ladder(start_word, end_word)
  return []
end


# Main program body -- this is what ends up on the terminal
print 'Please enter a word: '
word = gets.chomp

puts "\nYou entered the word: #{word}"

puts "\nIs it a real word? #{Lexicon.is_word?(word)}"

# Is it a palindrome?
puts "Palindrome?: #{is_palindrome?(word)}"

# Print the anagrams
puts "\nHere are all the anagrams for '#{word}':"
anagrams = generate_anagrams(word)
anagrams.each do |anagram|
  puts "\t#{anagram}"
end

# Print the words that this word prefixes
puts "\nHere are all the words prefixed by '#{word}':"
prefixed = prefixed_words(word)
prefixed.each do |pre|
  puts "\t#{pre}"
end

print 'Please enter an end word: '
end_word = gets.chomp
ladder = word_ladder(word, end_word)

puts "\nHere is the word ladder for #{word} -> #{end_word}:"
print "#{word} -> "
ladder.each do |rung|
  print "#{rung} -> "
end
puts end_word
