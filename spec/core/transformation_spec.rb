# spec/string_magic/core/transformation_spec.rb
require 'spec_helper'

RSpec.describe StringMagic::Core::Transformation do
  describe '#to_snake_case' do
    it 'converts camelCase to snake_case' do
      expect('camelCase'.to_snake_case).to eq('camel_case')
    end

    it 'handles empty string' do
      expect(''.to_snake_case).to eq('')
    end
  end

  describe '#to_kebab_case' do
    it 'converts to kebab-case' do
      expect('camelCase'.to_kebab_case).to eq('camel-case')
    end
  end

  describe '#to_title_case' do
    it 'keeps small words lowercase except at start/end' do
      expect('the lord of the rings'.to_title_case).to eq('The Lord of the Rings')
    end
  end

  describe '#squeeze_whitespace' do
    it 'collapses multiple spaces' do
      expect('hello    world   ruby'.squeeze_whitespace).to eq('hello world ruby')
    end
  end

  describe '#escape_html' do
    it 'escapes HTML entities' do
      expect('&<>"\''.escape_html).to eq('&amp;&lt;&gt;&quot;&#39;')
    end
  end
end