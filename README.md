# StringMagic

[![Gem Version](https://d25lcipzij17d.cloudfront.net/badge.svg?id=rb&r=r&ts=1683906897&type=6e&v=0.4.0&x2=0)](https://badge.fury.io/rb/string_magic)
[![CircleCI](https://dl.circleci.com/status-badge/img/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main.svg?style=svg&circle-token=CCIPRJ_PF8xu3Svcj2Ro4D8jhjCi7_71b7c0a7c781e09fc7194cd58cca67aecdc111b5)](https://dl.circleci.com/status-badge/redirect/circleci/8MamMcAVAVNWTcUqkjQk7R/Sh2DQkMWqqCv4MFvAmYWDL/tree/main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Summary

A gem that enhances Ruby's string class with an array of versatile methods designed for enhanced text formatting, manipulation, and analysis.

## Description

The StringMagic gem enriches Ruby's string class by adding a suite of versatile methods. These methods offer extended capabilities for formatting, manipulating, and querying text, making string operations more efficient and expressive.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/string_magic`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your Gemfile:

```ruby
gem 'string_magic'
```

And then execute:

```ruby
bundle install
```

Or install it globally:

```ruby
gem install string_magic
```

## Usage

```ruby
require 'string_magic'

# Example usage
string = "hello world"
puts StringMagic.palindrome?(string)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run rake spec to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:

```ruby
bundle exec rake install
```

To release a new version, update the version number in version.rb, and then run:

```ruby
bundle exec rake release
```

This will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/erscript/string-magic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/erscript/string-magic/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StringMagic project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/erscript/string-magic/blob/main/CODE_OF_CONDUCT.md).
