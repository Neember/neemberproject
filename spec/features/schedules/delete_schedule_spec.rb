require 'rails_helper'

describe 'Delete schedule' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project) }
  let!(:schedules) { create_list(:schedule, 5, coder: coder, project: project) }
  let!(:schedule) { Schedule.first }
  it 'Delete schedule' do
    visit root_path

    feature_login(coder)

    visit schedules_path

    get_element("delete-schedule-#{schedule.id}").click

    expect(page).to have_content 'Schedules List'
    expect(page).to have_content I18n.t('schedule.message.delete_schedule_success')
  end
end
