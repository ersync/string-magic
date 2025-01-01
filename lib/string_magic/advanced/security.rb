module StringMagic
  module Advanced
    module Security
      def mask_sensitive_data(text, options = {})
        return text if text.nil? || text.empty?

        mask_char = options[:mask_char] || "*"
        options[:preserve_count] || 4

        patterns = {
          credit_card: /\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b/,
          ssn: /\b\d{3}[-\s]?\d{2}[-\s]?\d{4}\b/,
          email: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b/
        }

        result = text.dup

        patterns.each do |type, pattern|
          result.gsub!(pattern) do |match|
            case type
            when :credit_card
              digits = match.gsub(/[-\s]/, "")
              mask_char * 12 + digits[-4..]
            when :ssn
              digits = match.gsub(/[-\s]/, "")
              mask_char * 5 + digits[-4..]
            when :email
              local, domain = match.split("@")
              "#{mask_char * local.length}@#{domain}"
            end
          end
        end

        result
      end
    end
  end
end
