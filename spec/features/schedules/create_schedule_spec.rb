require 'rails_helper'

describe 'Display New Schedule form' do
  let!(:project) { create(:project) }
  let(:schedules) { create_list(:schedule, 5) }
  let(:coder) { create(:coder) }

  it 'Create new schedule' do
    feature_login(coder)

    visit schedules_path

    click_on 'Add New Schedule'

    fill_in 'Date', with: '10/07/2014'
    fill_in 'Hours', with: 6
    fill_in 'Reason', with: 'Lorem lorem'
    select project.name, from: 'Project'
    click_on 'Submit'

    expect(page).to have_content 'Schedules List'
    expect(page).to have_content I18n.t('schedule.message.create_schedule_success')
    expect(page).to have_content 'Lorem lorem'
  end
end
