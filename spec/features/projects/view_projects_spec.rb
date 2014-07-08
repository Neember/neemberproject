require 'rails_helper'

describe 'View Projects List' do
  let!(:projects) { create_list(:project, 5) }
  let(:client) { create :client }
  let(:project) { projects.first }
  let(:admin) { create :admin }

  before { client.projects << project }

  it 'display projects list' do
    feature_login admin

    visit projects_path

    expect(page).to have_content 'Projects List'
    expect(page).to have_content 'DaDaDee'

    expect(page).to have_content client.company_name
  end
end
