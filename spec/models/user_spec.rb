require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
  end

  let(:user){ build(:user) }

  it 'validates email address' do
    user.email = 'martin@futureworkz.com'
    expect(user.valid?).to be_truthy
    user.email = 'martin124@gmail.com'
    expect(user.valid?).to be_falsey
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
                               {'email' => 'Martin@futureworkz.com', 'first_name' => 'Martin', 'last_name' => 'Vu'})
    end

    context 'user has the account' do
      let!(:user) { create(:user, email: 'martin@futureworkz.com') }

      it 'returns user has google authenticated' do
        result = User.find_for_google_oauth2(access_token)
        expect { User.find_for_google_oauth2(access_token) }.to_not change(User, :count)
        expect(result.email).to eq user.email
      end
    end

    context 'user does not have the account' do
      it 'creates a new user' do
        expect(User.find_for_google_oauth2(access_token)).to be_falsey
      end
    end
  end
end

