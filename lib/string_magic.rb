# frozen_string_literal: true

require_relative "string_magic/version"
require_relative "string_magic/core/analysis"
require_relative "string_magic/core/transformation" 
require_relative "string_magic/core/validation"
require_relative "string_magic/formatting/highlighting"
require_relative "string_magic/formatting/truncation"
require_relative "string_magic/advanced/security"
require_relative "string_magic/utilities/slug"
require_relative "string_magic/utilities/inflection"

class String
  include StringMagic::Core::Analysis
  include StringMagic::Core::Transformation
  include StringMagic::Core::Validation
  include StringMagic::Formatting::Highlighting
  include StringMagic::Formatting::Truncation
  include StringMagic::Advanced::Security
  include StringMagic::Utilities::Slug
  include StringMagic::Utilities::Inflection
end

module StringMagic
  class Error < StandardError; end
  class MalformedInputError < Error; end

  extend Core::Analysis
  extend Core::Transformation
  extend Core::Validation
  extend Formatting::Highlighting
  extend Formatting::Truncation
  extend Advanced::Security
  extend Utilities::Slug
  extend Utilities::Inflection
end