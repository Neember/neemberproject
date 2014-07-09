require 'rails_helper'

describe 'Display New Leave form' do
  let(:leaves) { create_list(:leave, 5) }
  let(:coder) { create(:coder) }

  it 'Create new leave' do
    feature_login(coder)

    visit leaves_path

    click_on 'Add New Leave'

    fill_in 'Date', with: '10/07/2014'
    fill_in 'Hours', with: 6
    fill_in 'Reason', with: 'Lorem lorem'
    click_on 'Submit'

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content I18n.t('leave.message.create_leave_success')
    expect(page).to have_content 'Lorem lorem'
  end
end
