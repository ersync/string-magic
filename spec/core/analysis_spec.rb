# spec/string_magic/core/analysis_spec.rb
require 'spec_helper'

RSpec.describe StringMagic::Core::Analysis do
  let(:sample_text) { "Contact John at john@example.com, visit https://example.com or call 555-123-4567. Meeting on 12/25/2023! #ruby @johndoe" }

  describe '#extract_entities' do
    it 'extracts all entity types' do
      result = sample_text.extract_entities
      
      expect(result[:emails]).to include('john@example.com')
      expect(result[:urls]).to include('https://example.com')
      expect(result[:phone_numbers]).to include('555-123-4567')
      expect(result[:dates]).to include('12/25/2023')
      expect(result[:hashtags]).to include('ruby')
      expect(result[:mentions]).to include('johndoe')
    end

    it 'returns empty arrays for empty string' do
      result = ''.extract_entities
      expect(result).to eq({
        emails: [], urls: [], phone_numbers: [],
        dates: [], hashtags: [], mentions: []
      })
    end
  end

  describe '#extract_emails' do
    it 'extracts various email formats' do
      text = "Emails: user@domain.com, first.last@company.co.uk, user+tag@example.org"
      emails = text.extract_emails
      
      expect(emails).to contain_exactly('user@domain.com', 'first.last@company.co.uk', 'user+tag@example.org')
    end

    it 'returns unique emails only' do
      text = "Same email: test@example.com and test@example.com again"
      expect(text.extract_emails).to eq(['test@example.com'])
    end
  end

  describe '#extract_urls' do
    it 'extracts HTTP and HTTPS URLs' do
      text = "Visit https://example.com and http://test.org"
      expect(text.extract_urls).to contain_exactly('https://example.com', 'http://test.org')
    end

    it 'extracts www URLs without protocol' do
      text = "Check www.example.com for more info"
      expect(text.extract_urls).to include('www.example.com')
    end
  end

  describe '#extract_phones' do
    it 'extracts various phone formats' do
      text = "Numbers: 555-123-4567, (555) 987-6543, +1-555-111-2222"
      phones = text.extract_phones
      
      expect(phones).to include('555-123-4567', '(555) 987-6543', '+1-555-111-2222')
    end
  end

  describe '#extract_dates' do
    it 'extracts different date formats' do
      text = "Dates: 12/25/2023, 2023-01-15, Jan 1, 2024, 15 March 2023"
      dates = text.extract_dates
      
      expect(dates.length).to be >= 3
      expect(dates).to include('12/25/2023')
    end
  end

  describe '#extract_hashtags' do
    it 'extracts hashtags without the # symbol' do
      text = "Love #ruby and #programming #coding"
      expect(text.extract_hashtags).to contain_exactly('ruby', 'programming', 'coding')
    end
  end

  describe '#extract_mentions' do
    it 'extracts mentions without the @ symbol' do
      text = "Hi @alice and @bob, thanks @charlie"
      expect(text.extract_mentions).to contain_exactly('alice', 'bob', 'charlie')
    end
  end

  describe '#readability_score' do
    it 'calculates Flesch-Kincaid score for simple text' do
      simple_text = "This is simple. Easy to read."
      score = simple_text.readability_score
      expect(score).to be_a(Numeric) 
      expect(score).to be >= 0
    end

    it 'returns 0 for empty string' do
      expect(''.readability_score).to eq(0)
    end

    it 'handles complex sentences' do
      complex_text = "The implementation of sophisticated algorithms requires comprehensive understanding of computational complexity."
      score = complex_text.readability_score
      expect(score).to be_a(Numeric)
      expect(score).to be > 5 
    end

    it 'handles single word' do
      score = "Hello.".readability_score
      expect(score).to be_a(Numeric)
      expect(score).to be >= 0
    end

    it 'calculates score for known text structure' do
      text = "The quick brown fox jumps over the lazy dog. This sentence contains multiple syllables and complexity."
      score = text.readability_score
      expect(score).to be_a(Numeric)
      expect(score).to be >= 0 
    end
  end

  describe '#word_frequency' do
    it 'counts word frequencies' do
      text = "hello world hello ruby world hello"
      freq = text.word_frequency
      
      expect(freq['hello']).to eq(3)
      expect(freq['world']).to eq(2)
      expect(freq['ruby']).to eq(1)
    end

    it 'handles punctuation and case' do
      text = "Hello, World! Hello world."
      freq = text.word_frequency
      expect(freq['hello']).to eq(2)
      expect(freq['world']).to eq(2)
    end
  end

  describe '#sentiment_indicators' do
    it 'detects positive sentiment' do
      positive_text = "This is great! I love it. Amazing work!"
      sentiment = positive_text.sentiment_indicators
      
      expect(sentiment[:positive]).to be > sentiment[:negative]
      expect(sentiment[:neutral]).to eq(0)
    end

    it 'detects negative sentiment' do
      negative_text = "This is terrible. I hate it. Awful experience."
      sentiment = negative_text.sentiment_indicators
      
      expect(sentiment[:negative]).to be > sentiment[:positive]
    end

    it 'returns neutral for text without sentiment words' do
      neutral_text = "The weather is cloudy today."
      sentiment = neutral_text.sentiment_indicators
      
      expect(sentiment[:neutral]).to eq(1)
      expect(sentiment[:positive]).to eq(0)
      expect(sentiment[:negative]).to eq(0)
    end
  end

  describe 'private methods' do
    describe '#calculate_syllables' do
      let(:test_instance) { Class.new { include StringMagic::Core::Analysis }.new }
      
      it 'counts syllables correctly' do
        expect(test_instance.send(:calculate_syllables, 'hello')).to eq(2)
        expect(test_instance.send(:calculate_syllables, 'world')).to eq(1)
        expect(test_instance.send(:calculate_syllables, 'beautiful')).to eq(3)
        expect(test_instance.send(:calculate_syllables, 'a')).to eq(1)
      end
    end
  end
end