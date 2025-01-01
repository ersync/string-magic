require_relative "../spec_helper"

RSpec.describe StringMagic::Formatting::Truncation do
  describe ".truncate_words" do
    it "truncates text to specified word count" do
      text = "The quick brown fox jumps over the lazy dog"
      expect(StringMagic.truncate_words(text, 4)).to eq("The quick brown fox...")
    end

    it "returns original text if word count is sufficient" do
      text = "The quick brown"
      expect(StringMagic.truncate_words(text, 3)).to eq(text)
    end

    it "uses custom suffix" do
      text = "The quick brown fox jumps"
      expect(StringMagic.truncate_words(text, 2, suffix: " [...]"))
        .to eq("The quick [...]")
    end

    it "handles nil text" do
      expect(StringMagic.truncate_words(nil, 5)).to be_nil
    end

    it "handles nil count" do
      expect(StringMagic.truncate_words("text", nil)).to eq("text")
    end

    it "handles zero count" do
      expect(StringMagic.truncate_words("text", 0)).to eq("text")
    end

    it "handles negative count" do
      expect(StringMagic.truncate_words("text", -1)).to eq("text")
    end
  end

  describe ".truncate_sentences" do
    it "truncates text to specified sentence count" do
      text = "First sentence. Second sentence! Third sentence? Fourth sentence."
      expect(StringMagic.truncate_sentences(text, 2))
        .to eq("First sentence. Second sentence!...")
    end

    it "returns original text if sentence count is sufficient" do
      text = "First sentence. Second sentence."
      expect(StringMagic.truncate_sentences(text, 2)).to eq(text)
    end

    it "uses custom suffix" do
      text = "First sentence. Second sentence. Third sentence."
      expect(StringMagic.truncate_sentences(text, 1, suffix: " [MORE]"))
        .to eq("First sentence. [MORE]")
    end

    it "handles different sentence endings" do
      text = "Hello! How are you? I am fine."
      expect(StringMagic.truncate_sentences(text, 2))
        .to eq("Hello! How are you?...")
    end

    it "handles nil text" do
      expect(StringMagic.truncate_sentences(nil, 5)).to be_nil
    end

    it "handles nil count" do
      expect(StringMagic.truncate_sentences("text.", nil)).to eq("text.")
    end

    it "handles zero count" do
      expect(StringMagic.truncate_sentences("text.", 0)).to eq("text.")
    end

    it "handles negative count" do
      expect(StringMagic.truncate_sentences("text.", -1)).to eq("text.")
    end
  end
end
