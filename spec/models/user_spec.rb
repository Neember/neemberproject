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

  describe '.find_for_google_oauth2' do
    let(:access_token) { double('access_token') }
    before do
      allow(access_token).to receive(:info).and_return(
                               {'email' => user.email, 'first_name' => user.first_name, 'last_name' => user.last_name})
    end

    context 'user has the account' do
      let!(:user) { create(:user) }

      it 'returns user has google authenticated' do
        expect { User.find_for_google_oauth2(access_token) }.to_not change(User, :count)
      end
    end

    context 'user does not have the account' do
      let(:user) { build(:user) }

      it 'creates a new user' do
        expect { User.find_for_google_oauth2(access_token) }.to change(User, :count).by(1)
      end
    end
  end
end

