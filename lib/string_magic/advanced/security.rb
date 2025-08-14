# frozen_string_literal: true

module StringMagic
  module Advanced
    module Security
      # ------------------------------------------------------------
      # Public API
      # ------------------------------------------------------------

      # Detects and masks sensitive data in the string.
      #
      # options:
      #   :mask_char      → character to use for masking   (default '*')
      #   :preserve_count → trailing digits to leave clear (default 4)
      #   :types          → array of types to mask         (default [:credit_card, :ssn, :email, :phone])
      #
      def mask_sensitive_data(options = {})
        return '' if empty?

        mask_char      = options.fetch(:mask_char, '*')
        preserve_count = options.fetch(:preserve_count, 4)
        types          = options.fetch(:types, %i[credit_card ssn email phone])

        patterns = {
          credit_card: /\b(?:\d{4}[-\s]?){3}\d{4}\b/,
          ssn:         /\b\d{3}[-\s]?\d{2}[-\s]?\d{4}\b/,
          email:       /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/,
          phone:       /(?:\+\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}(?!\d)/
        }

        result = dup
        types.each do |type|
          next unless patterns[type]

          result.gsub!(patterns[type]) do |match|
            case type
            when :credit_card then mask_credit_card(match, mask_char, preserve_count)
            when :ssn         then mask_ssn(match, mask_char, preserve_count)
            when :email       then mask_email(match, mask_char)
            when :phone       then mask_phone(match, mask_char, preserve_count)
            end
          end
        end
        result
      end

      # Convenience wrappers
      def mask_credit_cards(mask_char: '*', preserve_count: 4)
        mask_sensitive_data(types: [:credit_card], mask_char: mask_char, preserve_count: preserve_count)
      end

      def mask_emails(mask_char: '*')
        mask_sensitive_data(types: [:email], mask_char: mask_char)
      end

      def mask_phones(mask_char: '*', preserve_count: 4)
        mask_sensitive_data(types: [:phone], mask_char: mask_char, preserve_count: preserve_count)
      end

      def contains_sensitive_data?
        return false if empty?

        [
          /\b(?:\d{4}[-\s]?){3}\d{4}\b/,                 # Credit card
          /\b\d{3}[-\s]?\d{2}[-\s]?\d{4}\b/,             # SSN
          /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/ # Email
        ].any? { |re| match?(re) }
      end

      # ------------------------------------------------------------
      # Private helpers
      # ------------------------------------------------------------
      private

      # Mask a phone number while preserving formatting characters and last n digits.
      def mask_phone(original, mask_char, preserve_count)
        digits_only      = original.gsub(/\D/, '')
        return original if digits_only.length <= preserve_count

        masked_part      = mask_char * (digits_only.length - preserve_count)
        preserved_part   = digits_only[-preserve_count..]
        replacement_pool = (masked_part + preserved_part).chars
        index            = 0

        original.gsub(/\d/) { replacement_pool[index].tap { index += 1 } }
      end

      def mask_credit_card(original, mask_char, preserve_count)
        digits = original.gsub(/\D/, '')
        masked_len = [digits.length - preserve_count, 0].max
        mask_char * masked_len + digits[-preserve_count..]
      end

      def mask_ssn(original, mask_char, preserve_count)
        mask_credit_card(original, mask_char, preserve_count)
      end

      # Email masking policy:
      # - If local part length <= 4 → keep first char, then 8 mask chars (e.g. "mail" => "m********")
      # - Else → keep first char, mask the remainder (no last-char preservation)
      def mask_email(original, mask_char)
        local, domain = original.split('@', 2)
        if local.length <= 4
          masked_local = local[0] + (mask_char * 8)
        else
          masked_local = local[0] + (mask_char * (local.length - 1))
        end
        "#{masked_local}@#{domain}"
      end
    end
  end
end

# Optional automatic mix-in
class String
  include StringMagic::Advanced::Security
end