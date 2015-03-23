#!/usr/bin/ruby


class Lexicon
  @@hash = nil
  @@array = nil

  # Returns true if the given word is in the lexicon
  def self.is_word?(word)
    if @@hash == nil
      self.read
    end
    return @@hash.has_key?(word.downcase)
  end

  # Return the full array of words
  def self.array
    if @@array == nil
      self.read
    end
    @@array
  end

  # Return a hash containing all the words as keys
  def self.hash
    if @@hash == nil
      self.read
    end
    @@hash
  end

  # Read in the words -- Don't call this directly
  def self.read
    @@array = []
    @@hash = {}
    file = File.new('words.txt', 'r')
    while (line = file.gets)
      line.strip!.downcase!
      @@array.push line
      @@hash[line] = true
    end
    file.close
  end
end
