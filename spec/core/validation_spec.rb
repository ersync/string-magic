# spec/string_magic/core/validation_spec.rb
require 'uri'
require 'spec_helper'

RSpec.describe StringMagic::Core::Validation do
  let(:test_string) { "test" }

  before do
    test_string.extend(described_class)
  end

  describe "#email?" do
    it "returns true for valid emails" do
      expect("user@example.com".extend(described_class).email?).to be true
    end

    it "returns false for invalid emails" do
      expect("user@.com".extend(described_class).email?).to be false
    end

    it "returns false for nil or empty" do
      expect("".extend(described_class).email?).to be false
    end
  end

  describe "#url?" do
    it "returns true for valid http/https URLs" do
      expect("https://example.com".extend(described_class).url?).to be true
    end

    it "returns false for non-URLs" do
      expect("not_a_url".extend(described_class).url?).to be false
    end
  end

  describe "#phone?" do
    it "returns true for digits length between 10 and 15" do
      expect("(123) 456-7890".extend(described_class).phone?).to be true
    end

    it "returns false if too short or too long" do
      expect("12345".extend(described_class).phone?).to be false
      expect(("1" * 16).dup.extend(described_class).phone?).to be false
    end
  end

  describe "#credit_card?" do
    it "returns true for valid Luhn number" do
      expect("4111111111111111".extend(described_class).credit_card?).to be true
    end

    it "returns false for invalid Luhn number" do
      expect("4111111111111121".extend(described_class).credit_card?).to be false
    end
  end

  describe "#palindrome?" do
    it "returns true for palindrome ignoring case and non-alphanumerics" do
      expect("A man, a plan, a canal: Panama".extend(described_class).palindrome?).to be true
    end

    it "returns false for non-palindrome" do
      expect("hello".extend(described_class).palindrome?).to be false
    end
  end

  describe "#anagram_of?" do
    it "returns true for words with same letters ignoring case/spaces" do
      expect("listen".extend(described_class).anagram_of?("Silent")).to be true
    end

    it "returns false for different words" do
      expect("apple".extend(described_class).anagram_of?("orange")).to be false
    end
  end

  describe "#numeric?" do
    it "returns true for integers and decimals" do
      expect("123".extend(described_class).numeric?).to be true
      expect("-123.45".extend(described_class).numeric?).to be true
    end

    it "returns false for non-numeric" do
      expect("abc".extend(described_class).numeric?).to be false
    end
  end

  describe "#integer?" do
    it "returns true for integer strings" do
      expect("-123".extend(described_class).integer?).to be true
    end

    it "returns false for decimals" do
      expect("12.3".extend(described_class).integer?).to be false
    end
  end

  describe "#strong_password?" do
    it "returns true if meets length and complexity" do
      expect("Aa1!aaaa".extend(described_class).strong_password?).to be true
    end

    it "returns false if missing complexity" do
      expect("aaaaaaaa".extend(described_class).strong_password?).to be false
    end

    it "respects custom min_length" do
      expect("Aa1!aa".extend(described_class).strong_password?(min_length: 6)).to be true
    end
  end
end
