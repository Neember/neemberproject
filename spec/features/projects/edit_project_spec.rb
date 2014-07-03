require 'rails_helper'

describe 'Edit project' do
  let!(:project) { create(:project) }
  it 'Edit project' do
    visit projects_path

    get_element("project-#{project.id}").click

    expect(page).to have_content 'Edit Project'
    fill_in 'Name',with: 'Neember'
    fill_in 'Quotation No.', with: 'Lorem Ipsum 2'
    click_on 'Submit'
    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.update_project_success')

  end
end
