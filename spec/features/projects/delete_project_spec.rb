require 'rails_helper'

describe 'Delete Project' do
  let!(:project) { create(:project) }
  let(:admin) { create :admin }

  it 'delete project' do
    feature_login admin

    visit projects_path

    get_element("delete-project-#{project.id}").click

    expect(page).to have_content 'Projects List'
    expect(page).to have_content I18n.t('project.message.delete_project_success')
  end
end
