module StringMagic
  module Core
    module Transformation
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
