module StringMagic
  module Core
    module Transformation
      def titleize_names(text)
        return text if text.nil? || text.empty?

        special_cases = {
          "mcdonald" => "McDonald",
          "o'reilly" => "O'Reilly",
          "macbook" => "MacBook",
          "iphone" => "iPhone",
          "ipad" => "iPad",
          "ebay" => "eBay"
        }

        prefixes = Set.new(%w[van de la du das dos di da delle degli delle])
        articles = Set.new(%w[a an the]) # Add this line

        words = text.downcase.split(/\s+/)
        words.map.with_index do |word, index|
          if special_cases.key?(word)
            special_cases[word]
          elsif prefixes.include?(word) && !index.zero?
            word
          elsif articles.include?(word) && !index.zero? # Add this condition
            word.downcase
          else
            word.capitalize
          end
        end.join(" ")
      end

      def to_snake_case(string)
        return "" if string.nil?

        string.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
              .tr("-", "_")
              .downcase
      end

      def to_kebab_case(string)
        to_snake_case(string).tr("_", "-")
      end

      def to_pascal_case(string)
        return "" if string.nil?
        return string if string.match?(/^[A-Z][a-z]*([A-Z][a-z]*)*$/)

        string.split(/[-_\s]+/).map(&:capitalize).join
      end
    end
  end
end
