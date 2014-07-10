require 'rails_helper'

describe 'View Schedules List' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:schedules) { create_list(:schedule, 5, project: project) }

  it 'display leaves list' do
    visit root_path

    feature_login(coder)

    visit schedules_path

    expect(page).to have_content 'Schedules List'
  end
end
