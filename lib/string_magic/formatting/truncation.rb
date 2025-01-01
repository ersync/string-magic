module StringMagic
  module Formatting
    module Truncation
      def truncate_words(text, count, options = {})
        return text if text.nil? || count.nil? || count < 1

        suffix = options[:suffix] || "..."
        words = text.split(/\s+/)
        return text if words.length <= count

        words[0...count].join(" ") + suffix
      end

      def truncate_sentences(text, count, options = {})
        return text if text.nil? || count.nil? || count < 1

        suffix = options[:suffix] || "..."
        sentences = text.split(/(?<=[.!?])\s+/)
        return text if sentences.length <= count

        sentences[0...count].join(" ") + suffix
      end
    end
  end
end
