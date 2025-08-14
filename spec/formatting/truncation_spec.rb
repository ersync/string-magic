require 'spec_helper'

RSpec.describe StringMagic::Formatting::Truncation do
  let(:long_text) { "The quick brown fox jumps over the lazy dog in the forest" }
  let(:paragraph) { "First sentence here. Second sentence follows! Third sentence ends? Fourth one completes." }
  
  describe '#truncate_words' do
    it 'truncates to specified word limit' do
      expect(long_text.truncate_words(3)).to eq('The quick brown...')
      expect('Hello world'.truncate_words(5)).to eq('Hello world')
    end

    it 'accepts custom suffix' do
      expect(long_text.truncate_words(2, suffix: ' [more]')).to eq('The quick [more]')
      expect(long_text.truncate_words(3, suffix: ' etc.')).to eq('The quick brown etc.')
    end

    it 'accepts custom separator' do
      csv_text = 'apple,banana,cherry,date'
      expect(csv_text.truncate_words(2, separator: ',')).to eq('apple,banana...')
    end

    it 'handles edge cases' do
      expect(''.truncate_words(3)).to eq('')
      expect('single'.truncate_words(0)).to eq('...')
      expect('word'.truncate_words(1)).to eq('word')
    end

    it 'preserves original when within limit' do
      expect('short text'.truncate_words(5)).to eq('short text')
    end
  end

  describe '#truncate_sentences' do
    it 'truncates to specified sentence limit' do
      expect(paragraph.truncate_sentences(2)).to eq('First sentence here. Second sentence follows...')
      expect('One sentence.'.truncate_sentences(5)).to eq('One sentence.')
    end

    it 'accepts custom suffix' do
      expect(paragraph.truncate_sentences(1, suffix: ' [continue reading]')).to eq('First sentence here [continue reading]')
    end

    it 'handles various punctuation' do
      mixed = "Question? Exclamation! Period. End"
      expect(mixed.truncate_sentences(2)).to eq('Question? Exclamation...')
    end

    it 'handles edge cases' do
      expect(''.truncate_sentences(2)).to eq('')
      expect('No punctuation'.truncate_sentences(1)).to eq('No punctuation')
    end

    it 'preserves original when within limit' do
      expect('Short. Text.'.truncate_sentences(5)).to eq('Short. Text.')
    end

    it 'does not add suffix when no truncation occurs' do
      short_text = "One sentence."
      expect(short_text.truncate_sentences(2)).to eq(short_text)
    end
  end

  describe '#truncate_characters' do
    it 'truncates to character limit' do
      expect('Hello World'.truncate_characters(8)).to eq('Hello...')
      expect('Short'.truncate_characters(10)).to eq('')
    end

    it 'accepts custom suffix' do
      expect('Hello World'.truncate_characters(8, suffix: '…')).to eq('Hello W…')
    end

    it 'breaks on word boundaries when specified' do
      text = 'Hello beautiful world'
      expect(text.truncate_characters(12, break_on_word: true)).to eq('Hello...')
      expect(text.truncate_characters(12, break_on_word: false)).to eq('Hello bea...')
    end

    it 'allows character breaks by default' do
      expect('Hello World'.truncate_characters(8)).to eq('Hello...')
    end

    it 'handles edge cases' do
      expect(''.truncate_characters(5)).to eq('')
      expect('Hi'.truncate_characters(10)).to eq('')
    end

    it 'strips trailing spaces when breaking on words' do
      text = 'Hello world test'
      result = text.truncate_characters(10, break_on_word: true)
      expect(result).not_to end_with(' ...')
    end
  end

  describe '#smart_truncate' do
    let(:complex_text) { "This is the first sentence. This is a second sentence! And here's a third? Final words here." }
    
    it 'prefers sentence boundaries' do
      result = complex_text.smart_truncate(35)
      expect(result).to eq('This is the first sentence....')
    end

    it 'falls back to word boundaries' do
      text = 'No sentences just words and more words here'
      result = text.smart_truncate(20)
      expect(result).to end_with('...')
      expect(result.length).to be <= 20
    end

    it 'uses hard truncate as last resort' do
      text = 'Supercalifragilisticexpialidocious'
      result = text.smart_truncate(15)
      expect(result.length).to eq(15)
      expect(result).to end_with('...')
    end

    it 'accepts custom suffix' do
      result = complex_text.smart_truncate(35, suffix: ' […]')
      expect(result).to end_with(' […]')
    end

    it 'handles edge cases' do
      expect(''.smart_truncate(10)).to eq('')
      expect('Short'.smart_truncate(20)).to eq('')
    end

    it 'ensures sentence break is reasonable length' do
      text = "A. This is a much longer sentence that goes on and on"
      result = text.smart_truncate(30)
      # Should not break at 'A.' since it's too short (< 50% of limit)
      expect(result).not_to eq('A....')
    end

    it 'ensures word break is reasonable length' do
      text = "A very long string without punctuation marks"
      result = text.smart_truncate(20)
      # Should find a reasonable word break
      expect(result.length).to be <= 20
    end
  end

  describe 'nil_or_empty? edge cases' do
    it 'handles nil strings gracefully' do
      allow_any_instance_of(String).to receive(:nil?).and_return(true)
      expect(''.truncate_words(5)).to eq('')
    end
  end
end