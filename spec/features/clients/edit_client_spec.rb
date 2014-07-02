require 'rails_helper'

describe 'Edit client' do
  let!(:clients) { create_list(:client, 5) }
  let(:client) { clients.first }

  it 'updates client' do
    visit clients_url

    click_on "Edit ##{client.id}"

    expect(page).to have_content 'Edit client'
    fill_in 'First name', with: 'Martin'
    fill_in 'Last name', with: 'Vu'
    fill_in 'Designation', with: 'Owner'
    fill_in 'Address', with: 'Ho Chi Minh'

    click_on 'Submit'

    expect(page).to have_content 'Clients List'
    expect(page).to have_content 'Update client successfully'
  end
end
