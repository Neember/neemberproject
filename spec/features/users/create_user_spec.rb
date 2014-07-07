require 'rails_helper'

describe 'New user' do
  it 'create a new user' do
    visit users_path

    click_on 'Add New User'

    fill_in 'First name', with: 'Martin'
    fill_in 'Last name', with: 'Vu'
    fill_in 'Email', with: 'martin@futureworkz.com'
    fill_in 'Password', with: '123123123'
    check('Is admin')
    click_on 'Submit'

    expect(page).to have_content 'Users List'
    expect(page).to have_content 'martin@futureworkz.com'
  end
end
