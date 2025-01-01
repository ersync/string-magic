require_relative "../spec_helper"

RSpec.describe StringMagic::Advanced::Security do
  describe ".mask_sensitive_data" do
    it "masks credit card numbers" do
      text = "My card is 4111-1111-1111-1111"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("My card is ************1111")
    end

    it "masks SSN numbers" do
      text = "SSN: 123-45-6789"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("SSN: *****6789")
    end

    it "masks email addresses" do
      text = "Contact me at john.doe@example.com"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("Contact me at ********@example.com")
    end

    it "handles multiple sensitive data in one text" do
      text = "Card: 4111-1111-1111-1111, Email: test@example.com, SSN: 123-45-6789"
      masked = StringMagic.mask_sensitive_data(text)
      expect(masked).to include("************1111")
      expect(masked).to include("****@example.com")
      expect(masked).to include("*****6789")
    end

    it "handles custom mask character" do
      text = "Card: 4111-1111-1111-1111"
      expect(StringMagic.mask_sensitive_data(text, mask_char: "#"))
        .to eq("Card: ############1111")
    end

    it "preserves original text structure" do
      text = "Before 4111-1111-1111-1111 After"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("Before ************1111 After")
    end

    it "handles nil input" do
      expect(StringMagic.mask_sensitive_data(nil)).to be_nil
    end

    it "handles empty string" do
      expect(StringMagic.mask_sensitive_data("")).to eq("")
    end

    it "handles text without sensitive data" do
      text = "Just some regular text"
      expect(StringMagic.mask_sensitive_data(text)).to eq(text)
    end

    it "masks credit cards without separators" do
      text = "Card: 4111111111111111"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("Card: ************1111")
    end

    it "masks SSNs without separators" do
      text = "SSN: 123456789"
      expect(StringMagic.mask_sensitive_data(text))
        .to eq("SSN: *****6789")
    end
  end
end
