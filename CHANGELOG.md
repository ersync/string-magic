## [0.5.0] - 2025-08-12

### Added

- **StringMagic::Core::Validation** - Email, URL, phone, credit card validation and more
- **StringMagic::Utilities::Slug** - Convert text to URL-safe slugs and filename-safe strings  
- **StringMagic::Utilities::Inflection** - Pluralize, singularize, ordinalize, and humanize text

### Enhanced

- **StringMagic::Core::Transformation** - New case conversions and text manipulation methods
- **StringMagic::Core::Analysis** - Improved entity extraction and sentiment analysis
- **StringMagic::Formatting::Truncation** - Smart word, sentence, and character truncation
- **StringMagic::Formatting::Highlighting** - HTML highlighting and URL auto-linking
- **StringMagic::Advanced::Security** - Mask sensitive data like credit cards and emails

### Changed

- Modular code organization
- All methods now available as both String instance methods and module methods

## [0.4.0] - 2025-01-01

### Added

-   Core string utility methods (palindrome, case conversions, word operations)
-   Test coverage for new methods

## [0.3.0] - 2025-01-01

-   Text analysis features
    -   `extract_entities` (emails, URLs, dates, hashtags, mentions)
    -   `readability_score` for text complexity
-   Case conversion methods
    -   `to_snake_case`
    -   `to_kebab_case`
    -   `to_pascal_case`

## [0.2.2] - 2024-07-29

-   Bug fixes

## [0.2.1] - 2024-07-29

-   Bug fixes

## [0.2.0] - 2024-07-29

-   Introduces the first substantial methods to the gem.
-   Added #word_count and #palindrome? methods.
-   Included RSpec for testing.
-   Integrated SimpleCov for code coverage.
-   Set up CircleCI for continuous integration.

## [0.1.0] - 2024-07-29

-   Initial release
