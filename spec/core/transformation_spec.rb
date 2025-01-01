require "spec_helper"

RSpec.describe StringMagic::Core::Transformation do
  describe ".titleize_names" do
    it "capitalizes regular names" do
      expect(StringMagic.titleize_names("john smith")).to eq("John Smith")
    end

    it "handles special case company names" do
      expect(StringMagic.titleize_names("mcdonald ebay")).to eq("McDonald eBay")
    end

    it "handles prefixes correctly" do
      expect(StringMagic.titleize_names("ludwig van beethoven")).to eq("Ludwig van Beethoven")
    end

    it "handles multiple special cases" do
      text = "steve o'reilly bought a macbook from ebay"
      expect(StringMagic.titleize_names(text)).to eq("Steve O'Reilly Bought a MacBook From eBay")
    end

    it "handles empty string" do
      expect(StringMagic.titleize_names("")).to eq("")
    end

    it "handles nil" do
      expect(StringMagic.titleize_names(nil)).to be_nil
    end

    it "handles multiple word prefixes" do
      expect(StringMagic.titleize_names("leonardo da vinci")).to eq("Leonardo da Vinci")
    end

    it "capitalizes prefix at start of name" do
      expect(StringMagic.titleize_names("de silva")).to eq("De Silva")
    end

    it "preserves existing correct capitalization in special cases" do
      expect(StringMagic.titleize_names("iPhone iPad MacBook")).to eq("iPhone iPad MacBook")
    end

    it "handles mixed case input" do
      expect(StringMagic.titleize_names("jOhN mcDOnalD")).to eq("John McDonald")
    end
  end

  describe ".to_snake_case" do
    context "when handling different input formats" do
      it "converts camelCase to snake_case" do
        expect(StringMagic.to_snake_case("camelCase")).to eq("camel_case")
        expect(StringMagic.to_snake_case("thisIsATest")).to eq("this_is_a_test")
      end

      it "converts PascalCase to snake_case" do
        expect(StringMagic.to_snake_case("PascalCase")).to eq("pascal_case")
        expect(StringMagic.to_snake_case("ThisIsATest")).to eq("this_is_a_test")
      end

      it "converts kebab-case to snake_case" do
        expect(StringMagic.to_snake_case("kebab-case")).to eq("kebab_case")
        expect(StringMagic.to_snake_case("this-is-a-test")).to eq("this_is_a_test")
      end

      it "handles already snake_case strings" do
        expect(StringMagic.to_snake_case("snake_case")).to eq("snake_case")
        expect(StringMagic.to_snake_case("this_is_a_test")).to eq("this_is_a_test")
      end

      it "handles strings with multiple uppercase letters" do
        expect(StringMagic.to_snake_case("XMLHttpRequest")).to eq("xml_http_request")
        expect(StringMagic.to_snake_case("APIController")).to eq("api_controller")
      end

      it "handles edge cases" do
        expect(StringMagic.to_snake_case("")).to eq("")
        expect(StringMagic.to_snake_case(nil)).to eq("")
        expect(StringMagic.to_snake_case("ABC")).to eq("abc")
      end
    end
  end

  describe ".to_kebab_case" do
    context "when handling different input formats" do
      it "converts camelCase to kebab-case" do
        expect(StringMagic.to_kebab_case("camelCase")).to eq("camel-case")
        expect(StringMagic.to_kebab_case("thisIsATest")).to eq("this-is-a-test")
      end

      it "converts PascalCase to kebab-case" do
        expect(StringMagic.to_kebab_case("PascalCase")).to eq("pascal-case")
        expect(StringMagic.to_kebab_case("ThisIsATest")).to eq("this-is-a-test")
      end

      it "converts snake_case to kebab-case" do
        expect(StringMagic.to_kebab_case("snake_case")).to eq("snake-case")
        expect(StringMagic.to_kebab_case("this_is_a_test")).to eq("this-is-a-test")
      end

      it "handles already kebab-case strings" do
        expect(StringMagic.to_kebab_case("kebab-case")).to eq("kebab-case")
        expect(StringMagic.to_kebab_case("this-is-a-test")).to eq("this-is-a-test")
      end

      it "handles edge cases" do
        expect(StringMagic.to_kebab_case("")).to eq("")
        expect(StringMagic.to_kebab_case(nil)).to eq("")
      end
    end
  end

  describe ".to_pascal_case" do
    context "when handling different input formats" do
      it "converts snake_case to PascalCase" do
        expect(StringMagic.to_pascal_case("snake_case")).to eq("SnakeCase")
        expect(StringMagic.to_pascal_case("this_is_a_test")).to eq("ThisIsATest")
      end

      it "converts kebab-case to PascalCase" do
        expect(StringMagic.to_pascal_case("kebab-case")).to eq("KebabCase")
        expect(StringMagic.to_pascal_case("this-is-a-test")).to eq("ThisIsATest")
      end

      it "converts space-separated strings to PascalCase" do
        expect(StringMagic.to_pascal_case("space separated")).to eq("SpaceSeparated")
        expect(StringMagic.to_pascal_case("this is a test")).to eq("ThisIsATest")
      end

      it "handles already PascalCase strings" do
        expect(StringMagic.to_pascal_case("PascalCase")).to eq("PascalCase")
        expect(StringMagic.to_pascal_case("ThisIsATest")).to eq("ThisIsATest")
      end

      it "handles edge cases" do
        expect(StringMagic.to_pascal_case("")).to eq("")
        expect(StringMagic.to_pascal_case(nil)).to eq("")
        expect(StringMagic.to_pascal_case("a_b_c")).to eq("ABC")
      end

      it "handles multiple delimiters" do
        expect(StringMagic.to_pascal_case("mixed_with-spaces and_dashes")).to eq("MixedWithSpacesAndDashes")
      end
    end
  end
end
