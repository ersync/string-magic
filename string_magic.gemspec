# frozen_string_literal: true

require_relative "lib/string_magic/version"

Gem::Specification.new do |spec|
  spec.name = "string_magic"
  spec.version = StringMagic::VERSION
  spec.authors = ["Emad Rahimi"]
  spec.email = ["121079771+erscript@users.noreply.github.com"]

  spec.summary = "The StringMagic gem enriches Ruby's string class with an array of versatile methods designed for enhanced text formatting, manipulation, and analysis."
  spec.description = "The StringMagic gem enriches Ruby's string class by adding a suite of versatile methods. These methods offer extended capabilities for formatting, manipulating, and querying text, making string operations more efficient and expressive."
  spec.homepage = "https://github.com/USERNAME/string_magic"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/USERNAME/string_magic"
  spec.metadata["changelog_uri"] = "https://github.com/USERNAME/string_magic/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end