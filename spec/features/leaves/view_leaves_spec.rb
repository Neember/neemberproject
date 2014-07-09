require 'rails_helper'

describe 'View Leaves List' do
  let!(:coder) { create(:coder) }
  let!(:leaves) { create_list(:leave, 5, coder: coder) }
  it 'display leaves list' do
    visit root_path

    feature_login(coder)

    visit leaves_path

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content coder.name
  end
end
