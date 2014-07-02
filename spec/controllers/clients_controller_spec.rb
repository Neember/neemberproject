require 'rails_helper'

describe ClientsController do
  describe 'GET #index' do
    before { create_list(:client, 3) }

    def do_request
      get :index
    end

    it 'fetches all clients and render index view' do
      do_request

      expect(assigns(:clients).size).to be == 3
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    def do_request
      get :new
    end

    it 'renders new template' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:client_param) { attributes_for(:client) }

    def do_request
      post :create, client: client_param
    end

    context 'success' do
      it 'creates a new client' do
        do_request
        expect(response).to redirect_to clients_path
        expect(flash[:notice]).to be == 'New client added successfully'
      end
    end

    context 'failed' do
      let(:client_param) { attributes_for(:client, first_name: '') }

      it 'displays error and renders new template' do
        do_request
        expect(response).to render_template :new
        expect(flash[:alert]).to be == 'Failed to create client'
      end
    end
  end
end
