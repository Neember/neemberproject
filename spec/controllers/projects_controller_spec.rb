require 'rails_helper'

describe ProjectsController do
  describe 'GET #index' do
    let!(:projects) { create_list(:project, 5) }

    def do_request
      get :index
    end

    it 'View Projects List' do
      do_request

      expect(response).to render_template :index
      expect(assigns(:projects).size).to eq 5
    end
  end
end
