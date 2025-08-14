# frozen_string_literal: true

require 'uri'

module StringMagic
  module Core
    module Validation
      # ------------------------------------------------------------
      # Basic format checks
      # ------------------------------------------------------------

      def email?
        !!(self =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      end

      def url?
        !!(self =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/)
      end

      def phone?
        digits = gsub(/\D/, '')
        (10..15).cover?(digits.length)
      end

      # ------------------------------------------------------------
      # Credit-card number (Luhn)
      # ------------------------------------------------------------

      def credit_card?
        digits = gsub(/\D/, '')
        return false unless (13..19).cover?(digits.length)

        sum = digits.reverse.chars.each_with_index.sum do |ch, idx|
          n = ch.to_i
          n *= 2 if idx.odd?
          n > 9 ? n - 9 : n
        end
        (sum % 10).zero?
      end

      # ------------------------------------------------------------
      # Text relationships
      # ------------------------------------------------------------

      def palindrome?
        cleaned = downcase.gsub(/[^a-z0-9]/, '')
        cleaned == cleaned.reverse && !cleaned.empty?
      end

      def anagram_of?(other)
        return false if other.nil? || other.empty?

        norm = ->(s) { s.downcase.gsub(/[^a-z0-9]/, '').chars.sort.join }
        !empty? && norm.call(self) == norm.call(other)
      end

      # ------------------------------------------------------------
      # Number checks
      # ------------------------------------------------------------

      def numeric?
        !!(self =~ /\A-?(?:\d+\.?\d*|\.\d+)\z/)
      end

      def integer?
        !!(self =~ /\A-?\d+\z/)
      end

      # ------------------------------------------------------------
      # Password strength
      # ------------------------------------------------------------

      def strong_password?(min_length: 8)
        return false if length < min_length

        /[A-Z]/.match?(self) &&
          /[a-z]/.match?(self) &&
          /\d/.match?(self) &&
          /[^A-Za-z0-9]/.match?(self)
      end
    end
  end
end

# Optional auto-mix-in
class String
  include StringMagic::Core::Validation
end