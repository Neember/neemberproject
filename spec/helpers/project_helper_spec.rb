require 'rails_helper'

describe ProjectHelper do
  describe '#coders_link_list' do
    let(:coders) { create_list(:user, 3) }

    it 'displays coders list' do
      expect(helper.coders_link_list(coders)).to have_content coders.first.first_name
    end
  end
end
