require 'rails_helper'

describe 'View Schedules List' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:work_logs) { create_list(:work_log, 5, project: project) }

  context 'When user logged in' do
    it 'display work logs list' do
      visit root_path

      feature_login(coder)

      visit work_logs_path

      expect(page).to have_content 'Work Logs List'
    end

  end

  context 'When admin logged in' do
    let(:admin) { create(:admin) }

    before { create_list(:work_log, 3) }

    it 'shows all work logs' do
      visit root_path
      feature_login(admin)

      click_on 'Work Logs List'

      expect(page).to have_content 'Work Logs List'

      expect(page.all('tr').count).to eql(9)
    end
  end

end
