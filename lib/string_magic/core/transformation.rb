# frozen_string_literal: true

require 'cgi' # for HTML escaping

module StringMagic
  module Core
    module Transformation
      # ------------------------------------------------------------
      # Case conversions
      # ------------------------------------------------------------

      def to_snake_case
        return '' if empty?

        str = dup
        str.gsub!(/::/, '/')
        str.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        str.gsub!(/([a-z\d])([A-Z])/,  '\1_\2')
        str.tr!('-', '_')
        str.gsub!(/\s+/, '_')
        str.downcase!
        str.squeeze('_').gsub(/^_+|_+$/, '')
      end

      def to_kebab_case
        to_snake_case.tr('_', '-')
      end

      # first_letter: :lower (default) or :upper
      def to_camel_case(first_letter: :lower)
        return '' if empty?

        words = to_snake_case.split('_').map(&:capitalize)
        words[0].downcase! if first_letter == :lower && words.any?
        words.join
      end

      def to_pascal_case
        to_camel_case(first_letter: :upper)
      end

      def to_title_case
        return '' if empty?

        small = %w[a an and as at but by for if in nor of on or so the to up yet]
        words = downcase.split(/\s+/)
        words.map!.with_index do |w, i|
          (i.zero? || i == words.size - 1 || !small.include?(w)) ? w.capitalize : w
        end
        words.join(' ')
      end

      # ------------------------------------------------------------
      # Simple word / char utilities
      # ------------------------------------------------------------

      def reverse_words
        return '' if empty?
        split(/\s+/).reverse.join(' ')
      end

      def alternating_case
        return '' if empty?
        each_char.with_index.map { |c, i| i.even? ? c.upcase : c.downcase }.join
      end

      def remove_duplicate_chars
        return '' if empty?
        each_char.to_a.uniq.join
      end

      def remove_duplicate_words
        return '' if empty?
        split(/\s+/).uniq.join(' ')
      end

      # ------------------------------------------------------------
      # Misc. text transformations
      # ------------------------------------------------------------

      def squeeze_whitespace
        return '' if empty?
        gsub(/\s+/, ' ').strip
      end

      def remove_html_tags
        return '' if empty?
        gsub(/<[^>]*>/, '')
      end

      def escape_html
        return '' if empty?
        CGI.escapeHTML(self)
      end
    end
  end
end

# Optional automatic mix-in
class String
  include StringMagic::Core::Transformation
end