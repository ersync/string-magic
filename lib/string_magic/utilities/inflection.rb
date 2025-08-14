# frozen_string_literal: true

module StringMagic
  module Utilities
    module Inflection
      # ------------------------------------------------------------
      # Plural ↔ singular
      # ------------------------------------------------------------

      def to_plural
        return '' if empty?

        case downcase
        when /(s|sh|ch|x|z)\z/                 then self + 'es'
        when /[^aeiou]y\z/i                    then chop + 'ies'
        when /(f|fe)\z/                        then sub(/(f|fe)\z/, 'ves')
        else                                       self + 's'
        end
      end

      def to_singular
        return '' if empty?

        down = downcase
        if    down.end_with?('ies')           then sub(/ies\z/i, 'y')
        elsif down.end_with?('ves') && length > 3
          sub(/ves\z/i, down[-4] == 'i' ? 'fe' : 'f') # knives → knife, leaves → leaf
        elsif down =~ /(ses|shes|ches|xes|zes)\z/i    then sub(/es\z/i, '')
        elsif down.end_with?('s') && length > 1       then chop
        else                                           self
        end
      end

      # ------------------------------------------------------------
      # Ordinalisation
      # ------------------------------------------------------------
      #
      # '1'.ordinalize  #=> '1st'
      #
      def ordinalize
        return self unless /\A-?\d+\z/.match?(self)

        num = to_i
        suffix = if (11..13).cover?(num % 100)
                   'th'
                 else
                   { 1 => 'st', 2 => 'nd', 3 => 'rd' }.fetch(num % 10, 'th')
                 end
        self + suffix
      end

      # ------------------------------------------------------------
      # Human-readable
      # ------------------------------------------------------------

      def humanize
        return '' if empty?
        gsub('_', ' ')
          .gsub(/([a-z])([A-Z])/, '\1 \2')
          .downcase
          .strip
          .capitalize
      end
    end
  end
end

# Optional auto-mix-in
class String
  include StringMagic::Utilities::Inflection
end