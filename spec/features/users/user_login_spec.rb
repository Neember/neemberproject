require 'rails_helper'

describe 'Login page' do
  context 'Login success' do
    let(:user) { create(:user) }

    it 'Display login form' do
      visit root_path

      click_on 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123123123'
      click_on 'Submit'

      expect(page).to have_content 'Signed in successfully'
    end
  end

  context 'Login failed' do
    it 'Display login form' do
      visit root_path

      click_on 'Login'
      fill_in 'Email', with: 'martin@example.com'
      fill_in 'Password', with: '123456789'
      click_on 'Submit'

      expect(page).to have_content 'Invalid email or password'
    end
  end
end
