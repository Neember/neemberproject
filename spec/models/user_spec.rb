require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :encrypted_password }
  end

  let(:user){ build(:user) }

  it 'validates email address' do
    user.email = 'martin124@example.com'
    expect(user.valid?).to be_truthy
    user.email = 'martin.com'
    expect(user.valid?).to be_falsey
  end

  describe '#name' do
    let(:user){ build(:user, first_name: 'Martin', last_name: 'Lorem', encrypted_password: '1231324124', email: 'asasd@example.com') }
    it 'display full name' do
      expect(user.name).to eq 'Martin Lorem'
    end
  end
end
