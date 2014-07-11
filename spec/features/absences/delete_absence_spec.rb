require 'rails_helper'

describe 'Delete absence' do
  let!(:coder) { create(:coder) }
  let!(:project) { create(:project, coders: [coder]) }
  let!(:absences) { create_list(:absence, 5, project: project) }

  it 'Delete absence' do
    visit root_path

    feature_login(coder)

    visit absences_path

    get_element("delete-absence-#{absences.first.id}").click

    expect(page).to have_content 'Absences List'
    expect(page).to have_content I18n.t('absence.message.delete_absence_success')
  end
end
