require 'rails_helper'

describe 'Display New Work log form' do
  let(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }

  it 'Create new work log' do
    feature_login(coder)

    visit work_logs_path

    click_on 'Add New Work Log'

    select 'Worked', from: 'Status'
    fill_in 'Date', with: '10/07/2014'
    fill_in 'Hours', with: 6
    fill_in 'Reason', with: 'Lorem lorem'
    select project.name, from: 'Project Name'
    click_on 'Submit'

    expect(page).to have_content 'Work Logs List'
    expect(page).to have_content I18n.t('work_log.message.create_work_log_success')
    expect(page).to have_content 'Lorem lorem'
  end
end
