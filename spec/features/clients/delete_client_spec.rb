require 'rails_helper'

describe 'Destroy client' do
  let!(:clients) { create_list(:client, 5) }
  let(:client) { clients.first }
  let(:admin) { create :admin }

  it 'Destroy client' do
    feature_login admin

    visit clients_path

    get_element("delete-client-#{client.id}").click

    expect(page).to have_content 'Clients List'
    expect(page).to have_content I18n.t('client.message.delete_success')
  end
end
