# frozen_string_literal: true

require_relative "string_magic/version"
require_relative "string_magic/core/analysis"
require_relative "string_magic/core/transformation"

module StringMagic
  class Error < StandardError; end
  class MalformedInputError < Error; end

  # Now extend the modules
  extend Core::Analysis
  extend Core::Transformation

  def self.hello_world
    "hello world!"
  end

  def self.word_count(string)
    string.split.size
  end

  def self.palindrome?(string)
    cleaned = string.downcase.gsub(/[^a-z0-9]/, "")
    cleaned == cleaned.reverse
  end

  def self.capitalize_words(string)
    string.split.map(&:capitalize).join(" ")
  end

  def self.reverse_words(string)
    string.split.reverse.join(" ")
  end

  def self.remove_duplicates(string)
    string.chars.uniq.join
  end

  def self.count_vowels(string)
    string.downcase.count("aeiou")
  end

  def self.to_pig_latin(string)
    string.split.map do |word|
      if word[0] =~ /[aeiou]/i
        word + "ay"
      else
        word[1..-1] + word[0] + "ay"
      end
    end.join(" ")
  end

  def self.alternating_case(string)
    string.chars.map.with_index { |char, i| i.even? ? char.upcase : char.downcase }.join
  end

  def self.camel_case(string)
    string.split.map(&:capitalize).join
  end

  def self.snake_case(string)
    string.downcase.gsub(/\s+/, "_")
  end

  def self.title_case(string)
    string.split.map(&:capitalize).join(" ")
  end

  def self.anagram?(string1, string2)
    processed_string1 = string1.downcase.gsub(/[^a-z0-9]/, "").chars.sort.join
    processed_string2 = string2.downcase.gsub(/[^a-z0-9]/, "").chars.sort.join
    processed_string1 == processed_string2
  end
end
