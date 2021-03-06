require 'rails_helper'

describe 'View Projects List' do
  let!(:projects) { create_list(:project, 5) }
  let(:client) { Client.find(2) }
  let(:project) { projects.first }
  let(:admin) { create :admin, email: 'martin@futureworkz.com' }

  it 'display projects list' do
    feature_login admin

    visit projects_path

    expect(page).to have_content 'Projects List'
    expect(page).to have_content 'DaDaDee'
  end
end
