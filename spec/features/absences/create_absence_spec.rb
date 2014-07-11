require 'rails_helper'

describe 'Display New Absence form' do
  let(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }

  it 'Create new absence' do
    feature_login(coder)

    visit absences_path

    click_on 'Add New Absence'

    fill_in 'Date', with: '10/07/2014'
    fill_in 'Hours', with: 6
    fill_in 'Reason', with: 'Lorem lorem'
    select project.name, from: 'Project Name'
    click_on 'Submit'

    expect(page).to have_content 'Absences List'
    expect(page).to have_content I18n.t('absence.message.create_absence_success')
    expect(page).to have_content 'Lorem lorem'
  end
end
