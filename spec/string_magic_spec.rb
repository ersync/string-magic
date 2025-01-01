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

    context "#readability_score" do
      it "returns 0 for an empty string" do
        expect(StringMagic.readability_score("")).to eq(0)
      end

      it "returns the correct readability score for simple text" do
        text = "The quick brown fox jumps over the lazy dog."
        expect(StringMagic.readability_score(text)).to be > 0
      end

      it "returns the correct readability score for complex text" do
        text = "In an era of uncertainty, people seek clarity through well-informed decisions."
        expect(StringMagic.readability_score(text)).to be > 0
      end
    end

    context "#extract_entities" do
      it "raises MalformedInputError for non-string input" do
        expect { StringMagic.extract_entities(123) }.to raise_error(StringMagic::MalformedInputError)
      end

      it "extracts emails from text" do
        text = "Contact us at example@test.com or support@domain.org."
        result = StringMagic.extract_entities(text)
        expect(result[:emails]).to contain_exactly("example@test.com", "support@domain.org")
      end

      it "extracts URLs from text" do
        text = "Visit https://example.com and http://test.org for more info."
        result = StringMagic.extract_entities(text)
        expect(result[:urls]).to contain_exactly("https://example.com", "http://test.org")
      end

      it "extracts phone numbers from text" do
        text = "Call us at +1 (123) 456-7890 or 987-654-3210."
        result = StringMagic.extract_entities(text)
        expect(result[:phone_numbers]).to contain_exactly("+1 (123) 456-7890", "987-654-3210")
      end

      it "extracts dates from text" do
        text = "Important dates: 2023-10-01, Oct 1, 2023, and 01/10/2023."
        result = StringMagic.extract_entities(text)
        expect(result[:dates]).to contain_exactly("2023-10-01", "Oct 1, 2023", "01/10/2023")
      end

      it "extracts hashtags from text" do
        text = "Follow #Ruby, #RSpec, and #TDD for updates."
        result = StringMagic.extract_entities(text)
        expect(result[:hashtags]).to contain_exactly("Ruby", "RSpec", "TDD")
      end

      it "extracts mentions from text" do
        text = "Reach out to @user1 and @user2 for details."
        result = StringMagic.extract_entities(text)
        expect(result[:mentions]).to contain_exactly("user1", "user2")
      end
    end
  end
end
