# frozen_string_literal: true

module StringMagic
  module Formatting
    module Truncation
      # ------------------------------------------------------------
      # Word-based
      # ------------------------------------------------------------
      def truncate_words(limit, suffix: '...', separator: ' ')
        return '' if empty?
        words = split(separator)
        return self if words.size <= limit
        words.first(limit).join(separator) + suffix
      end

      # ------------------------------------------------------------
      # Sentence-based
      # ------------------------------------------------------------
      def truncate_sentences(limit, suffix: '...')
        return '' if empty?
        sentences = split(/(?<=[.!?])\s+/)
        return self if sentences.size <= limit
        result = sentences.first(limit).join(' ')
        result.chomp!('.')
        result.chomp!('!')
        result.chomp!('?')
        result += suffix unless result == self
      end

      # ------------------------------------------------------------
      # Character-based
      # ------------------------------------------------------------
      #
      # break_on_word: true  → keep whole words
      # break_on_word: false → may cut mid-word (default)
      #
      def truncate_characters(limit, suffix: '...', break_on_word: false)
        return '' if empty? || length <= limit
        
        # When break_on_word is true, we want the result to be exactly `limit` chars total
        target_content_len = limit - suffix.length
        return suffix[0, limit] if target_content_len <= 0

        if break_on_word
          cut = rindex(' ', target_content_len) || target_content_len
          self[0, cut].rstrip + suffix
        else
          self[0, target_content_len] + suffix
        end
      end

      # ------------------------------------------------------------
      # "Smart" truncate: sentence ▸ word ▸ hard cut
      # ------------------------------------------------------------
      def smart_truncate(limit, suffix: '...')
        return '' if empty? || length <= limit
        hard_len = limit - suffix.length
        return suffix[0, limit] if hard_len.negative?

        # Try sentence boundary
        sent_break = rindex(/[.!?]\s/, hard_len)
        return self[0..sent_break].rstrip + suffix if sent_break && sent_break > limit * 0.5

        # Try word boundary
        word_break = rindex(' ', hard_len)
        return self[0, word_break].rstrip + suffix if word_break && word_break > limit * 0.3

        # Fallback
        self[0, hard_len] + suffix
      end
    end
  end
end

# Optional auto-mix-in
class String
  include StringMagic::Formatting::Truncation
end