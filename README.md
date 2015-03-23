# Lexicali

## The Problem

We provided a lexicon of words and the code to read the lexicon into memory.
We want to write a short script that does the following:

* Prints whether the word is a palindrome
* Generates all possible anagrams of the word
* Finds all words with a given prefix
* Prints the shortest possible word ladder between two words

The stubs are provided inside `lex.rb`. You'll need to make sure you run the
code from within this directory by calling `ruby lex.rb`. You can place all your
code inside that file, but you are welcome to modify `words.rb` if you want to
change any functionality.

Please also write a few quick comments for each method describing how you
decided to solve the problem.

When you're done (or even in the middle), please push the code back up to this
repository.

## What we're looking for

* Clean, easy to read, and easy to understand code
* Efficient implementations
* It runs and produces the correct results

# Some Helpful Info

Palindrome: A sequence of characters that is the same forward and backward.
(e.g. 'otto' is a palindrome)

Anagram: A rearranging of the letters of a word to form a new dictionary word,
using each letter from the original word exactly once. For example, 'act' is an
anagram for 'cat' but 'tca' is not.

Word Ladder: The shortest possible chain between two words where each step in
the chain differs by only a single letter.
(e.g. cold -> cord -> card -> ward -> warm)
See: http://en.wikipedia.org/wiki/Word_ladder
