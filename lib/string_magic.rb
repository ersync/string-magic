# frozen_string_literal: true

require_relative "string_magic/version"

module StringMagic
  class Error < StandardError; end
  def self.hello_world 
    "hello world!"
  end

  def self.word_count(string)
    string.split.count
  end

end
