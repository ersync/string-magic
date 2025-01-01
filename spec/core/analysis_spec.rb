require 'spec_helper'

RSpec.describe StringMagic::Core::Analysis do
  describe '#readability_score' do
    context 'when calculating readability scores' do
      it "returns 0 for an empty string" do
        expect(StringMagic.readability_score("")).to eq(0)
      end

      it "returns 0 for text without proper sentences" do
        expect(StringMagic.readability_score("just words without endings")).to eq(0)
      end

      it "calculates correct Flesch-Kincaid score" do
        text = "This is a simple sentence. Another follows it."
        expect(StringMagic.readability_score(text)).to be_within(0.1).of(3.7)
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
  end

  describe '#extract_entities' do
    context 'when extracting different types of entities' do
      it "raises MalformedInputError for non-string input" do
        expect { StringMagic.extract_entities(123) }.to raise_error(StringMagic::MalformedInputError)
      end

      it "extracts emails from text" do
        text = "Contact us at example@test.com or support@domain.org."
        result = StringMagic.extract_entities(text)
        expect(result[:emails]).to contain_exactly("example@test.com", "support@domain.org")
      end

      context 'URL extraction' do
        it "handles URLs with various protocols" do
          text = "Visit https://example.com http://test.com //cdn.com"
          result = StringMagic.extract_entities(text)
          expect(result[:urls]).to contain_exactly(
            "https://example.com",
            "http://test.com",
            "//cdn.com"
          )
        end
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