require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
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

  describe 'associations' do
    it { should have_and_belong_to_many(:projects).with_foreign_key('coder_id') }
  end
end
