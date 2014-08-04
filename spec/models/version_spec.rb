require 'rails_helper'

describe Version do
  describe '#user_first_name' do
    context 'show first_name of user' do
      let!(:user) { create(:user, id: 6, first_name: 'Martin') }
      let(:version) { create(:version, whodunnit: user.id) }

      it 'show first_name of user' do
        expect(version.creator_name).to eq user.first_name
      end
    end

    context 'show first_name of user' do
      let(:version) { create(:version, whodunnit: nil) }

      it 'show System if user is nil' do
        expect(version.creator_name).to eq 'System'
      end
    end
  end
end
