#!/usr/bin/ruby

require './words'

# Detects whether a the given word is a palindrome
def is_palindrome?(word)
  if word == nil or word.lstrip().empty?
    return false
  end

  i = 0
  j = word.length - 1
  while (i < j && j < word.length)
    if (word[i] == word[j])
      i+=1;
      j-=1;
    else
      return false
    end
  end
  return true
end

# Generates an array of all the anagrams of the given word
def generate_anagrams(word)
  if word == nil or word.lstrip().empty?
    return []
  end
  if word.length == 1
    return [word]
  end
  Lexicon.generateAnagrams()
  anagrams = Lexicon.anagrams
  key = word.chars.sort { |a, b| a.casecmp(b) } .join.downcase
  if anagrams.has_key?(key)
    return anagrams[key]
  else
    return []
  end
end

#Binary search between head and tail indices in lexicon array. 
#Starting represents the start index of our desired prefix in the lexicon array,
# which is returned when type=0 will return.
#Ending represents the end index of our desired prefix in the lexicon array,
# which is returned when type=1.
def binary_search(starting, ending, head, tail, prefix, type, lexicon)
  while (head <= tail) 
    midpoint = (tail - head)/2 + head
    word = lexicon[midpoint].downcase
    result = word <=> prefix
    if (word.start_with? prefix or result == 0)
      if type == 0
        starting = midpoint
        tail = midpoint - 1
      else
        ending = midpoint
        head = midpoint + 1
      end
    elsif (result == -1)
      head = midpoint + 1
    else
      tail = midpoint - 1
    end
  end
  if type == 0
    return starting
  else
    return ending
  end
end

# Generates an array of all the words that have the given word as a prefix
def prefixed_words(prefix)
  if prefix == nil or prefix.lstrip().empty?
    return []
  end

  lexicon = Lexicon.array
  prefix = prefix.downcase
  head = 0
  tail = lexicon.length-1
  starting = -1
  ending = -1
  starting = binary_search(starting, ending, head, tail, prefix, 0, lexicon)
  head = starting
  tail = lexicon.length - 1
  ending = binary_search(starting, ending, head, tail, prefix, 1, lexicon)
   
  if (starting == -1 && ending == -1)
    return []
  end

  prefixed = []
  for i in starting..ending
    prefixed.push(lexicon[i])
  end
  return prefixed
end

# Generates the shortest possible word ladder connecting the two words. 
#Creates a graph with edges between words that are one character apart 
#(no adding or deletion of characters just a change) and runs Dijkstra's
#on it. Note: If this were not an interview question, I would use something like
#Ruby Tree or some other built-in module to generate and traverse a graph.
def word_ladder(start_word, end_word)
  graph = Graph. new()
  bucketToWords = Lexicon.buckets
  for bucket in bucketToWords.keys()
    for word1 in bucketToWords[bucket]
      for word2 in bucketToWords[bucket]
        if word1 != word2
          graph.add_vertex(word1, word2)
        end
      end
    end
  end
  return graph.shortest_path(start_word, end_word)
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
if ladder.length == 1 and ladder[0] == 0
  puts "\n     There is no possible word ladder for #{word} -> #{end_word}"
else 
  print "#{word} -> "
  ladder.each do |rung|
    print "#{rung} -> "
  end
  puts end_word
end
