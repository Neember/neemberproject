require 'rails_helper'

describe Client do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :address }
    it { should validate_presence_of :company_name }
    it { should validate_presence_of :designation }

    let(:client) { build(:client) }

    it 'validates email address' do
      client.email = 'jack@example.com'
      expect(client.valid?).to be true
      client.email = 'jack_example.com'
      expect(client.valid?).to be false
    end
  end
end
