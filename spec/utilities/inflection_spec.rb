# spec/string_magic/utilities/inflection_spec.rb

require 'spec_helper'

RSpec.describe StringMagic::Utilities::Inflection do
  describe '#to_plural' do
    it 'returns plural form of a string' do
      expect("cat".to_plural).to eq("cats")
      expect("baby".to_plural).to eq("babies")
      expect("leaf".to_plural).to eq("leaves")
      expect("knife".to_plural).to eq("knives")
    end

    it 'handles words ending in "s", "sh", "ch", "x", "z" by adding "es"' do
      expect("bus".to_plural).to eq("buses")
      expect("dish".to_plural).to eq("dishes")
      expect("box".to_plural).to eq("boxes")
      expect("quiz".to_plural).to eq("quizes")
    end

    it 'handles words ending in "y" by changing "y" to "ies"' do
      expect("baby".to_plural).to eq("babies")
      expect("city".to_plural).to eq("cities")
    end

    it 'handles words ending in "f" by changing "f" to "ves"' do
      expect("wolf".to_plural).to eq("wolves")
      expect("leaf".to_plural).to eq("leaves")
    end

    it 'handles words ending in "fe" by changing "fe" to "ves"' do
      expect("knife".to_plural).to eq("knives")
    end

    it 'defaults to adding "s" for other cases' do
      expect("dog".to_plural).to eq("dogs")
      expect("tree".to_plural).to eq("trees")
    end
  end

  describe '#to_singular' do
    it 'returns singular form of a string' do
      expect("cats".to_singular).to eq("cat")
      expect("babies".to_singular).to eq("baby")
      expect("leaves".to_singular).to eq("leaf")
      expect("knives".to_singular).to eq("knife")
    end

    it 'handles words ending in "ies" by changing "ies" to "y"' do
      expect("cities".to_singular).to eq("city")
      expect("babies".to_singular).to eq("baby")
    end

    it 'handles words ending in "ves" by changing "ves" to "f" or "ve"' do
      expect("wolves".to_singular).to eq("wolf")
      expect("leaves".to_singular).to eq("leaf")
    end

    it 'handles words ending in "ses", "shes", "ches", "xes", "zes" by removing "es"' do
      expect("buses".to_singular).to eq("bus")
      expect("dishes".to_singular).to eq("dish")
      expect("boxes".to_singular).to eq("box")
      expect("quizzes".to_singular).to eq("quizz")
    end

    it 'removes "s" from regular plural cases' do
      expect("dogs".to_singular).to eq("dog")
      expect("trees".to_singular).to eq("tree")
    end
  end

  describe '#ordinalize' do
    it 'returns the correct ordinal form of a number' do
      expect("1".ordinalize).to eq("1st")
      expect("2".ordinalize).to eq("2nd")
      expect("3".ordinalize).to eq("3rd")
      expect("4".ordinalize).to eq("4th")
    end

    it 'handles special cases for 11, 12, 13' do
      expect("11".ordinalize).to eq("11th")
      expect("12".ordinalize).to eq("12th")
      expect("13".ordinalize).to eq("13th")
    end
  end

  describe '#humanize' do
    it 'converts snake_case to human-readable format' do
      expect("my_variable_name".humanize).to eq("My variable name")
      expect("another_example_here".humanize).to eq("Another example here")
    end

    it 'converts camelCase to human-readable format' do
      expect("myVariableName".humanize).to eq("My variable name")
      expect("someCamelCaseExample".humanize).to eq("Some camel case example")
    end

    it 'handles empty strings' do
      expect("".humanize).to eq("")
    end

    it 'handles nil values' do
      expect(nil.to_s.humanize).to eq("")
    end
  end
end
