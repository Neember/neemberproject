require 'rails_helper'

describe 'Display Edit form' do
  let!(:users) { create_list(:user, 5) }
  let(:user) { User.first }

  it 'Display edit form' do
    visit users_path

    get_element("edit-user-#{user.id}").click

    fill_in 'First name', with: 'Martin Martin'
    fill_in 'Last name', with: 'Lorem Lorem'
    fill_in 'Email', with: 'martin123@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Submit'

    expect(page).to have_content 'Users List'
    expect(page).to have_content I18n.t('user.message.update_success')
  end
end
