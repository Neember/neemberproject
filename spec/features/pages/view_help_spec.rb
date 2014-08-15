require 'rails_helper'

describe 'View help page' do
  context 'View help page' do
    let(:coder) { create :coder }
    it 'display view help page' do
      feature_login(coder)
      visit root_path
      click_on 'Help'

      expect(page).to have_content 'Help page'
    end
  end
end
