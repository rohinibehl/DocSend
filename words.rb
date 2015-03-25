#!/usr/bin/ruby
require 'set'
require 'priority_queue'

class Lexicon
  @@hash = nil
  @@array = nil
  @@anagrams = nil
  @@bucketToWords = nil

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
    @@bucketToWords = Hash.new { |h, k| h[k] = [] }
    file = File.new('words.txt', 'r')
    while (line = file.gets)
      line.strip!.downcase!
      @@array.push line
      @@hash[line] = true

      #Generate buckets of words with only one character different
      # between words in a single bucket to create the graph for
      # running Dijkstra's on
      n = line.length - 1
      bucket = '_'.to_str << line[1..n].to_str
      if @@bucketToWords.has_key? bucket
        @@bucketToWords[bucket].push(line)
      else
        @@bucketToWords[bucket] = [line]
      end
      for i in 1..n
        bucket = line[0..i-1] << '_' << line[i+1..n]
        if @@bucketToWords.has_key? bucket
          @@bucketToWords[bucket].push(line)
        else
          @@bucketToWords[bucket] = [line]
        end
      end
    end
    file.close
  end

  def self.anagrams
    @@anagrams
  end

  def self.buckets
    @@bucketToWords
  end

  #Generates a map of key - lowercase alphabetically sorted version
  #of word, to value - list of words with that key (i.e. anagrams of that word) 
  def self.generateAnagrams
    @@anagrams = Hash.new { |h, k| h[k] = Set.new }
    @@array.each do |entry|
      key = entry.chars.sort { |a, b| a.casecmp(b) } .join.downcase
      if !@@anagrams.has_key? key
        @@anagrams[key] = [entry].to_set
      else 
        @@anagrams[key].add(entry)
      end
    end
  end
end

class Graph
  def initialize
    @@vertexToEdges = Hash.new { |h, k| h[k] = [] }
  end

  #Adds an edge to the @@vertexToEdges adjacency list representation
  #of the graph. 
  def add_vertex(vertex, edges)
    if @@vertexToEdges.has_key? vertex
      @@vertexToEdges[vertex].push(edges)
    else
      @@vertexToEdges[vertex] = [edges]
    end
  end

  #Dijkstra's shortest path between start and target
  def shortest_path(start, target)
    max = Float::INFINITY
    distances = {}
    previous = {}
    queue = PriorityQueue.new
    
    @@vertexToEdges.keys().each do |vertex|
      if vertex == start
          distances[vertex] = 0
          queue[vertex] = 0
      else
          distances[vertex] = max
          queue[vertex] = max
      end
      previous[vertex] = nil
    end
    
    while queue
        current = queue.delete_min_return_key
        if current == target
          path = []
          while previous[current]
              path.push(current)
              current = previous[current]
          end
          path = path.reverse[0..path.length-2]
          if path.length == 1 and path[0]== target
            return []
          end
          return path
        end
            
        if current == nil or distances[current] ==     max
          break            
        end

        @@vertexToEdges[current].each do |neighbor|
            alt = distances[current] + 1
            if alt < distances[neighbor]
                distances[neighbor] = alt
                previous[neighbor] = current
                queue[neighbor] = alt
            end
        end
    end
    return [0]
  end
end
