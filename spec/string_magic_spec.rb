# frozen_string_literal: true

RSpec.describe StringMagic do
  describe "core methods" do
    context "#hello_world" do
      it "returns hello world message" do
        expect(StringMagic.hello_world).to eq("hello world!")
      end
    end

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

    context "#capitalize_words" do
      it "capitalizes each word" do
        expect(StringMagic.capitalize_words("hello world")).to eq("Hello World")
      end

      it "handles empty string" do
        expect(StringMagic.capitalize_words("")).to eq("")
      end
    end

    context "#reverse_words" do
      it "reverses word order" do
        expect(StringMagic.reverse_words("hello world")).to eq("world hello")
      end

      it "handles single word" do
        expect(StringMagic.reverse_words("hello")).to eq("hello")
      end
    end

    context "#remove_duplicates" do
      it "removes duplicate characters" do
        expect(StringMagic.remove_duplicates("hello")).to eq("helo")
      end

      it "handles empty string" do
        expect(StringMagic.remove_duplicates("")).to eq("")
      end
    end

    context "#count_vowels" do
      it "counts vowels correctly" do
        expect(StringMagic.count_vowels("hello world")).to eq(3)
      end

      it "handles uppercase vowels" do
        expect(StringMagic.count_vowels("HELLO WORLD")).to eq(3)
      end
    end

    context "#to_pig_latin" do
      it "converts words starting with consonants" do
        expect(StringMagic.to_pig_latin("pig")).to eq("igpay")
      end

      it "converts words starting with vowels" do
        expect(StringMagic.to_pig_latin("egg")).to eq("eggay")
      end

      it "handles multiple words" do
        expect(StringMagic.to_pig_latin("pig egg")).to eq("igpay eggay")
      end
    end

    context "#alternating_case" do
      it "alternates character case" do
        expect(StringMagic.alternating_case("hello")).to eq("HeLlO")
      end

      it "handles empty string" do
        expect(StringMagic.alternating_case("")).to eq("")
      end
    end

    context "#camel_case" do
      it "converts to camel case" do
        expect(StringMagic.camel_case("hello world")).to eq("HelloWorld")
      end

      it "handles empty string" do
        expect(StringMagic.camel_case("")).to eq("")
      end
    end

    context "#snake_case" do
      it "converts to snake case" do
        expect(StringMagic.snake_case("hello world")).to eq("hello_world")
      end

      it "handles multiple spaces" do
        expect(StringMagic.snake_case("hello   world")).to eq("hello_world")
      end
    end

    context "#title_case" do
      it "converts to title case" do
        expect(StringMagic.title_case("hello world")).to eq("Hello World")
      end

      it "handles empty string" do
        expect(StringMagic.title_case("")).to eq("")
      end
    end

    context "#anagram?" do
      it "identifies anagrams" do
        expect(StringMagic.anagram?("listen", "silent")).to be true
        expect(StringMagic.anagram?("hello", "world")).to be false
      end

      it "ignores case and special characters" do
        expect(StringMagic.anagram?("A decimal point", "Im a dot in place")).to be true
      end

      it "handles empty strings" do
        expect(StringMagic.anagram?("", "")).to be true
      end
    end
  end
end
