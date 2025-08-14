# frozen_string_literal: true

module StringMagic
  module Core
    module Analysis
      # ------------------------------------------------------------------
      # Entity extraction
      # ------------------------------------------------------------------

      def extract_entities
        return default_entities_hash if empty?

        {
          emails:        extract_emails,
          urls:          extract_urls,
          phone_numbers: extract_phones,
          dates:         extract_dates,
          hashtags:      extract_hashtags,
          mentions:      extract_mentions
        }
      end

      def extract_emails
        return [] if empty?
        scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/).uniq
      end

      def extract_urls
        return [] if empty?
        
        # initial capture
        urls = scan(%r{https?://[^\s<>"']+|www\.[^\s<>"']+})
        
        # strip trailing punctuation like . , ; : ! ? )
        urls.map { |u| u.gsub(/[\.,;:!?)+]+\z/, '') }.uniq
      end

      def extract_phones
        return [] if empty?
        phone_re = /(?:\+\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}(?!\d)/
        scan(phone_re).uniq
      end

      def extract_dates
        return [] if empty?

        patterns = [
          %r{\b\d{1,2}[-/]\d{1,2}[-/]\d{2,4}\b},   # 01/31/2025  or 31-01-25
          %r{\b\d{4}[-/]\d{1,2}[-/]\d{1,2}\b},     # 2025-01-31
          /\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\.?\s+\d{1,2},?\s+\d{4}\b/i,
          /\b\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\.?\s+\d{4}\b/i
        ]

        patterns.flat_map { |re| scan(re) }.uniq
      end

      def extract_hashtags
        return [] if empty?
        scan(/#(\w+)/).flatten.uniq
      end

      def extract_mentions
        return [] if empty?
        scan(/(?:^|\s)@([A-Za-z0-9_]+)/).flatten.uniq
      end

      # ------------------------------------------------------------------
      # Text statistics
      # ------------------------------------------------------------------

      def readability_score
        return 0.0 if empty?

        sentences = split(/[.!?]+/).map(&:strip).reject(&:empty?)
        return 0.0 if sentences.empty?

        words = scan(/\b[\p{L}\p{N}'-]+\b/)
        return 0.0 if words.empty?

        syllables = words.sum { |w| calculate_syllables(w) }
        return 0.0 if syllables.zero?

        score = 0.39 * (words.size.to_f / sentences.size) +
                11.8 * (syllables.to_f / words.size) - 15.59

        score.round(1).clamp(0, Float::INFINITY)
      end

      def word_frequency
        return {} if empty?
        downcase.scan(/\b[\p{L}\p{N}'-]+\b/).tally
      end

      def sentiment_indicators
        return { positive: 0, negative: 0, neutral: 1 } if empty?

        positive_words = %w[good great excellent amazing wonderful fantastic happy joy love like best awesome]
        negative_words = %w[bad terrible awful horrible sad hate dislike worst annoying frustrating]

        words = downcase.scan(/\b[\p{L}\p{N}'-]+\b/)
        pos   = words.count { |w| positive_words.include?(w) }
        neg   = words.count { |w| negative_words.include?(w) }
        total = pos + neg

        if total.zero?
          { positive: 0, negative: 0, neutral: 1 }
        else
          { positive: (pos.to_f / total).round(2),
            negative: (neg.to_f / total).round(2),
            neutral: 0 }
        end
      end

      # ------------------------------------------------------------------
      # Private helpers
      # ------------------------------------------------------------------
      private

      def default_entities_hash
        { emails: [], urls: [], phone_numbers: [], dates: [], hashtags: [], mentions: [] }
      end

      # Rough syllable estimator (en-US)
      def calculate_syllables(word)
        w = word.downcase.gsub(/[^a-z]/, '')
        return 1 if w.length <= 2

        count = w.scan(/[aeiouy]+/).size
        count -= 1 if w.end_with?('e') && count > 1
        count += 1 if w.end_with?('le') && w[-3] !~ /[aeiouy]/i
        [count, 1].max
      end
    end
  end
end

# Optional auto-mix-in
class String
  include StringMagic::Core::Analysis
end