require 'rails_helper'

describe 'Edit Work Log' do
  let(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:work_log) { create(:work_log, coder: coder, project: project) }

  it 'Edit work log success' do
    feature_login coder

    visit work_logs_path

    get_element("edit-work_log-#{work_log.id}").click

    expect(page).to have_content 'Edit Work Log'
    fill_in 'Date', with: '10/07/2014'
    fill_in 'Hours', with: 4
    select project.name, from: 'Project Name'
    click_on 'Submit'

    expect(page).to have_content 'Work Logs List'
    expect(page).to have_content I18n.t('work_log.message.update_work_log_success')
  end
end
