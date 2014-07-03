require 'rails_helper'

describe 'Create new project' do
  let!(:client) { create(:client) }

  it 'Create new project' do
    visit projects_path

    click_on 'Add New Project'

    fill_in 'Name', with: 'Lorem'
    fill_in 'Domain', with: 'Domain'
    fill_in 'Date started', with: '20/07/2014'
    fill_in 'Number of Sprints', with: '9.8'
    fill_in 'Price perSprint', with: '5000'
    fill_in 'Quotation No.', with: 'Lorem'
    select client.name, from: 'Client'
    click_on 'Submit'

    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.create_project_success')
  end
end
