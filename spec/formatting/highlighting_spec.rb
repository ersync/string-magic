require "spec_helper"

RSpec.describe StringMagic::Formatting::Highlighting do
  describe ".highlight" do
    it "highlights single phrase with default tag" do
      text = "Hello world"
      expect(StringMagic.highlight(text, "world")).to eq("Hello <mark>world</mark>")
    end

    it "highlights multiple phrases" do
      text = "Hello world, beautiful world"
      expect(StringMagic.highlight(text, %w[world beautiful]))
        .to eq("Hello <mark>world</mark>, <mark>beautiful</mark> <mark>world</mark>")
    end

    it "handles custom tag" do
      text = "Hello world"
      expect(StringMagic.highlight(text, "world", tag: "span"))
        .to eq("Hello <span>world</span>")
    end

    it "handles custom CSS class" do
      text = "Hello world"
      expect(StringMagic.highlight(text, "world", class: "highlight"))
        .to eq('Hello <mark class="highlight">world</mark>')
    end

    it "is case insensitive" do
      text = "Hello WORLD"
      expect(StringMagic.highlight(text, "world"))
        .to eq("Hello <mark>WORLD</mark>")
    end

    it "handles nil text" do
      expect(StringMagic.highlight(nil, "world")).to be_nil
    end

    it "handles nil phrases" do
      expect(StringMagic.highlight("Hello world", nil)).to eq("Hello world")
    end

    it "handles empty phrases array" do
      expect(StringMagic.highlight("Hello world", [])).to eq("Hello world")
    end

    it "handles both custom tag and class" do
      text = "Hello world"
      expect(StringMagic.highlight(text, "world", tag: "span", class: "highlight"))
        .to eq('Hello <span class="highlight">world</span>')
    end
  end
end
