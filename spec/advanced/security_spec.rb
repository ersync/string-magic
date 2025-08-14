# spec/string_magic/advanced/security_spec.rb
require 'spec_helper'

RSpec.describe StringMagic::Advanced::Security do
  let(:test_string) { "Contact John at john.doe@email.com or call 555-123-4567. Credit card: 4532-1234-5678-9012, SSN: 123-45-6789" }

  describe '#mask_sensitive_data' do
    context 'with default options' do
      it 'masks credit cards, SSNs, and emails by default' do
        result = test_string.mask_sensitive_data
        
        expect(result).to include('************9012')  # Credit card
        expect(result).to include('*****6789')         # SSN
        expect(result).to include('j*******@email.com')  # Email (corrected)
        expect(result).to include('***-***-4567')      # Phone masked by default
      end
    end

    context 'with custom mask character' do
      it 'uses custom mask character' do
        result = test_string.mask_sensitive_data(mask_char: '#')
        expect(result).to include('############9012')
        expect(result).to include('j#######@email.com')
      end
    end

    context 'with custom preserve count' do
      it 'preserves specified number of characters' do
        result = test_string.mask_sensitive_data(preserve_count: 6)
        expect(result).to include('**********789012')  # Credit card
        expect(result).to include('***456789')         # SSN
      end
    end

    context 'with specific types' do
      it 'only masks specified types' do
        result = test_string.mask_sensitive_data(types: [:email])
        expect(result).to include('j*******@email.com')  # Corrected
        expect(result).to include('4532-1234-5678-9012')  # Credit card not masked
      end

      it 'masks phone numbers when specified' do
        result = test_string.mask_sensitive_data(types: [:phone])
        expect(result).to include('***-***-4567')
      end
    end

    context 'with empty or nil strings' do
      it 'returns empty string for empty input' do
        expect(''.mask_sensitive_data).to eq('')
      end
    end

    context 'with no sensitive data' do
      it 'returns original string unchanged' do
        clean_string = "This is a clean string with no sensitive data"
        expect(clean_string.mask_sensitive_data).to eq(clean_string)
      end
    end
  end

  describe '#mask_credit_cards' do
    let(:cc_string) { "Cards: 4532-1234-5678-9012 and 4532123456789012" }

    it 'masks only credit cards with default settings' do
      result = cc_string.mask_credit_cards
      expect(result).to include('************9012')
      expect(result).to include('************9012')
    end

    it 'uses custom mask character' do
      result = cc_string.mask_credit_cards(mask_char: '#')
      expect(result).to include('############9012')
    end

    it 'preserves custom number of digits' do
      result = cc_string.mask_credit_cards(preserve_count: 6)
      expect(result).to include('**********789012')
    end
  end

  describe '#mask_emails' do
    let(:email_string) { "Contact: john@example.com, jane.doe@company.co.uk" }

    it 'masks email addresses' do
      result = email_string.mask_emails
      expect(result).to include('j********@example.com')
      expect(result).to include('j*******@company.co.uk')
    end

    it 'uses custom mask character' do
      result = email_string.mask_emails(mask_char: '#')
      expect(result).to include('j########@example.com')
    end

    context 'with single character email prefix' do
      it 'masks single character correctly' do
        result = "Email: a@test.com".mask_emails
        expect(result).to include('a********@test.com')
      end
    end
  end

  describe '#mask_phones' do
    context 'with standard phone formats' do
      it 'masks phone number with dashes' do
        result = "Call 555-123-4567".mask_phones
        expect(result).to eq("Call ***-***-4567")
      end

      it 'masks phone number with parentheses' do
        result = "Call (555) 123-4567".mask_phones
        expect(result).to eq("Call (***) ***-4567")
      end

      it 'masks phone number with spaces' do
        result = "Call 555 123 4567".mask_phones
        expect(result).to eq("Call *** *** 4567")
      end

      it 'masks phone number without separators' do
        result = "Call 5551234567".mask_phones
        expect(result).to eq("Call ******4567")  # Fixed: 10 digits - 4 preserved = 6 masked
      end

      it 'masks international number' do
        result = "Call +1 555 123 4567".mask_phones
        expect(result).to eq("Call +* *** *** 4567")
      end
    end

    context 'with custom options' do
      it 'uses custom mask character' do
        result = "Call 555-123-4567".mask_phones(mask_char: '#')
        expect(result).to eq("Call ###-###-4567")
      end

      it 'preserves custom number of digits' do
        result = "Call 555-123-4567".mask_phones(preserve_count: 6)
        expect(result).to eq("Call ***-*23-4567")
      end

      it 'preserves more digits than available' do
        result = "Call 555-123-4567".mask_phones(preserve_count: 15)
        expect(result).to eq("Call 555-123-4567")  # No masking when preserve_count >= digit count
      end
    end

    context 'with multiple phone numbers' do
      let(:multi_phone) { "Primary: 555-123-4567, Secondary: (555) 987-6543" }

      it 'masks all phone numbers' do
        result = multi_phone.mask_phones
        expect(result).to eq("Primary: ***-***-4567, Secondary: (***) ***-6543")
      end
    end

    context 'when used in mask_sensitive_data' do
      it 'masks phone numbers when phone type is specified' do
        text = "Contact John at john.doe@email.com or call 555-123-4567"
        result = text.mask_sensitive_data(types: [:phone])
        expect(result).to eq("Contact John at john.doe@email.com or call ***-***-4567")
      end
    end

    context 'with edge cases' do
      it 'handles short numbers that should not be masked' do
        result = "Call 123".mask_phones
        expect(result).to eq("Call 123")  # Too short to match phone pattern
      end

      it 'handles numbers with extensions (extension not masked)' do
        result = "Call 555-123-4567 ext 123".mask_phones
        expect(result).to eq("Call ***-***-4567 ext 123")  # Fixed: ext is separate, not part of phone regex
      end

      it 'handles multiple separate numbers' do
        result = "Office: 555-123-4567, Fax: 555-987-6543".mask_phones
        expect(result).to eq("Office: ***-***-4567, Fax: ***-***-6543")
      end
    end
  end

  describe '#contains_sensitive_data?' do
    it 'returns true when credit card is present' do
      expect("Card: 4532-1234-5678-9012".contains_sensitive_data?).to be true
    end

    it 'returns true when SSN is present' do
      expect("SSN: 123-45-6789".contains_sensitive_data?).to be true
    end

    it 'returns true when email is present' do
      expect("Email: test@example.com".contains_sensitive_data?).to be true
    end

    it 'returns false when no sensitive data is present' do
      expect("This is clean text".contains_sensitive_data?).to be false
    end

    it 'returns false for empty string' do
      expect("".contains_sensitive_data?).to be false
    end
  end

  describe 'edge cases' do
    context 'with malformed data' do
      it 'handles partial credit card numbers' do
        result = "Card: 4532-1234".mask_sensitive_data
        expect(result).to eq("Card: 4532-1234")  # Should not match
      end

      it 'handles email without domain' do
        result = "Email: john@".mask_sensitive_data
        expect(result).to eq("Email: john@")  # Should not match
      end
    end

    context 'with mixed formatting' do
      it 'handles credit cards with different separators' do
        mixed = "Cards: 4532-1234-5678-9012, 4532 1234 5678 9012, 4532123456789012"
        result = mixed.mask_sensitive_data
        expect(result.scan(/\*+9012/).length).to eq(3)
      end
    end

    context 'with various email formats' do
      it 'correctly masks different email lengths' do
        short_email = "a@test.com"
        long_email = "very.long.email.address@domain.com"
        
        expect(short_email.mask_emails).to eq("a********@test.com")
        expect(long_email.mask_emails).to eq("v**********************@domain.com")
      end
    end
  end
end