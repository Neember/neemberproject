require 'rails_helper'

describe 'New user' do
  let(:admin) { create :admin }
  context 'Valid data' do
    it 'create a new user' do
      feature_login admin

      visit users_path

      click_on 'Add New User'

      fill_in 'First name', with: 'Martin'
      fill_in 'Last name', with: 'Vu'
      fill_in 'Email', with: 'martin@futureworkz.com'
      fill_in 'Password', with: '123123123'
      fill_in 'Password confirmation', with: '123123123'
      check('Make User An Administrator')
      click_on 'Submit'

      expect(page).to have_content 'Users List'
      expect(page).to have_content 'martin@futureworkz.com'
    end
  end

  context 'Invalid data' do
    it 'show the validation errors' do
      feature_login admin

      visit users_path

      click_on 'Add New User'

      fill_in 'First name', with: ''
      fill_in 'Last name', with: 'Vu'
      fill_in 'Email', with: 'martin@futureworkz.com'
      fill_in 'Password', with: '123456777'
      fill_in 'Password confirmation', with: '123123123'
      check('Make User An Administrator')
      click_on 'Submit'

      expect(page).to have_content 'Please fill in First name'
      expect(page).to have_content "doesn't match Password"
    end
  end
end
