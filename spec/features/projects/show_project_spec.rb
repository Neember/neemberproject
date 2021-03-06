require 'rails_helper'

describe 'Show project detail' do
  context 'Show project detail' do
    let(:admin) { create :admin }
    let(:coder) { create :coder }
    let(:client) { Client.find(2) }
    let!(:project) { create(:project, coders: [coder], client: client, points_left: 150) }

    before { create_list :work_log, 3, project: project, coder: coder }

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

      expect(page).to have_content project.points_left
    end
  end
end
