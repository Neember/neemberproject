require 'rails_helper'

describe 'Edit project' do
  let!(:project) { create(:project) }
  let!(:client) { Client.find(2) }
  let!(:coders) { create_list(:user, 2) }
  let(:admin) { create :admin }

  it 'Edit project success' do
    feature_login admin

    visit projects_path

    get_element("edit-project-#{project.id}").click

    expect(page).to have_content 'Edit Project'
    fill_in 'Name',with: 'Neember'
    fill_in 'Quotation No.', with: 'Lorem Ipsum 2'
    select client.company_name, from: 'Client'
    select coders.first.name, from: 'Coders Name'
    select coders.last.name, from: 'Coders Name'
    click_on 'Submit'

    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.update_project_success')
    expect(page).to have_content coders.first.first_name
    expect(page).to have_content coders.last.first_name
  end
end
