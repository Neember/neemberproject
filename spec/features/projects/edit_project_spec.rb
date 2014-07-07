require 'rails_helper'

describe 'Edit project' do
  let!(:project) { create(:project) }
  let!(:client) { create(:client, first_name: 'Martin', last_name: 'Vu') }
  let!(:user) { create(:user) }

  it 'Edit project success' do
    visit projects_path

    get_element("edit-project-#{project.id}").click

    expect(page).to have_content 'Edit Project'
    fill_in 'Name',with: 'Neember'
    fill_in 'Quotation No.', with: 'Lorem Ipsum 2'
    select client.name, from: 'Client'
    select user.name, from: 'User'
    click_on 'Submit'

    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.update_project_success')
    expect(page).to have_content client.name
  end
end
