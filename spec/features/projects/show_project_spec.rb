require 'rails_helper'

describe 'Show project detail' do
  context 'Show project detail' do
    let(:admin) { create :admin }
    let(:coder) { create :coder }
    let(:client) { create :client }
    let!(:project) { create(:project, coders: [coder], client: client) }

    it 'show project detail' do
      visit root_path

      feature_login(admin)

      visit projects_path

      get_element("view-project-#{project.id}").click

      expect(page).to have_content project.name
      expect(page).to have_content project.date_started
      expect(page).to have_content project.target_completion
      expect(page).to have_content project.domain
      expect(page).to have_content project.no_of_sprints
      expect(page).to have_content client.company_name
    end
  end
end
