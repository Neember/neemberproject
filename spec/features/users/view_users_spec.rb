require 'rails_helper'

describe 'View Users' do
  before { create_list(:user, 5) }

  it 'display users list' do
    visit users_path

    expect(page).to have_content 'Users List'
    expect(page).to have_content 'Martin'
  end
end
