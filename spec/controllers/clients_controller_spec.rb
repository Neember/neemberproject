require 'rails_helper'

describe ClientsController do
  describe 'GET #index' do
    before { create_list(:client, 3) }

    it 'fetches all clients and render index view' do
      get :index

      expect(assigns(:clients).size).to be == 3
      expect(response).to render_template :index
    end
  end
end
