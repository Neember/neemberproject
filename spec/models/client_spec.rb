require 'rails_helper'

describe Client do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :email }

    let(:client) { build(:client) }

    it 'validates email address' do
      client.email = 'jack@example.com'
      expect(client.valid?).to be true
      client.email = 'jack_example.com'
      expect(client.valid?).to be false
    end
  end
end
