require 'rails_helper'

describe 'View Clients' do
  let(:admin) { create :admin }

  before { create_list(:client, 5) }

  it 'displays clients list' do
    feature_login admin

    visit clients_path

    expect(page).to have_content 'Clients List'
    expect(page).to have_content 'Paul'
  end
end
