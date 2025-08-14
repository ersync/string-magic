# StringMagic - v0.5.0
[![Gem Version](https://badge.fury.io/rb/string_magic.svg)](https://badge.fury.io/rb/string_magic)
[![Build Status](https://dl.circleci.com/status-badge/img/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main)
[![License: MIT](https://img.shields.io/badge/License-MIT-lightgreen.svg)](LICENSE)

**StringMagic** super-charges Ruby's `String` with batteries-included helpers for formatting, validation, analysis, transformation, and security all in one tidy gem.

## Why StringMagic?
- Zero dependencies – pure Ruby
- Non-destructive: original strings are never mutated
- Thread-safe & fully tested (160+ RSpec examples, ~98% coverage)
- Drop-in: optionally auto-mixes into String, or use module methods (`StringMagic.to_slug(...)`)

## Quickstart Cheatsheet

```ruby
# Formatting
"Hello world".truncate_words(1)             # => "Hello..."
"user@domain.com".mask_emails               # => "u********@domain.com"
"Ruby on Rails".highlight('Ruby')           # => "<mark>Ruby</mark> on Rails"

# Validation
"test@example.com".email?                   # => true
"4111111111111111".credit_card?             # => true
"racecar".palindrome?                       # => true

# Transformation
"CamelCase".to_snake_case                   # => "camel_case"
"user input".to_filename_safe               # => "user_input"
"second".ordinalize                         # => "2nd"

# Analysis
"Visit https://example.com".extract_urls    # => ["https://example.com"]
"Great product!".sentiment_indicators       # => {:positive=>1.0, :negative=>0.0, :neutral=>0}
```

## Installation
```bash
gem install string_magic
```
Or add to your Gemfile:
```ruby
gem 'string_magic'
```

## Full Documentation

### Core Operations
- **Case conversion**: `to_snake_case`, `to_kebab_case`, `to_camel_case`, `to_pascal_case`, `to_title_case`
- **Text manipulation**: `reverse_words`, `alternating_case`, `remove_duplicate_chars`, `remove_duplicate_words`
- **HTML handling**: `remove_html_tags`, `escape_html`

### Validation
- Format checks: `email?`, `url?`, `phone?`, `credit_card?`
- Text relations: `palindrome?`, `anagram_of?`
- Password strength: `strong_password?`

### Analysis
- **Entity extraction**: `extract_emails`, `extract_urls`, `extract_phones`, `extract_dates`
- **Text metrics**: `readability_score`, `word_frequency`, `sentiment_indicators`

### Formatting
- **Truncation**: `truncate_words`, `truncate_sentences`, `truncate_characters`, `smart_truncate`
- **Highlighting**: `highlight`, `remove_highlights`, `highlight_urls`

### Security
- **Data masking**: `mask_sensitive_data`, `mask_credit_cards`, `mask_emails`, `mask_phones`
- **Detection**: `contains_sensitive_data?`

### Utilities
- **Inflection**: `to_plural`, `to_singular`, `ordinalize`, `humanize`
- **Slug generation**: `to_slug`, `to_url_slug`, `to_filename_safe`

## Contributing
1. Fork → `git checkout -b feature/awesome`
2. Add specs for your change
3. `bundle exec rspec`
4. PR ✉️ – we love improvements!

## License
MIT - See [LICENSE](LICENSE) for details.
