require 'rails_helper'

describe 'Display Edit form' do
  let!(:users) { create(:user) }
  let(:user) { User.first }
  let(:admin) { create :admin }

  it 'Display edit form' do
    feature_login admin

    visit users_path

    get_element("edit-user-#{user.id}").click

    fill_in 'First name', with: 'Martin Martin'
    fill_in 'Last name', with: 'Lorem Lorem'
    fill_in 'Email', with: 'martin123@futureworkz.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Submit'

    expect(page).to have_content 'Users List'
    expect(page).to have_content 'User is updated'
  end
end
