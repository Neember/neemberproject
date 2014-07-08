require 'rails_helper'

describe 'Create Client' do
  let(:admin) { create :admin }

  it 'creates a new client' do
    feature_login admin

    visit clients_path

    click_on 'Add New Client'

    expect(page).to have_content 'Add New Client'

    select 'Mr.', from: 'Title'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Paul'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Phone', with: '123-123-123'
    fill_in 'Address', with: '123 Singapore'
    fill_in 'Company name', with: 'ABC Company'
    fill_in 'Designation', with: 'Owner'

    click_on 'Submit'

    expect(page).to have_content I18n.t('client.message.create_success')
  end
end
