module StringMagic
  module Formatting
    module Highlighting
      def highlight(text, phrases, options = {})
        return text if text.nil? || phrases.nil?

        tag = options[:tag] || "mark"
        css_class = options[:class]
        phrases = Array(phrases)

        class_attr = css_class ? %( class="#{css_class}") : ""

        phrases.reduce(text) do |result, phrase|
          result.gsub(/(#{Regexp.escape(phrase)})/i, "<#{tag}#{class_attr}>\\1</#{tag}>")
        end
      end
    end
  end
end
