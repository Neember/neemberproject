require 'rails_helper'

describe 'View Schedules List' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:absences) { create_list(:absence, 5, project: project) }

  it 'display absences list' do
    visit root_path

    feature_login(coder)

    visit absences_path

    expect(page).to have_content 'Absences List'
  end
end
