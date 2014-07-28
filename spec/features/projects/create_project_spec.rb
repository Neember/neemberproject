require 'rails_helper'

describe 'Create new project' do
  let!(:client) { Client.find(2) }
  let(:admin) { create :admin }

  it 'Create new project' do
    feature_login admin

    visit projects_path

    click_on 'Add New Project'

    fill_in 'Name', with: 'Lorem'
    fill_in 'Domain', with: 'Dadadee.com'
    fill_in 'Date started', with: '20/07/2014'
    fill_in 'Number of Sprints', with: '9.8'
    fill_in 'Price per Sprint', with: '5000'
    fill_in 'Quotation No.', with: 'Lorem'
    fill_in 'Notes', with: 'Lorem ipsum Lorem ipsum'
    fill_in 'Pivotal Project Id', with: 9999
    fill_in 'Date completed', with: '20/09/02014'
    select client.company_name, from: 'Client'
    click_on 'Submit'

    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.create_project_success')
    expect(page).to have_content 'Lorem'
  end
end
