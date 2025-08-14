# frozen_string_literal: true

module StringMagic
  module Utilities
    module Slug
      # ------------------------------------------------------------------
      # Public helpers
      # ------------------------------------------------------------------

      def to_slug(separator: '-', preserve_case: false)
        return '' if empty?

        result = dup
        result.downcase! unless preserve_case
        result = transliterate_accents(result)
        result.gsub!(/<[^>]*>/, '')                       # strip HTML
        result.gsub!(/[^A-Za-z0-9]+/, separator)          # non-alnum → sep
        result.gsub!(/^#{Regexp.escape(separator)}+|#{Regexp.escape(separator)}+$/, '')
        result
      end

      def to_url_slug
        to_slug(separator: '-', preserve_case: false)
      end

      def to_filename_safe(replacement: '_', preserve_case: false)
        return '' if empty?
        result = transliterate_accents(dup)
        result.downcase! unless preserve_case
        result.gsub!(/[^0-9A-Za-z\.\-]+/, replacement)               # keep only safe chars
        # convert file extension: ".txt" → "_txt"
        result.gsub!(/\.([a-z0-9]{1,5})\z/i, "#{replacement}\\1")
        result.gsub!(/\.+$/, '')                                      # drop any remaining trailing dots
        result.gsub!(/#{Regexp.escape(replacement)}+/, replacement)   # collapse runs
        result.gsub!(/^#{Regexp.escape(replacement)}+|#{Regexp.escape(replacement)}+$/, '') # trim
        result = 'untitled'  if result.empty?
        result = "#{result}_file" if reserved_filename?(result)
        result
      end

      def slugify_path(separator: '/')
        return '' if empty?
        split('/').map { |seg| seg.to_slug }.reject(&:empty?).join(separator)
      end

      def extract_slug_from_url
        return '' if empty?
        clean = split('/').last.to_s.split(/[?#]/).first
        clean.gsub!(/\.\w+$/, '') if clean.match?(/\.\w+$/)
        clean
      end

      # ------------------------------------------------------------------
      # Private helpers
      # ------------------------------------------------------------------
      private

      def transliterate_accents(text)
        accents = {
          'À'=>'A','Á'=>'A','Â'=>'A','Ã'=>'A','Ä'=>'A','Å'=>'A',
          'à'=>'a','á'=>'a','â'=>'a','ã'=>'a','ä'=>'a','å'=>'a',
          'È'=>'E','É'=>'E','Ê'=>'E','Ë'=>'E',
          'è'=>'e','é'=>'e','ê'=>'e','ë'=>'e',
          'Ì'=>'I','Í'=>'I','Î'=>'I','Ï'=>'I',
          'ì'=>'i','í'=>'i','î'=>'i','ï'=>'i',
          'Ò'=>'O','Ó'=>'O','Ô'=>'O','Õ'=>'O','Ö'=>'O',
          'ò'=>'o','ó'=>'o','ô'=>'o','õ'=>'o','ö'=>'o',
          'Ù'=>'U','Ú'=>'U','Û'=>'U','Ü'=>'U',
          'ù'=>'u','ú'=>'u','û'=>'u','ü'=>'u',
          'Ñ'=>'N','ñ'=>'n',
          'Ç'=>'C','ç'=>'c',
          'ß'=>'ss'
        }
        accents.each { |from, to| text.gsub!(from, to) }
        text
      end

      def reserved_filename?(name)
        %w[
          CON PRN AUX NUL COM1 COM2 COM3 COM4 COM5 COM6 COM7 COM8 COM9
          LPT1 LPT2 LPT3 LPT4 LPT5 LPT6 LPT7 LPT8 LPT9
        ].include?(name.upcase)
      end
    end
  end
end

# Optional auto-mix-in
class String
  include StringMagic::Utilities::Slug
end