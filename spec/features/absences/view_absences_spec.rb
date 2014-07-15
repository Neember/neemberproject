require 'rails_helper'

describe 'View Schedules List' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:absences) { create_list(:absence, 5, project: project) }

  context 'When user logged in' do
    it 'display absences list' do
      visit root_path

      feature_login(coder)

      visit absences_path

      expect(page).to have_content 'Absences List'
    end

  end

  context 'When admin logged in' do
    let(:admin) { create(:admin) }

    before { create_list(:absence, 3) }

    it 'shows all absences' do
      visit root_path
      feature_login(admin)

      click_on 'Absences List'

      expect(page).to have_content 'Absences List'
      # expect(page).to have_content coder_absence.reason
      # expect(page).to have_content admin_absence.reason

      expect(page.all('tr').count).to eql(9)
    end
  end

end
