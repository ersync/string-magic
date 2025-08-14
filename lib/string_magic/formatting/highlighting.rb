# frozen_string_literal: true

module StringMagic
  module Formatting
    module Highlighting
      # ------------------------------------------------------------
      # Generic phrase highlighting
      # ------------------------------------------------------------
      #
      # highlight(%w[ruby rails], tag: 'span',
      #            css_class: 'hit', case_sensitive: false)
      #
      def highlight(phrases, tag: 'mark', css_class: nil, case_sensitive: true)
        return '' if empty?

        phrases = Array(phrases).compact.reject(&:empty?)
        return self if phrases.empty?

        klass = css_class ? %( class="#{css_class}") : ''
        esc   = phrases.sort_by(&:length).reverse.map { |p| Regexp.escape(p) }
        regex = Regexp.union(esc)
        regex = Regexp.new(regex.source, Regexp::IGNORECASE) unless case_sensitive

        gsub(regex) { |m| "<#{tag}#{klass}>#{m}</#{tag}>" }
      end

      # ------------------------------------------------------------
      # Remove previously added highlighting
      # ------------------------------------------------------------
      #
      # remove_highlights            # strips ALL html tags
      # remove_highlights('mark')    # strips only <mark>…</mark>
      #
      def remove_highlights(tag = nil)
        return '' if empty?

        if tag
          gsub(/<#{Regexp.escape(tag)}[^>]*>(.*?)<\/#{Regexp.escape(tag)}>/im, '\1')
        else
          gsub(/<[^>]+>/, '')
        end
      end

      # ------------------------------------------------------------
      # Auto-link / highlight URLs
      # ------------------------------------------------------------
      #
      # highlight_urls(css_class: 'link', target: '_blank')
      #
      def highlight_urls(tag: 'a', css_class: nil, target: nil)
        return '' if empty?

        klass  = css_class ? %( class="#{css_class}") : ''
        tgt    = target    ? %( target="#{target}")  : ''
        url_re = %r{https?://[^\s<>"']+}i

        gsub(url_re) { |url| %(<#{tag} href="#{url}"#{klass}#{tgt}>#{url}</#{tag}>) }
      end
    end
  end
end

# Optional automatic mix-in
class String
  include StringMagic::Formatting::Highlighting
end