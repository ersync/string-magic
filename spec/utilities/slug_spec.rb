# spec/string_magic/utilities/slug_spec.rb
require 'spec_helper'

RSpec.describe StringMagic::Utilities::Slug do
  describe '#to_slug' do
    it 'creates basic slugs' do
      expect('Hello World'.to_slug).to eq('hello-world')
      expect('Ruby & Rails'.to_slug).to eq('ruby-rails')
    end

    it 'handles accented characters' do
      expect('Café Niño'.to_slug).to eq('cafe-nino')
      expect('Résumé'.to_slug).to eq('resume')
    end

    it 'accepts custom separator' do
      expect('hello world'.to_slug(separator: '_')).to eq('hello_world')
    end

    it 'preserves case when requested' do
      expect('Hello World'.to_slug(preserve_case: true)).to eq('Hello-World')
    end

    it 'removes HTML tags' do
      expect('<p>Hello World</p>'.to_slug).to eq('hello-world')
    end
  end

  describe '#to_url_slug' do
    it 'creates URL-friendly slugs' do
      expect('Hello World!'.to_url_slug).to eq('hello-world')
    end
  end

  describe '#to_filename_safe' do
    it 'replaces invalid filename characters' do
      expect('file<name>'.to_filename_safe).to eq('file_name')
      expect('con/cat|file'.to_filename_safe).to eq('con_cat_file')
    end

    it 'handles reserved filenames' do
      expect('CON'.to_filename_safe).to eq('con_file')
      expect('PRN'.to_filename_safe).to eq('prn_file')
    end

    it 'returns untitled for empty results' do
      expect('<<<>>>'.to_filename_safe).to eq('untitled')
    end
  end

  describe '#slugify_path' do
    it 'slugifies each path segment' do
      expect('Hello World/Test Path'.slugify_path).to eq('hello-world/test-path')
    end

    it 'removes empty segments' do
      expect('hello//world/'.slugify_path).to eq('hello/world')
    end
  end

  describe '#extract_slug_from_url' do
    it 'extracts slug from URL' do
      expect('https://example.com/hello-world'.extract_slug_from_url).to eq('hello-world')
      expect('/posts/my-blog-post.html'.extract_slug_from_url).to eq('my-blog-post')
    end

    it 'handles query parameters' do
      expect('/posts/my-slug?id=123#section'.extract_slug_from_url).to eq('my-slug')
    end

    it 'returns empty for invalid input' do
      expect(''.extract_slug_from_url).to eq('')
    end
  end
end