module StringMagic
  module Core
    module Analysis
      def extract_entities(text)
        raise MalformedInputError, "Input must be a string" unless text.is_a?(String)

        {
          emails: text.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/).uniq,
          urls: text.scan(%r{(?:https?:)?//[^\s/$.?#][^\s,]*}).uniq,
          phone_numbers: text.scan(/(?:\+\d{1,3}\s?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b/).uniq,
          dates: text.scan(%r{\b(?:\d{1,2}[-/]\d{1,2}[-/]\d{2,4}|(?:(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*|(?:January|February|March|April|May|June|July|August|September|October|November|December)) \d{1,2},? \d{4}|\d{4}[-/]\d{1,2}[-/]\d{1,2})\b}i).uniq,
          hashtags: text.scan(/#[[:word:]]+/).map { |tag| tag[1..] }.uniq,
          mentions: text.scan(/@[[:word:]]+/).map { |mention| mention[1..] }.uniq
        }
      end

      def readability_score(text)
        return 0 if text.empty?

        sentences = text.split(/[.!?]+/)
                        .map(&:strip)
                        .reject(&:empty?)

        return 0 if sentences.empty? || !text.match?(/[.!?]/)

        words = text.split(/\s+/)
        return 0 if words.empty?

        syllables = words.sum { |word| calculate_syllables(word) }

        score = (0.39 * (words.length.to_f / sentences.length) +
                11.8 * (syllables.to_f / words.length) - 15.59)

        [score.round(1), 0].max
      end

      private

      def calculate_syllables(word)
        word = word.downcase.gsub(/[^a-z]/, "")
        return 0 if word.empty?

        count = word.scan(/[aeiou]+/i).size
        count -= 1 if word.end_with?("e")
        [count, 1].max
      end
    end
  end
end
