require 'rails_helper'

describe Client do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :address }
    it { should validate_presence_of :company_name }
    it { should validate_presence_of :designation }
    it { should enumerize(:title).in(:mr, :mrs, :ms, :dr, :mdm) }


    let(:client) { build(:client) }

    it 'validates email address' do
      client.email = 'jack@example.com'
      expect(client.valid?).to be true
      client.email = 'jack_example.com'
      expect(client.valid?).to be false
    end
  end

  context 'associations' do
    it { should have_many :projects }
  end

  describe '#name' do
    let(:client) { create(:client, first_name: 'John', last_name: 'Cena') }

    it 'returns client full name' do
      expect(client.name).to eq 'John Cena'
    end
  end
end
