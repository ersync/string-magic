# frozen_string_literal: true

RSpec.describe StringMagic do
  describe "methods" do
    context "#word_count" do
      it "returns the correct number of words in a string" do
        expect(StringMagic.word_count("Hello, World!")).to eq(2)
      end
      it "returns the correct number of words for an empty string" do
        expect(StringMagic.word_count("")).to eq(0)
      end
    end
    context "#palindrome?" do
      it "returns true for a palindrome string" do
        expect(StringMagic.palindrome?("A man, a plan, a canal, Panama")).to be(true)
      end
      it "returns false for a non-palindrome string" do
        expect(StringMagic.palindrome?("hello")).to be(false)
      end
    end
  end
end
