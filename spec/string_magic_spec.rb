# frozen_string_literal: true

RSpec.describe StringMagic do
  it "has a version number" do
    expect(StringMagic::VERSION).not_to be nil
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end
  describe "methods" do
    context "#word_count" do
      it "returns the correct number of words in a string" do
        expect(StringMagic.word_count("Hello, World!")).to eq(2)
      end
      it "returns the correct number of words for an empty string" do
        expect(StringMagic.word_count("")).to eq(0)
      end
    end
  end

end
