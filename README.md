# StringMagic

[![Gem Version](https://d25lcipzij17d.cloudfront.net/badge.svg?id=rb&r=r&ts=1683906897&type=6e&v=0.4.0&x2=0)](https://badge.fury.io/rb/string_magic)
[![CircleCI](https://dl.circleci.com/status-badge/img/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main.svg?style=svg&circle-token=CCIPRJ_PF8xu3Svcj2Ro4D8jhjCi7_71b7c0a7c781e09fc7194cd58cca67aecdc111b5)](https://dl.circleci.com/status-badge/redirect/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main)
[![License: MIT](https://img.shields.io/badge/License-MIT-lightgreen.svg)](https://opensource.org/licenses/MIT)

## Summary

**StringMagic** is a Ruby gem that enhances Ruby's `String` class with powerful methods for text formatting, manipulation, and analysis. It simplifies common string operations while introducing advanced features for developers.

## Features

-   **Text Analysis**: Extract emails, URLs, dates, and more from text.
-   **String Transformation**: Convert between cases (snake, kebab, camel, Pascal) or manipulate words.
-   **Formatting Utilities**: Highlight phrases, truncate text, and mask sensitive information.
-   **Core Operations**: Palindrome detection, word count, and anagram checks.

## Installation

To include StringMagic in your project, add it to your Gemfile:

```ruby
gem 'string_magic'
```

Then run:

```sh
bundle install
```

Or install it globally with:

```sh
gem install string_magic
```

## Usage

Require the gem in your code:

```ruby
require 'string_magic'

# Core Operations
puts StringMagic.palindrome?("A man a plan a canal Panama")
# => true

puts StringMagic.word_count("Hello world!")
# => 2

puts StringMagic.to_pig_latin("hello")
# => "ellohay"

# Text Analysis
text = "Contact support@example.com or visit https://example.com"
puts StringMagic.extract_entities(text)
# => {
#      emails: ["support@example.com"],
#      urls: ["https://example.com"],
#      phone_numbers: [],
#      dates: [],
#      hashtags: [],
#      mentions: []
#    }

# Formatting Utilities
puts StringMagic.highlight("Hello world", "world", tag: "strong")
# => "Hello <strong>world</strong>"

puts StringMagic.truncate_words("Hello world how are you", 2)
# => "Hello world..."

# Security Features
card_text = "My card is 4111-1111-1111-1111"
puts StringMagic.mask_sensitive_data(card_text)
# => "My card is ************1111"

# Case Conversions
puts StringMagic.to_snake_case("HelloWorld")
# => "hello_world"
puts StringMagic.to_kebab_case("HelloWorld")
# => "hello-world"
puts StringMagic.camel_case("hello world")
# => "HelloWorld"

# Text Manipulation
puts StringMagic.remove_duplicates("hello")
# => "helo"
puts StringMagic.alternating_case("hello")
# => "HeLlO"
puts StringMagic.reverse_words("hello world")
# => "world hello"
```

## Available Methods

### Core Operations

-   `palindrome?(text)`: Determines if the given text is a palindrome.
-   `word_count(text)`: Counts words in the text.
-   `anagram?(text1, text2)`: Checks if two texts are anagrams.

### Text Analysis

-   `readability_score(text)`: Calculates text complexity using the Flesch-Kincaid formula.
-   `extract_entities(text)`: Extracts entities like emails, URLs, phone numbers, dates, hashtags, and mentions.

### String Transformation

-   `to_snake_case(text)`: Converts text to `snake_case`.
-   `to_kebab_case(text)`: Converts text to `kebab-case`.
-   `to_pascal_case(text)`: Converts text to `PascalCase`.
-   `camel_case(text)`: Converts text to `camelCase`.

### Formatting Utilities

-   `highlight(text, phrases, options)`: Highlights text with HTML tags.
-   `truncate_words(text, count, options)`: Truncates text to a specified number of words.
-   `truncate_sentences(text, count, options)`: Truncates text to a specified number of sentences.

### Security Features

-   `mask_sensitive_data(text, options)`: Masks sensitive information like credit card numbers and emails.

### Text Manipulation

-   `remove_duplicates(text)`: Removes duplicate characters from text.
-   `alternating_case(text)`: Alternates character case in text.
-   `reverse_words(text)`: Reverses the order of words in text.

## Contributing

I welcome contributions! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Commit your changes (`git commit -am 'feat: add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

Please make sure to update tests and follow coding standards.

## License

This gem is open source and available under the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Interactions in the project's codebases, issue trackers, and other channels must adhere to the [Code of Conduct](https://github.com/erscript/string-magic/blob/main/CODE_OF_CONDUCT.md).
