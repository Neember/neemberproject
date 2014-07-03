require 'rails_helper'

describe "View Projects List" do
  let! (:projects) { create_list(:project, 5) }
  it 'display projects list' do
    visit projects_path

    expect(page).to have_content 'Projects List'
    expect(page).to have_content 'DaDaDee'
  end
end
