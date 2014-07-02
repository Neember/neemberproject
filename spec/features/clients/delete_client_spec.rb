require 'rails_helper'

describe 'Destroy client' do

  let!(:clients) { create_list(:client, 5)}
  let(:client) { clients.first  }

  it 'Destroy client' do
    visit clients_path

    click_on "Delete ##{client.id}"

    expect(page).to have_content 'Clients List'
    expect(page).to have_content 'Delete client successfully'
  end
end
