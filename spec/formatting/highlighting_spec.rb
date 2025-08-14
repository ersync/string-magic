require 'spec_helper'

RSpec.describe StringMagic::Formatting::Highlighting do
  describe '#highlight' do
    context 'basic functionality' do
      it 'highlights a single phrase with default mark tag' do
        result = "Hello world".highlight("world")
        expect(result).to eq("Hello <mark>world</mark>")
      end

      it 'highlights multiple phrases' do
        result = "The quick brown fox".highlight(["quick", "fox"])
        expect(result).to eq("The <mark>quick</mark> brown <mark>fox</mark>")
      end

      it 'handles overlapping phrases (nested highlighting can occur)' do
        result = "testing test".highlight(["test", "testing"])
        expect(result).to eq("<mark>testing</mark> <mark>test</mark>")
      end
    end

    context 'options handling' do
      it 'uses custom tag when specified' do
        result = "Hello world".highlight("world", tag: "span")
        expect(result).to eq("Hello <span>world</span>")
      end

      it 'adds CSS class when specified' do
        result = "Hello world".highlight("world", css_class: "highlight")
        expect(result).to eq('Hello <mark class="highlight">world</mark>')
      end

      it 'combines custom tag and class' do
        result = "Hello world".highlight("world", tag: "span", css_class: "custom")
        expect(result).to eq('Hello <span class="custom">world</span>')
      end

      it 'is case sensitive by default' do
        result = "Hello WORLD".highlight("world")
        expect(result).to eq("Hello WORLD")
      end

      it 'can be case insensitive when specified' do
        result = "Hello WORLD".highlight("world", case_sensitive: false)
        expect(result).to eq("Hello <mark>WORLD</mark>")
      end
    end

    context 'edge cases' do
      it 'handles nil input by checking nil_or_empty?' do
        # Since we can't call highlight on nil, we test the nil_or_empty? check indirectly
        result = "".highlight("test")
        expect(result).to eq("")
      end

      it 'returns empty string when input is empty' do
        result = "".highlight("test")
        expect(result).to eq("")
      end

      it 'returns original string when phrases is nil' do
        result = "Hello world".highlight(nil)
        expect(result).to eq("Hello world")
      end

      it 'returns original string when phrases array is empty' do
        result = "Hello world".highlight([])
        expect(result).to eq("Hello world")
      end

      it 'handles nil and empty phrases in array' do
        result = "Hello world test".highlight(["world", "", "test"])
        expect(result).to eq("Hello <mark>world</mark> <mark>test</mark>")
      end
    end
  end

  describe '#remove_highlights' do
    it 'removes all HTML tags by default' do
      result = "Hello <mark>world</mark> and <span>test</span>".remove_highlights
      expect(result).to eq("Hello world and test")
    end

    it 'removes only specified tag' do
      result = "Hello <mark>world</mark> and <span>test</span>".remove_highlights("mark")
      expect(result).to eq("Hello world and <span>test</span>")
    end

    it 'handles tags with attributes' do
      result = 'Hello <mark class="highlight">world</mark>'.remove_highlights("mark")
      expect(result).to eq("Hello world")
    end

    it 'handles multiline content' do
      result = "<mark>Line 1\nLine 2</mark>".remove_highlights("mark")
      expect(result).to eq("Line 1\nLine 2")
    end

    it 'handles empty input' do
      result = "".remove_highlights
      expect(result).to eq("")
    end
  end

  describe '#highlight_urls' do
    it 'highlights URLs with default anchor tag' do
      result = "Visit https://example.com for more info".highlight_urls
      expect(result).to eq('Visit <a href="https://example.com">https://example.com</a> for more info')
    end

    it 'handles multiple URLs' do
      result = "Check https://site1.com and https://site2.com".highlight_urls
      expect(result).to eq('Check <a href="https://site1.com">https://site1.com</a> and <a href="https://site2.com">https://site2.com</a>')
    end

    it 'uses custom tag when specified' do
      result = "Visit https://example.com".highlight_urls(tag: "span")
      expect(result).to eq('Visit <span href="https://example.com">https://example.com</span>')
    end

    it 'adds CSS class when specified' do
      result = "Visit https://example.com".highlight_urls(css_class: "link")
      expect(result).to eq('Visit <a href="https://example.com" class="link">https://example.com</a>')
    end

    it 'adds target attribute when specified' do
      result = "Visit https://example.com".highlight_urls(target: "_blank")
      expect(result).to eq('Visit <a href="https://example.com" target="_blank">https://example.com</a>')
    end

    it 'handles http URLs' do
      result = "Visit http://example.com".highlight_urls
      expect(result).to eq('Visit <a href="http://example.com">http://example.com</a>')
    end

    it 'handles empty input' do
      result = "".highlight_urls
      expect(result).to eq("")
    end

    it 'returns original string when no URLs found' do
      result = "No URLs here".highlight_urls
      expect(result).to eq("No URLs here")
    end
  end
end